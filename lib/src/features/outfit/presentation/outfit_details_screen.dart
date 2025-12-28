import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:clothwise/src/app/theme/app_colors.dart';
import 'package:clothwise/src/app/theme/app_spacing.dart';
import 'package:clothwise/src/app/theme/app_text_styles.dart';
import 'package:clothwise/src/features/home/domain/entities/outfit.dart';
import 'package:clothwise/src/features/home/presentation/providers/home_providers.dart';
import 'package:clothwise/src/widgets/app_error.dart';

/// Outfit details screen (Screens 7-8) - Shows complete outfit breakdown
class OutfitDetailsScreen extends ConsumerWidget {
  const OutfitDetailsScreen({
    required this.outfitId,
    super.key,
  });

  final String outfitId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final outfit = ref.watch(currentOutfitProvider);

    if (outfit == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: const AppError(
          message: 'Outfit not found. Please go back and try again.',
        ),
      );
    }

    return _OutfitDetailsView(outfit: outfit);
  }
}

class _OutfitDetailsView extends StatelessWidget {
  const _OutfitDetailsView({required this.outfit});

  final Outfit outfit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryBrown),
          onPressed: () => context.pop(),
        ),
        title: const Text('Outfit Details', style: AppTextStyles.appTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Outfit items
            _buildOutfitItem(
              context,
              outfit.topwear.category.displayName,
              outfit.topwear.name,
              outfit.topwear.usage.displayName,
              outfit.topwear.color,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildOutfitItem(
              context,
              outfit.bottomwear.category.displayName,
              outfit.bottomwear.name,
              outfit.bottomwear.usage.displayName,
              outfit.bottomwear.color,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildOutfitItem(
              context,
              outfit.footwear.category.displayName,
              outfit.footwear.name,
              outfit.footwear.usage.displayName,
              outfit.footwear.color,
            ),
            if (outfit.accessory != null) ...[
              const SizedBox(height: AppSpacing.md),
              _buildOutfitItem(
                context,
                outfit.accessory!.category.displayName,
                outfit.accessory!.name,
                outfit.accessory!.usage.displayName,
                outfit.accessory!.color,
              ),
            ],

            const SizedBox(height: AppSpacing.xl),

            // Why this works section
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Why this works',
                    style: AppTextStyles.sectionHeader,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ...outfit.reasons.map((reason) {
                    IconData icon;
                    switch (reason.type) {
                      case ReasonType.weather:
                        icon = Icons.wb_sunny;
                      case ReasonType.color:
                        icon = Icons.palette_outlined;
                      case ReasonType.usage:
                        icon = Icons.style_outlined;
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: _buildReasonItem(
                        icon: icon,
                        title: reason.title,
                        description: reason.description,
                        color: AppColors.successGreen,
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Alternatives section
            const Text(
              'Alternatives',
              style: AppTextStyles.sectionHeader,
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: AppSpacing.md),
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
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: index == 2
                                ? Colors.red.shade300
                                : AppColors.borderLight,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(AppSpacing.cardRadius),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(AppSpacing.sm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Alt Item',
                                style: AppTextStyles.itemName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutfitItem(
    BuildContext context,
    String category,
    String name,
    String usage,
    String color,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
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
      child: Row(
        children: [
          // Image placeholder
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.borderLight,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  name,
                  style: AppTextStyles.itemName.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    _buildBadge(usage),
                    const SizedBox(width: AppSpacing.sm),
                    _buildColorDot(color),
                    const SizedBox(width: AppSpacing.xs),
                    Text(color, style: AppTextStyles.caption),
                  ],
                ),
              ],
            ),
          ),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.sync, size: 14),
            label: const Text('Swap'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryBrown,
              side: const BorderSide(color: AppColors.borderLight),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              minimumSize: const Size(0, 32),
              textStyle: const TextStyle(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderLight),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 10),
      ),
    );
  }

  Widget _buildColorDot(String color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: _getColorFromName(color),
        shape: BoxShape.circle,
      ),
    );
  }

  Color _getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'white':
        return Colors.white;
      case 'beige':
        return const Color(0xFFF5F5DC);
      case 'brown':
        return Colors.brown;
      case 'black':
        return Colors.black;
      default:
        return AppColors.borderLight;
    }
  }

  Widget _buildReasonItem({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                description,
                style: AppTextStyles.caption,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
