import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:clothwise/src/core/config/supabase_config.dart';
import 'package:clothwise/src/features/home/domain/entities/clothing_item.dart';
import 'package:uuid/uuid.dart';

/// Data source for wardrobe items using Supabase
class WardrobeSupabaseDatasource {
  final SupabaseClient _supabase;

  WardrobeSupabaseDatasource({SupabaseClient? supabaseClient})
      : _supabase = supabaseClient ?? Supabase.instance.client;

  /// Upload clothing item image to Supabase Storage
  Future<String> uploadItemImage(File imageFile) async {
    try {
      // Generate unique filename
      final uuid = const Uuid();
      final fileExtension = imageFile.path.split('.').last;
      final fileName = '${uuid.v4()}.$fileExtension';
      final filePath = 'items/$fileName';

      // Upload to Supabase Storage
      await _supabase.storage
          .from(SupabaseConfig.wardrobeBucket)
          .upload(filePath, imageFile);

      // Get public URL
      final publicUrl = _supabase.storage
          .from(SupabaseConfig.wardrobeBucket)
          .getPublicUrl(filePath);

      return publicUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  /// Save clothing item metadata to Supabase database
  Future<void> saveClothingItem({
    required String id,
    required String name,
    required ClothingCategory category,
    required String color,
    required ClothingUsage usage,
    required String imageUrl,
  }) async {
    try {
      await _supabase.from('wardrobe_items').insert({
        'id': id,
        'name': name,
        'category': category.name,
        'color': color,
        'usage': usage.name,
        'image_url': imageUrl,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to save clothing item: $e');
    }
  }

  /// Get all wardrobe items
  Future<List<Map<String, dynamic>>> getWardrobeItems() async {
    try {
      final response = await _supabase
          .from('wardrobe_items')
          .select()
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw Exception('Failed to fetch wardrobe items: $e');
    }
  }

  /// Delete clothing item
  Future<void> deleteClothingItem(String id, String imageUrl) async {
    try {
      // Delete from database
      await _supabase.from('wardrobe_items').delete().eq('id', id);

      // Delete image from storage
      final path = imageUrl.split('/').last;
      await _supabase.storage
          .from(SupabaseConfig.wardrobeBucket)
          .remove(['items/$path']);
    } catch (e) {
      throw Exception('Failed to delete clothing item: $e');
    }
  }
}
