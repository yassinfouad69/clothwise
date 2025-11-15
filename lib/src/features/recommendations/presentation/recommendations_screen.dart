import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clothwise/src/app/theme/app_colors.dart';
import 'package:clothwise/src/app/theme/app_spacing.dart';
import 'package:clothwise/src/app/theme/app_text_styles.dart';
import 'package:clothwise/src/app/theme/theme_provider.dart';

/// Recommendations screen - Shows AI recommendations based on uploaded item
class RecommendationsScreen extends ConsumerStatefulWidget {
  const RecommendationsScreen({
    required this.imagePath,
    super.key,
  });

  final String imagePath;

  @override
  ConsumerState<RecommendationsScreen> createState() =>
      _RecommendationsScreenState();
}

class _RecommendationsScreenState
    extends ConsumerState<RecommendationsScreen> {
  String _selectedFilter = 'Pants';

  final List<String> _filters = ['Pants', 'Shirts', 'Shoes', 'Accessories'];

  final List<String> _allFilters = [
    'Blazers & Vests',
    'Cardigans & Sweaters',
    'Hoodies & Sweatshirts',
    'Jackets & Coats',
    'Jeans',
    'Pants',
    'Polos',
    'Shirts',
    'Shirts & Blouses',
    'Shorts',
    'Skirts',
    'Suits & Blazers',
    'Sweaters & Cardigans',
    'T-shirts & Tops',
    'Shoes',
    'Accessories',
  ];

  void _showAllFiltersModal() {
    final theme = Theme.of(context);
    final isDarkMode = ref.read(isDarkModeProvider);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppSpacing.radiusLg),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDarkMode ? AppColors.borderLightDark : AppColors.borderLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'All Categories',
                      style: AppTextStyles.h3.copyWith(
                        color: theme.textTheme.headlineSmall?.color,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // Filter list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: _allFilters.length,
                  itemBuilder: (context, index) {
                    final filter = _allFilters[index];
                    final isSelected = filter == _selectedFilter;

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      title: Text(
                        filter,
                        style: AppTextStyles.bodyRegular.copyWith(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.textTheme.bodyLarge?.color,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                      trailing: isSelected
                          ? Icon(
                              Icons.check_circle,
                              color: theme.colorScheme.primary,
                            )
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedFilter = filter;
                        });
                        Navigator.pop(context);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                      tileColor: isSelected
                          ? theme.colorScheme.primary.withValues(alpha: 0.1)
                          : null,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Mock recommendations data
  final List<Map<String, dynamic>> _recommendations = [
    {
      'name': 'Beige Chinos',
      'category': 'Casual',
      'image': 'https://via.placeholder.com/300x400/2C3E50/FFFFFF?text=Beige+Chinos',
    },
    {
      'name': 'Light Gray Trousers',
      'category': 'Formal',
      'image': 'https://via.placeholder.com/300x400/34495E/FFFFFF?text=Gray+Trousers',
    },
    {
      'name': 'Black Jeans',
      'category': 'Casual',
      'image': 'https://via.placeholder.com/300x400/95A5A6/FFFFFF?text=Black+Jeans',
    },
    {
      'name': 'Navy Blue Pants',
      'category': 'Smart Casual',
      'image': 'https://via.placeholder.com/300x400/7F8C8D/FFFFFF?text=Navy+Pants',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = ref.watch(isDarkModeProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Recommendations', style: theme.textTheme.headlineLarge),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Uploaded Item Section
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Uploaded Item',
                    style: AppTextStyles.sectionHeader.copyWith(
                      color: theme.textTheme.headlineMedium?.color,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Center(
                    child: Container(
                      width: 280,
                      height: 280,
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                        boxShadow: [
                          BoxShadow(
                            color: isDarkMode ? AppColors.shadowMediumDark : AppColors.shadowMedium,
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                        child: Image.file(
                          File(widget.imagePath),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 64,
                                color: isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiary,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Filter Recommendations Section
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filter Recommendations',
                    style: AppTextStyles.sectionHeader.copyWith(
                      color: theme.textTheme.headlineMedium?.color,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      ..._filters.map((filter) {
                        final isSelected = filter == _selectedFilter;
                        return ChoiceChip(
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
                        );
                      }),
                      // More button
                      ActionChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('More'),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 18,
                              color: theme.textTheme.bodyMedium?.color,
                            ),
                          ],
                        ),
                        onPressed: _showAllFiltersModal,
                        backgroundColor: theme.cardTheme.color,
                        labelStyle: AppTextStyles.badge.copyWith(
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                        side: BorderSide(
                          color: isDarkMode ? AppColors.borderLightDark : AppColors.borderLight,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Your Personalized Recommendations Section
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Personalized Recommendations',
                    style: AppTextStyles.sectionHeader.copyWith(
                      color: theme.textTheme.headlineMedium?.color,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _recommendations.length,
                    itemBuilder: (context, index) {
                      final item = _recommendations[index];
                      return _RecommendationCard(
                        name: item['name'] as String,
                        category: item['category'] as String,
                        imageUrl: item['image'] as String,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Shuffle recommendations
        },
        backgroundColor: theme.colorScheme.primary,
        child: Icon(Icons.shuffle, color: theme.colorScheme.onPrimary),
      ),
    );
  }
}

/// Recommendation card widget
class _RecommendationCard extends StatelessWidget {
  const _RecommendationCard({
    required this.name,
    required this.category,
    required this.imageUrl,
  });

  final String name;
  final String category;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppSpacing.cardRadius),
            ),
            child: Image.network(
              imageUrl,
              height: 320,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 320,
                  color: isDarkMode ? AppColors.borderLightDark : AppColors.borderLight,
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 64,
                      color: isDarkMode ? AppColors.textTertiaryDark : AppColors.textTertiary,
                    ),
                  ),
                );
              },
            ),
          ),

          // Details
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.h3.copyWith(
                    color: theme.textTheme.headlineSmall?.color,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _getCategoryColor(category),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      category,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isDarkMode ? AppColors.textSecondaryDark : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'casual':
        return Colors.blue;
      case 'formal':
        return Colors.purple;
      case 'smart casual':
        return Colors.orange;
      default:
        return AppColors.primaryBrown;
    }
  }
}
