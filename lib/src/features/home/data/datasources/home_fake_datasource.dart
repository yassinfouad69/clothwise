import 'dart:math';
import 'package:clothwise/src/features/home/domain/entities/clothing_item.dart';
import 'package:clothwise/src/features/home/domain/entities/outfit.dart';
import 'package:clothwise/src/features/home/domain/entities/weather.dart';

/// Fake data source for Home feature
/// Simulates API responses with mock data
class HomeFakeDataSource {
  final _random = Random();

  /// Simulated wardrobe items
  final List<ClothingItem> _wardrobeItems = [
    // Topwear
    const ClothingItem(
      id: 't1',
      name: 'White T-Shirt',
      category: ClothingCategory.topwear,
      color: 'White',
      usage: ClothingUsage.casual,
    ),
    const ClothingItem(
      id: 't2',
      name: 'Cotton Shirt',
      category: ClothingCategory.topwear,
      color: 'Blue',
      usage: ClothingUsage.casual,
    ),
    const ClothingItem(
      id: 't3',
      name: 'Formal Blazer',
      category: ClothingCategory.topwear,
      color: 'Black',
      usage: ClothingUsage.formal,
    ),
    const ClothingItem(
      id: 't4',
      name: 'Polo T-Shirt',
      category: ClothingCategory.topwear,
      color: 'Navy Blue',
      usage: ClothingUsage.casual,
    ),

    // Bottomwear
    const ClothingItem(
      id: 'b1',
      name: 'Beige Shorts',
      category: ClothingCategory.bottomwear,
      color: 'Beige',
      usage: ClothingUsage.casual,
    ),
    const ClothingItem(
      id: 'b2',
      name: 'Denim Jeans',
      category: ClothingCategory.bottomwear,
      color: 'Dark Blue',
      usage: ClothingUsage.casual,
    ),
    const ClothingItem(
      id: 'b3',
      name: 'Formal Trousers',
      category: ClothingCategory.bottomwear,
      color: 'Black',
      usage: ClothingUsage.formal,
    ),
    const ClothingItem(
      id: 'b4',
      name: 'Khaki Chinos',
      category: ClothingCategory.bottomwear,
      color: 'Khaki',
      usage: ClothingUsage.casual,
    ),

    // Footwear
    const ClothingItem(
      id: 'f1',
      name: 'Brown Sandals',
      category: ClothingCategory.footwear,
      color: 'Brown',
      usage: ClothingUsage.casual,
    ),
    const ClothingItem(
      id: 'f2',
      name: 'White Sneakers',
      category: ClothingCategory.footwear,
      color: 'White',
      usage: ClothingUsage.casual,
    ),
    const ClothingItem(
      id: 'f3',
      name: 'Running Shoes',
      category: ClothingCategory.footwear,
      color: 'Black/White',
      usage: ClothingUsage.sport,
    ),
    const ClothingItem(
      id: 'f4',
      name: 'Leather Shoes',
      category: ClothingCategory.footwear,
      color: 'Brown',
      usage: ClothingUsage.formal,
    ),

    // Accessories
    const ClothingItem(
      id: 'a1',
      name: 'Sunglasses',
      category: ClothingCategory.accessory,
      color: 'Black',
      usage: ClothingUsage.casual,
    ),
    const ClothingItem(
      id: 'a2',
      name: 'Watch',
      category: ClothingCategory.accessory,
      color: 'Silver',
      usage: ClothingUsage.casual,
    ),
    const ClothingItem(
      id: 'a3',
      name: 'Leather Belt',
      category: ClothingCategory.accessory,
      color: 'Brown',
      usage: ClothingUsage.formal,
    ),
  ];

  /// Get fake weather data
  Future<Weather> getWeather() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return const Weather(
      temperature: 33.0,
      city: 'Cairo',
      season: Season.summer,
      condition: WeatherCondition.sunny,
    );
  }

  /// Generate a random outfit based on weather
  Future<Outfit> generateOutfit(Weather weather) async {
    // Simulate processing delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Select items based on weather
    final topwear = _getItemByCategory(ClothingCategory.topwear);
    final bottomwear = _getItemByCategory(ClothingCategory.bottomwear);
    final footwear = _getItemByCategory(ClothingCategory.footwear);
    final accessory = _random.nextBool()
        ? _getItemByCategory(ClothingCategory.accessory)
        : null;

    // Generate harmony score
    final harmonyScore = 0.85 + (_random.nextDouble() * 0.15);

    // Create outfit reasoning
    final reasons = [
      OutfitReason(
        type: ReasonType.weather,
        title: 'Weather: ${weather.temperature.toInt()}°C — ${weather.season.displayName}',
        description: 'Perfect temperature for lightweight, breathable fabrics',
      ),
      const OutfitReason(
        type: ReasonType.color,
        title: 'Color: Complementary',
        description: 'Colors work together for a balanced look',
      ),
      OutfitReason(
        type: ReasonType.usage,
        title: 'Usage: ${topwear.usage.displayName}',
        description: 'Comfortable and relaxed for everyday activities',
      ),
    ];

    // Generate alternatives
    final alternatives = _getAlternatives(topwear);

    return Outfit(
      id: 'outfit_${DateTime.now().millisecondsSinceEpoch}',
      topwear: topwear,
      bottomwear: bottomwear,
      footwear: footwear,
      accessory: accessory,
      harmonyScore: harmonyScore,
      reasons: reasons,
      alternatives: alternatives,
    );
  }

  /// Get suggested items (simplified outfits for preview)
  Future<List<Outfit>> getSuggestedItems() async {
    await Future.delayed(const Duration(milliseconds: 600));

    return [
      Outfit(
        id: 'suggestion_1',
        topwear: _wardrobeItems[0], // White T-Shirt
        bottomwear: _wardrobeItems[5], // Denim Jeans
        footwear: _wardrobeItems[9], // White Sneakers
        harmonyScore: 0.88,
        reasons: const [],
      ),
      Outfit(
        id: 'suggestion_2',
        topwear: _wardrobeItems[1], // Cotton Shirt
        bottomwear: _wardrobeItems[7], // Khaki Chinos
        footwear: _wardrobeItems[8], // Brown Sandals
        harmonyScore: 0.91,
        reasons: const [],
      ),
    ];
  }

  // Helper methods

  ClothingItem _getItemByCategory(ClothingCategory category) {
    final items = _wardrobeItems.where((item) => item.category == category).toList();
    return items[_random.nextInt(items.length)];
  }

  List<ClothingItem> _getAlternatives(ClothingItem currentItem) {
    return _wardrobeItems
        .where((item) =>
            item.category == currentItem.category && item.id != currentItem.id)
        .take(4)
        .toList();
  }
}
