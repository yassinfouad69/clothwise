import 'package:flutter/material.dart';
import 'package:clothwise/src/app/theme/app_colors.dart';
import 'package:clothwise/src/app/theme/app_spacing.dart';
import 'package:clothwise/src/app/theme/app_text_styles.dart';

/// Settings modal (Screen 15) - Drawer/modal with app settings
class SettingsModal extends StatelessWidget {
  const SettingsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusLg),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: AppSpacing.md),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                children: [
                  const Icon(Icons.settings, color: AppColors.primaryBrown),
                  const SizedBox(width: AppSpacing.sm),
                  const Text('Settings', style: AppTextStyles.h3),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            const Divider(),

            // Settings items
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                children: [
                  _SettingsItem(
                    icon: Icons.view_carousel_outlined,
                    title: 'Canvas View - All Screens',
                    subtitle: 'View all app screens',
                    onTap: () {
                      // TODO: Navigate to canvas view
                      Navigator.pop(context);
                    },
                  ),
                  _SettingsItem(
                    icon: Icons.photo_library_outlined,
                    title: 'Screen Gallery',
                    subtitle: 'Browse screen designs',
                    onTap: () {
                      // TODO: Navigate to screen gallery
                      Navigator.pop(context);
                    },
                  ),
                  _SettingsItem(
                    icon: Icons.account_circle_outlined,
                    title: 'Account Settings',
                    subtitle: 'Manage your account',
                    onTap: () {
                      // TODO: Navigate to account settings
                      Navigator.pop(context);
                    },
                  ),
                  _SettingsItem(
                    icon: Icons.style_outlined,
                    title: 'Style Preferences',
                    subtitle: 'Customize your style',
                    onTap: () {
                      // TODO: Navigate to style preferences
                      Navigator.pop(context);
                    },
                  ),
                  _SettingsItem(
                    icon: Icons.notifications_outlined,
                    title: 'Notification Settings',
                    subtitle: 'Manage notifications',
                    onTap: () {
                      // TODO: Navigate to notification settings
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(),
                  _SettingsItem(
                    icon: Icons.science_outlined,
                    title: 'View Classify Result (Demo)',
                    subtitle: 'See classification demo',
                    onTap: () {
                      // TODO: Show demo
                      Navigator.pop(context);
                    },
                  ),
                  _SettingsItem(
                    icon: Icons.view_list_outlined,
                    title: 'View Empty States (Demo)',
                    subtitle: 'Preview empty states',
                    onTap: () {
                      // TODO: Show empty states
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.sm),
          ],
        ),
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryBrown),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium,
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.caption,
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textTertiary,
      ),
      onTap: onTap,
    );
  }
}
