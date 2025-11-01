import 'package:equatable/equatable.dart';

/// Represents a single clothing item in the wardrobe
class ClothingItem extends Equatable {
  const ClothingItem({
    required this.id,
    required this.name,
    required this.category,
    required this.color,
    required this.usage,
    this.imageUrl,
  });

  final String id;
  final String name;
  final ClothingCategory category;
  final String color;
  final ClothingUsage usage;
  final String? imageUrl;

  @override
  List<Object?> get props => [id, name, category, color, usage, imageUrl];
}

/// Clothing categories
enum ClothingCategory {
  topwear,
  bottomwear,
  footwear,
  accessory,
  onePiece;

  String get displayName {
    switch (this) {
      case ClothingCategory.topwear:
        return 'Topwear';
      case ClothingCategory.bottomwear:
        return 'Bottomwear';
      case ClothingCategory.footwear:
        return 'Footwear';
      case ClothingCategory.accessory:
        return 'Accessory';
      case ClothingCategory.onePiece:
        return 'One-piece';
    }
  }
}

/// Usage types for clothing
enum ClothingUsage {
  casual,
  formal,
  sport;

  String get displayName {
    switch (this) {
      case ClothingUsage.casual:
        return 'Casual';
      case ClothingUsage.formal:
        return 'Formal';
      case ClothingUsage.sport:
        return 'Sport';
    }
  }
}
