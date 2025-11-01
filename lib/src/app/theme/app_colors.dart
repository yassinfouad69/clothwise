import 'package:flutter/material.dart';

/// ClothWise color palette extracted from Figma designs
abstract class AppColors {
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
}
