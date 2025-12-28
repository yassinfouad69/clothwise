import 'package:flutter/material.dart';
import 'package:clothwise/src/app/theme/app_colors.dart';
import 'package:clothwise/src/app/theme/app_spacing.dart';
import 'package:clothwise/src/app/theme/app_text_styles.dart';

enum AppButtonType { primary, secondary, text }

/// Reusable button component matching Figma designs
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.isLoading = false,
    this.icon,
    this.fullWidth = true,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final bool isLoading;
  final IconData? icon;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    if (type == AppButtonType.primary) {
      return SizedBox(
        width: fullWidth ? double.infinity : null,
        height: AppSpacing.buttonHeight,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.cardBackground,
                    ),
                  ),
                )
              : _buildButtonContent(),
        ),
      );
    } else if (type == AppButtonType.secondary) {
      return SizedBox(
        width: fullWidth ? double.infinity : null,
        height: AppSpacing.buttonHeight,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryBrown,
                    ),
                  ),
                )
              : _buildButtonContent(),
        ),
      );
    } else {
      return TextButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primaryBrown,
                  ),
                ),
              )
            : _buildButtonContent(),
      );
    }
  }

  Widget _buildButtonContent() {
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Text(label),
        ],
      );
    }
    return Text(label);
  }
}

/// Small icon button (e.g., "Shuffle outfit", "Swap")
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.backgroundColor = AppColors.cardBackground,
    this.foregroundColor = AppColors.primaryBrown,
    super.key,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        side: BorderSide(
          color: foregroundColor.withValues(alpha: 0.3),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        minimumSize: const Size(0, 36),
        textStyle: AppTextStyles.buttonMedium.copyWith(fontSize: 12),
      ),
    );
  }
}
