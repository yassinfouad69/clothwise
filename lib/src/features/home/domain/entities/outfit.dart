import 'package:equatable/equatable.dart';
import 'package:clothwise/src/features/home/domain/entities/clothing_item.dart';

/// Complete outfit recommendation with harmony score and reasoning
class Outfit extends Equatable {
  const Outfit({
    required this.id,
    required this.topwear,
    required this.bottomwear,
    required this.footwear,
    this.accessory,
    required this.harmonyScore,
    required this.reasons,
    this.alternatives,
  });

  final String id;
  final ClothingItem topwear;
  final ClothingItem bottomwear;
  final ClothingItem footwear;
  final ClothingItem? accessory;
  final double harmonyScore; // 0.0 to 1.0
  final List<OutfitReason> reasons;
  final List<ClothingItem>? alternatives;

  /// Get all items in the outfit (excluding null accessory)
  List<ClothingItem> get allItems {
    final items = [topwear, bottomwear, footwear];
    if (accessory != null) items.add(accessory!);
    return items;
  }

  @override
  List<Object?> get props => [
        id,
        topwear,
        bottomwear,
        footwear,
        accessory,
        harmonyScore,
        reasons,
        alternatives,
      ];
}

/// Reason why an outfit works
class OutfitReason extends Equatable {
  const OutfitReason({
    required this.type,
    required this.title,
    required this.description,
  });

  final ReasonType type;
  final String title;
  final String description;

  @override
  List<Object?> get props => [type, title, description];
}

/// Types of outfit reasoning
enum ReasonType {
  weather,
  color,
  usage;

  String get displayName {
    switch (this) {
      case ReasonType.weather:
        return 'Weather';
      case ReasonType.color:
        return 'Color Harmony';
      case ReasonType.usage:
        return 'Usage';
    }
  }
}
