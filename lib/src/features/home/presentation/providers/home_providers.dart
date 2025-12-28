import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clothwise/src/features/home/domain/entities/outfit.dart';
import 'package:clothwise/src/features/home/domain/entities/weather.dart';
import 'package:clothwise/src/features/home/domain/repositories/home_repository.dart';
import 'package:clothwise/src/features/home/data/repositories/home_repository_impl.dart';

/// Provider for HomeRepository instance
final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl();
});

/// Provider for current weather
final weatherProvider = FutureProvider<Weather>((ref) async {
  final repository = ref.watch(homeRepositoryProvider);
  return repository.getCurrentWeather();
});

/// Provider for today's outfit
final todayOutfitProvider = FutureProvider<Outfit>((ref) async {
  final repository = ref.watch(homeRepositoryProvider);
  return repository.getTodayOutfit();
});

/// Provider for suggested items
final suggestedItemsProvider = FutureProvider<List<Outfit>>((ref) async {
  final repository = ref.watch(homeRepositoryProvider);
  return repository.getSuggestedItems();
});

/// State notifier for shuffle outfit functionality
class OutfitNotifier extends StateNotifier<AsyncValue<Outfit>> {
  OutfitNotifier(this._repository) : super(const AsyncValue.loading());

  final HomeRepository _repository;

  /// Load initial outfit
  Future<void> loadOutfit() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.getTodayOutfit());
  }

  /// Shuffle to get new outfit
  Future<void> shuffleOutfit() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.getNewOutfit());
  }
}

/// Provider for outfit state with shuffle capability
final outfitNotifierProvider =
    StateNotifierProvider<OutfitNotifier, AsyncValue<Outfit>>((ref) {
  final repository = ref.watch(homeRepositoryProvider);
  final notifier = OutfitNotifier(repository);
  notifier.loadOutfit();
  return notifier;
});

/// Provider for accessing current outfit by ID
/// This allows the outfit details screen to access the outfit data
final currentOutfitProvider = Provider<Outfit?>((ref) {
  final outfitAsync = ref.watch(outfitNotifierProvider);
  return outfitAsync.value;
});
