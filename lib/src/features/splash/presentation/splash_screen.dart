import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:clothwise/src/app/router.dart';
import 'package:clothwise/src/app/theme/app_colors.dart';
import 'package:clothwise/src/app/theme/app_spacing.dart';
import 'package:clothwise/src/app/theme/app_text_styles.dart';
import 'package:clothwise/src/widgets/app_button.dart';

/// Splash screen (Screen 1) - Welcome screen with logo
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Logo container
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                ),
                child: const Icon(
                  Icons.checkroom,
                  size: 56,
                  color: AppColors.primaryBrown,
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // App name
              const Text(
                'ClothWise',
                style: AppTextStyles.h1,
              ),

              const SizedBox(height: AppSpacing.sm),

              // Tagline
              Text(
                'AI outfits, styled for the weather.',
                style: AppTextStyles.tagline,
                textAlign: TextAlign.center,
              ),

              const Spacer(flex: 3),

              // Get Started button
              AppButton(
                label: 'Get Started',
                onPressed: () => context.go(RoutePaths.onboarding),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Sign in text button
              TextButton(
                onPressed: () => context.go(RoutePaths.login),
                child: Text(
                  'Sign in',
                  style: AppTextStyles.buttonMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
