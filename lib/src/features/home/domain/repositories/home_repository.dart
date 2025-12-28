import 'package:clothwise/src/features/home/domain/entities/outfit.dart';
import 'package:clothwise/src/features/home/domain/entities/weather.dart';

/// Repository interface for Home feature
/// Defines the contract for data operations
abstract class HomeRepository {
  /// Get current weather for the user's location
  Future<Weather> getCurrentWeather();

  /// Get today's recommended outfit based on weather
  Future<Outfit> getTodayOutfit();

  /// Shuffle and get a new outfit recommendation
  Future<Outfit> getNewOutfit();

  /// Get suggested items for the wardrobe
  Future<List<Outfit>> getSuggestedItems();
}
