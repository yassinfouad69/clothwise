import 'package:flutter/material.dart';

/// ClothWise color palette extracted from Figma designs
abstract class AppColors {
  // LIGHT MODE COLORS

  // Primary Colors
  static const Color background = Color(0xFFEAE0D5); // Warm beige/cream
  static const Color cardBackground = Color(0xFFFFFFFF); // White cards
  static const Color primaryBrown = Color(0xFF4A3428); // Dark brown
  static const Color accentBrown = Color(0xFF8B6F47); // Medium brown

  // Text Colors
  static const Color textPrimary = Color(0xFF4A3428); // Dark brown
  static const Color textSecondary = Color(0xFF8B6F47); // Medium brown
  static const Color textTertiary = Color(0xFF9E9E9E); // Gray hints

  // Accent Colors
  static const Color summerBadgeBg = Color(0xFFFFF3E0); // Light peach
  static const Color summerBadgeText = Color(0xFFE67E22); // Orange
  static const Color blueAccent = Color(0xFF90CAF9); // Light blue (selected items)
  static const Color successGreen = Color(0xFF4CAF50); // Success/harmony indicator

  // Borders & Dividers
  static const Color borderLight = Color(0xFFE0D5C7); // Subtle beige border
  static const Color divider = Color(0xFFF5F5F5);
  static const Color stroke = Color(0xFF4A3428); // Icon strokes

  // Error & Warning
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);

  // Bottom Navigation
  static const Color navActive = primaryBrown;
  static const Color navInactive = Color(0xFF9E9E9E);

  // Gender Toggle
  static const Color maleColor = primaryBrown;
  static const Color femaleColor = Color(0xFFE91E63); // Pink for female

  // Shadows
  static const Color shadowLight = Color(0x0D000000); // 5% black
  static const Color shadowMedium = Color(0x1A000000); // 10% black

  // DARK MODE COLORS

  // Primary Colors (Dark)
  static const Color backgroundDark = Color(0xFF1A1A1A); // Dark charcoal
  static const Color cardBackgroundDark = Color(0xFF2A2A2A); // Elevated gray
  static const Color modalBackgroundDark = Color(0xFF2D2D2D); // Modal surface
  static const Color primaryBrownDark = Color(0xFFB8956A); // Warm tan/camel
  static const Color accentBrownDark = Color(0xFFD4A574); // Light brown/beige

  // Text Colors (Dark)
  static const Color textPrimaryDark = Color(0xFFE8E8E8); // Soft white
  static const Color textSecondaryDark = Color(0xFF9E9E9E); // Medium gray
  static const Color textTertiaryDark = Color(0xFF666666); // Darker gray

  // Accent Colors (Dark)
  static const Color summerBadgeBgDark = Color(0xFF3D3428); // Darker peach
  static const Color summerBadgeTextDark = Color(0xFFFFB74D); // Lighter orange
  static const Color blueAccentDark = Color(0xFF64B5F6); // Brighter blue
  static const Color successGreenDark = Color(0xFF7CB342); // Muted green

  // Borders & Dividers (Dark)
  static const Color borderLightDark = Color(0xFF3A3A3A); // Subtle gray
  static const Color dividerDark = Color(0xFF2F2F2F); // Very subtle
  static const Color strokeDark = Color(0xFFB8956A); // Icon strokes

  // Error & Warning (Dark)
  static const Color errorDark = Color(0xFFE57373); // Soft red
  static const Color warningDark = Color(0xFFFFB74D); // Soft orange

  // Bottom Navigation (Dark)
  static const Color navActiveDark = primaryBrownDark;
  static const Color navInactiveDark = Color(0xFF666666);

  // Gender Toggle (Dark)
  static const Color maleColorDark = primaryBrownDark;
  static const Color femaleColorDark = Color(0xFFF48FB1); // Lighter pink

  // Shadows (Dark)
  static const Color shadowLightDark = Color(0x80000000); // 50% black
  static const Color shadowMediumDark = Color(0x80000000); // 50% black
}
