import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clothwise/src/app/theme/app_colors.dart';
import 'package:clothwise/src/app/theme/app_text_styles.dart';
import 'package:clothwise/src/app/theme/app_spacing.dart';

/// ClothWise theme configuration
/// Currently supports light mode only (dark mode can be added later)
class AppTheme {
  // Status bar style configuration for light mode
  static const SystemUiOverlayStyle lightStatusBarStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.white, // White status bar
    statusBarIconBrightness: Brightness.dark, // Dark icons
    statusBarBrightness: Brightness.light, // For iOS
    systemNavigationBarColor: Colors.white, // White bottom navigation bar
    systemNavigationBarIconBrightness: Brightness.dark, // Dark navigation icons
  );

  // Status bar style configuration for dark mode
  static const SystemUiOverlayStyle darkStatusBarStyle = SystemUiOverlayStyle(
    statusBarColor: AppColors.backgroundDark, // Black status bar
    statusBarIconBrightness: Brightness.light, // Light icons (off-white)
    statusBarBrightness: Brightness.dark, // For iOS
    systemNavigationBarColor: AppColors.backgroundDark, // Black bottom navigation bar
    systemNavigationBarIconBrightness: Brightness.light, // Light navigation icons
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: AppColors.background,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryBrown,
        secondary: AppColors.accentBrown,
        surface: AppColors.cardBackground,
        error: AppColors.error,
        onPrimary: AppColors.cardBackground,
        onSecondary: AppColors.cardBackground,
        onSurface: AppColors.textPrimary,
        onError: AppColors.cardBackground,
      ),

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.appTitle,
        iconTheme: IconThemeData(
          color: AppColors.primaryBrown,
          size: 24,
        ),
        systemOverlayStyle: lightStatusBarStyle,
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.cardBackground,
        elevation: AppSpacing.elevationMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        ),
        margin: const EdgeInsets.all(0),
        shadowColor: AppColors.shadowMedium,
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBrown,
          foregroundColor: AppColors.cardBackground,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
          minimumSize: const Size(double.infinity, AppSpacing.buttonHeight),
          textStyle: AppTextStyles.buttonLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryBrown,
          side: const BorderSide(
            color: AppColors.primaryBrown,
            width: 1.5,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
          minimumSize: const Size(double.infinity, AppSpacing.buttonHeight),
          textStyle: AppTextStyles.buttonMedium,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryBrown,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          textStyle: AppTextStyles.buttonMedium,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.borderLight,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.borderLight,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.primaryBrown,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1.5,
          ),
        ),
        hintStyle: AppTextStyles.bodyRegular.copyWith(
          color: AppColors.textTertiary,
        ),
        labelStyle: AppTextStyles.bodyRegular,
        errorStyle: AppTextStyles.caption.copyWith(
          color: AppColors.error,
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.cardBackground,
        selectedItemColor: AppColors.navActive,
        unselectedItemColor: AppColors.navInactive,
        selectedLabelStyle: AppTextStyles.navLabel,
        unselectedLabelStyle: AppTextStyles.navLabel,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.cardBackground,
        selectedColor: AppColors.summerBadgeBg,
        disabledColor: AppColors.borderLight,
        labelStyle: AppTextStyles.badge,
        secondaryLabelStyle: AppTextStyles.badge,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
          side: const BorderSide(
            color: AppColors.borderLight,
            width: 1,
          ),
        ),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.primaryBrown,
        size: 24,
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.h1,
        displayMedium: AppTextStyles.h2,
        displaySmall: AppTextStyles.h3,
        headlineLarge: AppTextStyles.appTitle,
        headlineMedium: AppTextStyles.sectionHeader,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyRegular,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.buttonLarge,
        labelMedium: AppTextStyles.buttonMedium,
        labelSmall: AppTextStyles.badge,
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryBrown,
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        elevation: AppSpacing.elevationModal,
        titleTextStyle: AppTextStyles.h3,
        contentTextStyle: AppTextStyles.bodyRegular,
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryBrown,
        foregroundColor: AppColors.cardBackground,
        elevation: 4,
      ),
    );
  }

  // Dark theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: AppColors.backgroundDark,
      brightness: Brightness.dark,

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryBrownDark,
        secondary: AppColors.accentBrownDark,
        surface: AppColors.cardBackgroundDark,
        error: AppColors.errorDark,
        onPrimary: AppColors.backgroundDark,
        onSecondary: AppColors.backgroundDark,
        onSurface: AppColors.textPrimaryDark,
        onError: AppColors.backgroundDark,
      ),

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryDark,
        ),
        iconTheme: IconThemeData(
          color: AppColors.primaryBrownDark,
          size: 24,
        ),
        systemOverlayStyle: darkStatusBarStyle,
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.cardBackgroundDark,
        elevation: AppSpacing.elevationMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        ),
        margin: const EdgeInsets.all(0),
        shadowColor: AppColors.shadowMediumDark,
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBrownDark,
          foregroundColor: AppColors.backgroundDark,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
          minimumSize: const Size(double.infinity, AppSpacing.buttonHeight),
          textStyle: AppTextStyles.buttonLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryBrownDark,
          side: const BorderSide(
            color: AppColors.primaryBrownDark,
            width: 1.5,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
          minimumSize: const Size(double.infinity, AppSpacing.buttonHeight),
          textStyle: AppTextStyles.buttonMedium,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryBrownDark,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          textStyle: AppTextStyles.buttonMedium,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardBackgroundDark,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.borderLightDark,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.borderLightDark,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.primaryBrownDark,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.errorDark,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.errorDark,
            width: 1.5,
          ),
        ),
        hintStyle: AppTextStyles.bodyRegular.copyWith(
          color: AppColors.textTertiaryDark,
        ),
        labelStyle: AppTextStyles.bodyRegular.copyWith(
          color: AppColors.textSecondaryDark,
        ),
        errorStyle: AppTextStyles.caption.copyWith(
          color: AppColors.errorDark,
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.cardBackgroundDark,
        selectedItemColor: AppColors.navActiveDark,
        unselectedItemColor: AppColors.navInactiveDark,
        selectedLabelStyle: AppTextStyles.navLabel,
        unselectedLabelStyle: AppTextStyles.navLabel,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.cardBackgroundDark,
        selectedColor: AppColors.summerBadgeBgDark,
        disabledColor: AppColors.borderLightDark,
        labelStyle: AppTextStyles.badge.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        secondaryLabelStyle: AppTextStyles.badge.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
          side: const BorderSide(
            color: AppColors.borderLightDark,
            width: 1,
          ),
        ),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerDark,
        thickness: 1,
        space: 1,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.primaryBrownDark,
        size: 24,
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTextStyles.h1.copyWith(color: AppColors.textPrimaryDark),
        displayMedium: AppTextStyles.h2.copyWith(color: AppColors.textPrimaryDark),
        displaySmall: AppTextStyles.h3.copyWith(color: AppColors.textPrimaryDark),
        headlineLarge: AppTextStyles.appTitle.copyWith(color: AppColors.textPrimaryDark),
        headlineMedium: AppTextStyles.sectionHeader.copyWith(color: AppColors.textPrimaryDark),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimaryDark),
        bodyMedium: AppTextStyles.bodyRegular.copyWith(color: AppColors.textPrimaryDark),
        bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondaryDark),
        labelLarge: AppTextStyles.buttonLarge,
        labelMedium: AppTextStyles.buttonMedium,
        labelSmall: AppTextStyles.badge,
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryBrownDark,
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.modalBackgroundDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        elevation: AppSpacing.elevationModal,
        titleTextStyle: AppTextStyles.h3.copyWith(color: AppColors.textPrimaryDark),
        contentTextStyle: AppTextStyles.bodyRegular.copyWith(color: AppColors.textPrimaryDark),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryBrownDark,
        foregroundColor: AppColors.backgroundDark,
        elevation: 4,
      ),
    );
  }
}
