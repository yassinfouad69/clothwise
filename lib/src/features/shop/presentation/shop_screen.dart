import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:clothwise/src/app/router.dart';
import 'package:clothwise/src/app/theme/app_colors.dart';
import 'package:clothwise/src/app/theme/app_spacing.dart';
import 'package:clothwise/src/app/theme/app_text_styles.dart';

/// Shop screen (Screens 11-12) - Shopping suggestions
class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  String _selectedFilter = 'All';

  final List<String> _filters = ['All', 'Budget', 'Mid-range', 'Premium'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text('Shop', style: theme.textTheme.headlineLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              context.go(RoutePaths.profile);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = filter == _selectedFilter;
                return Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: ChoiceChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    backgroundColor: theme.cardTheme.color,
                    selectedColor: theme.colorScheme.primary,
                    labelStyle: AppTextStyles.badge.copyWith(
                      color: isSelected
                          ? theme.colorScheme.onPrimary
                          : theme.textTheme.bodyMedium?.color,
                    ),
                    side: BorderSide(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : (isDarkMode ? AppColors.borderLightDark : AppColors.borderLight),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                  ),
                );
              },
            ),
          ),

          // Shop items list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                // New Article Types section
                Text(
                  'New Article Types',
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                _ShopItemCard(
                  icon: Icons.checkroom_outlined,
                  title: 'Blazers — Navy Blue',
                  subtitle: "You don't have any Bla...",
                  onTap: () {},
                ),
                const SizedBox(height: AppSpacing.sm),
                _ShopItemCard(
                  icon: Icons.checkroom_outlined,
                  title: 'Formal Trousers — ...',
                  subtitle: 'Missing formal bottoms in...',
                  onTap: () {},
                ),
                const SizedBox(height: AppSpacing.sm),
                _ShopItemCard(
                  icon: Icons.checkroom_outlined,
                  title: 'Running Shoes — B...',
                  subtitle: "You don't have any Run...",
                  onTap: () {},
                ),
                const SizedBox(height: AppSpacing.sm),
                _ShopItemCard(
                  icon: Icons.checkroom_outlined,
                  title: 'Leather Belt — Brown',
                  subtitle: 'No belts found in your...',
                  onTap: () {},
                ),

                const SizedBox(height: AppSpacing.xl),

                // New Colors for Existing Types section
                Text(
                  'New Colors for Existing Types',
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                _ShopItemCard(
                  icon: Icons.palette_outlined,
                  title: 'Casual Shirts — Oli...',
                  subtitle: "You don't have any items in...",
                  onTap: () {},
                ),
                const SizedBox(height: AppSpacing.sm),
                _ShopItemCard(
                  icon: Icons.palette_outlined,
                  title: 'Denim Jeans — Light Blue',
                  subtitle: 'Missing Light Blue in yo...',
                  onTap: () {},
                ),
                const SizedBox(height: AppSpacing.sm),
                _ShopItemCard(
                  icon: Icons.palette_outlined,
                  title: 'T-Shirts — Burgundy',
                  subtitle: 'Add variety with Burgundy to...',
                  onTap: () {},
                ),

                const SizedBox(height: AppSpacing.xl),

                // Info card
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                    border: Border.all(
                      color: isDarkMode ? AppColors.borderLightDark : AppColors.borderLight,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary,
                        size: 20,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          'Based on wardrobe gaps',
                          style: AppTextStyles.caption.copyWith(
                            color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShopItemCard extends StatelessWidget {
  const _ShopItemCard({
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
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? AppColors.shadowMediumDark : AppColors.shadowMedium,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  child: Icon(
                    icon,
                    color: theme.colorScheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.itemName.copyWith(
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        subtitle,
                        style: AppTextStyles.caption.copyWith(
                          color: theme.textTheme.bodySmall?.color,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                TextButton(
                  onPressed: onTap,
                  child: const Text('View'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
