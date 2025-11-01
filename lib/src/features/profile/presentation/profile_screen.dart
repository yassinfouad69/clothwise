import 'package:flutter/material.dart';
import 'package:clothwise/src/app/theme/app_colors.dart';
import 'package:clothwise/src/app/theme/app_spacing.dart';
import 'package:clothwise/src/app/theme/app_text_styles.dart';
import 'package:clothwise/src/features/profile/presentation/settings_modal.dart';

/// Profile screen (Screens 13-14) - User stats and settings
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Settings', style: AppTextStyles.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              _showSettingsModal(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            // Profile header card
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadowMedium,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Avatar and name
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.primaryBrown,
                        child: Icon(
                          Icons.person,
                          color: AppColors.cardBackground,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Fashion Enthusiast',
                              style: AppTextStyles.h3,
                            ),
                            SizedBox(height: AppSpacing.xs),
                            Text(
                              'Member since Oct 2024',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Stats row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('42', 'Items'),
                      Container(
                        width: 1,
                        height: 40,
                        color: AppColors.divider,
                      ),
                      _buildStatItem('18', 'Outfits'),
                      Container(
                        width: 1,
                        height: 40,
                        color: AppColors.divider,
                      ),
                      _buildStatItem('92%', 'Style Score'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Gender preference
            _buildSettingCard(
              context,
              icon: Icons.person_outline,
              title: 'Gender',
              child: _GenderToggle(),
            ),

            const SizedBox(height: AppSpacing.md),

            // Default city
            _buildSettingCard(
              context,
              icon: Icons.location_on_outlined,
              title: 'Default City',
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Cairo',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Temperature unit
            _buildSettingCard(
              context,
              icon: Icons.thermostat_outlined,
              title: 'Temperature Unit',
              child: Row(
                children: [
                  Expanded(
                    child: ChoiceChip(
                      label: const Text('°C'),
                      selected: true,
                      onSelected: (selected) {},
                      backgroundColor: AppColors.cardBackground,
                      selectedColor: AppColors.primaryBrown,
                      labelStyle: AppTextStyles.badge.copyWith(
                        color: AppColors.cardBackground,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: ChoiceChip(
                      label: const Text('Celsius'),
                      selected: false,
                      onSelected: (selected) {},
                      backgroundColor: AppColors.cardBackground,
                      selectedColor: AppColors.primaryBrown,
                      labelStyle: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Deterministic seed
            _buildSettingCard(
              context,
              icon: Icons.tag_outlined,
              title: 'Deterministic Seed',
              child: const TextField(
                decoration: InputDecoration(
                  hintText: '42',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Color harmony
            _buildSettingCard(
              context,
              icon: Icons.palette_outlined,
              title: 'Color Harmony',
              child: Wrap(
                spacing: AppSpacing.sm,
                children: [
                  ChoiceChip(
                    label: const Text('Complementary'),
                    selected: false,
                    onSelected: (selected) {},
                  ),
                  ChoiceChip(
                    label: const Text('Analogous'),
                    selected: false,
                    onSelected: (selected) {},
                  ),
                  ChoiceChip(
                    label: const Text('Triadic'),
                    selected: false,
                    onSelected: (selected) {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Auto mode badge
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBrown,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: const Text(
                      'Auto',
                      style: TextStyle(
                        color: AppColors.cardBackground,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  const Expanded(
                    child: Text(
                      'Determines how outfit colors are matched together',
                      style: AppTextStyles.caption,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Data Management section
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Data Management',
                style: AppTextStyles.sectionHeader,
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Export wardrobe button
            OutlinedButton.icon(
              onPressed: () {
                // TODO: Export wardrobe
              },
              icon: const Icon(Icons.download_outlined, size: 20),
              label: const Text('Export Wardrobe as CSV'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            // Clear wardrobe button
            OutlinedButton.icon(
              onPressed: () {
                // TODO: Clear wardrobe with confirmation
              },
              icon: const Icon(Icons.delete_outline, size: 20),
              label: const Text('Clear Wardrobe'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.error),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.h2,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: AppTextStyles.caption,
        ),
      ],
    );
  }

  Widget _buildSettingCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: AppColors.textSecondary),
              const SizedBox(width: AppSpacing.sm),
              Text(title, style: AppTextStyles.sectionHeader),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          child,
        ],
      ),
    );
  }

  void _showSettingsModal(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SettingsModal(),
    );
  }
}

class _GenderToggle extends StatefulWidget {
  @override
  State<_GenderToggle> createState() => _GenderToggleState();
}

class _GenderToggleState extends State<_GenderToggle> {
  String _selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedGender = 'Male';
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _selectedGender == 'Male'
                      ? AppColors.primaryBrown
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: Text(
                  'Male',
                  style: AppTextStyles.buttonMedium.copyWith(
                    color: _selectedGender == 'Male'
                        ? AppColors.cardBackground
                        : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedGender = 'Female';
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _selectedGender == 'Female'
                      ? AppColors.femaleColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
                child: Text(
                  'Female',
                  style: AppTextStyles.buttonMedium.copyWith(
                    color: _selectedGender == 'Female'
                        ? AppColors.cardBackground
                        : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
