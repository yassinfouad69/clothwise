import 'dart:io';
import 'package:clothwise/src/features/home/domain/entities/clothing_item.dart';
import 'package:clothwise/src/features/wardrobe/data/datasources/wardrobe_supabase_datasource.dart';
import 'package:uuid/uuid.dart';

/// Repository for managing wardrobe items
class WardrobeRepository {
  final WardrobeSupabaseDatasource _datasource;

  WardrobeRepository({WardrobeSupabaseDatasource? datasource})
      : _datasource = datasource ?? WardrobeSupabaseDatasource();

  /// Add new clothing item with image
  Future<ClothingItem> addClothingItem({
    required File imageFile,
    required String name,
    required ClothingCategory category,
    required String color,
    required ClothingUsage usage,
  }) async {
    try {
      // Generate ID
      final id = const Uuid().v4();

      // Upload image
      final imageUrl = await _datasource.uploadItemImage(imageFile);

      // Save metadata
      await _datasource.saveClothingItem(
        id: id,
        name: name,
        category: category,
        color: color,
        usage: usage,
        imageUrl: imageUrl,
      );

      return ClothingItem(
        id: id,
        name: name,
        category: category,
        color: color,
        usage: usage,
        imageUrl: imageUrl,
      );
    } catch (e) {
      throw Exception('Failed to add clothing item: $e');
    }
  }

  /// Get all wardrobe items
  Future<List<ClothingItem>> getWardrobeItems() async {
    try {
      final items = await _datasource.getWardrobeItems();

      return items.map((item) {
        return ClothingItem(
          id: item['id'] as String,
          name: item['name'] as String,
          category: ClothingCategory.values.firstWhere(
            (e) => e.name == item['category'],
          ),
          color: item['color'] as String,
          usage: ClothingUsage.values.firstWhere(
            (e) => e.name == item['usage'],
          ),
          imageUrl: item['image_url'] as String?,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch wardrobe items: $e');
    }
  }

  /// Delete clothing item
  Future<void> deleteClothingItem(ClothingItem item) async {
    try {
      await _datasource.deleteClothingItem(item.id, item.imageUrl ?? '');
    } catch (e) {
      throw Exception('Failed to delete clothing item: $e');
    }
  }
}
