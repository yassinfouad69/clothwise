import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clothwise/src/features/home/domain/entities/clothing_item.dart';
import 'package:clothwise/src/features/wardrobe/data/repositories/wardrobe_repository.dart';

/// Provider for wardrobe repository
final wardrobeRepositoryProvider = Provider<WardrobeRepository>((ref) {
  return WardrobeRepository();
});

/// Provider for wardrobe items list
final wardrobeItemsProvider =
    FutureProvider<List<ClothingItem>>((ref) async {
  final repository = ref.watch(wardrobeRepositoryProvider);
  return repository.getWardrobeItems();
});

/// State notifier for managing wardrobe state
class WardrobeNotifier extends StateNotifier<AsyncValue<List<ClothingItem>>> {
  final WardrobeRepository _repository;

  WardrobeNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadItems();
  }

  Future<void> loadItems() async {
    state = const AsyncValue.loading();
    try {
      final items = await _repository.getWardrobeItems();
      state = AsyncValue.data(items);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> addItem({
    required dynamic imageFile,
    required String name,
    required ClothingCategory category,
    required String color,
    required ClothingUsage usage,
  }) async {
    try {
      await _repository.addClothingItem(
        imageFile: imageFile,
        name: name,
        category: category,
        color: color,
        usage: usage,
      );
      await loadItems();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteItem(ClothingItem item) async {
    try {
      await _repository.deleteClothingItem(item);
      await loadItems();
    } catch (e) {
      rethrow;
    }
  }
}

/// Provider for wardrobe notifier
final wardrobeNotifierProvider =
    StateNotifierProvider<WardrobeNotifier, AsyncValue<List<ClothingItem>>>(
        (ref) {
  final repository = ref.watch(wardrobeRepositoryProvider);
  return WardrobeNotifier(repository);
});
