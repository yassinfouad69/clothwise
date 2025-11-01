import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:clothwise/src/app/theme/app_colors.dart';
import 'package:clothwise/src/app/theme/app_spacing.dart';
import 'package:clothwise/src/app/theme/app_text_styles.dart';
import 'package:clothwise/src/features/home/domain/entities/outfit.dart';
import 'package:clothwise/src/features/home/domain/entities/weather.dart';
import 'package:clothwise/src/features/home/presentation/providers/home_providers.dart';
import 'package:clothwise/src/widgets/app_loading.dart';
import 'package:clothwise/src/widgets/app_error.dart';

/// Home screen - Daily outfit recommendation (Screens 5-6)
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final outfitAsync = ref.watch(outfitNotifierProvider);
    final weatherAsync = ref.watch(weatherProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.checkroom,
                size: 20,
                color: AppColors.primaryBrown,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const Text('ClothWise', style: AppTextStyles.appTitle),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // TODO: Show settings modal
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(outfitNotifierProvider);
          ref.invalidate(weatherProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Weather & Outfit Card
              weatherAsync.when(
                data: (weather) => outfitAsync.when(
                  data: (outfit) => _WeatherOutfitCard(
                    weather: weather,
                    outfit: outfit,
                    onWearThis: () {
                      context.push('/outfit/${outfit.id}');
                    },
                    onShuffle: () {
                      ref.read(outfitNotifierProvider.notifier).shuffleOutfit();
                    },
                  ),
                  loading: () => const _LoadingCard(),
                  error: (error, stack) => AppError(
                    message: error.toString(),
                    onRetry: () {
                      ref.invalidate(outfitNotifierProvider);
                    },
                  ),
                ),
                loading: () => const _LoadingCard(),
                error: (error, stack) => AppError(
                  message: 'Failed to load weather data',
                  onRetry: () {
                    ref.invalidate(weatherProvider);
                  },
                ),
              ),

              const SizedBox(height: AppSpacing.xl),
              const _QuickActionsSection(),
              const SizedBox(height: AppSpacing.xl),
              _SuggestedItemsSection(ref: ref),
            ],
          ),
        ),
      ),
    );
  }
}

/// Loading placeholder for outfit card
class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: const Center(child: AppLoading()),
    );
  }
}

class _WeatherOutfitCard extends StatelessWidget {
  const _WeatherOutfitCard({
    required this.weather,
    required this.outfit,
    required this.onWearThis,
    required this.onShuffle,
  });

  final Weather weather;
  final Outfit outfit;
  final VoidCallback onWearThis;
  final VoidCallback onShuffle;

  @override
  Widget build(BuildContext context) {
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
          // Temperature and location
          Row(
            children: [
              Text(
                '${weather.temperature.toInt()}°C',
                style: AppTextStyles.temperature,
              ),
              const SizedBox(width: AppSpacing.sm),
              const Spacer(),
              // Outfit preview grid (simplified)
              SizedBox(
                width: 120,
                height: 80,
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                    4,
                    (index) => Container(
                      decoration: BoxDecoration(
                        color: index == 2
                            ? AppColors.blueAccent
                            : AppColors.borderLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.xs),

          // Location
          Text(weather.city, style: AppTextStyles.location),

          const SizedBox(height: AppSpacing.sm),

          // Season badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.summerBadgeBg,
              borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.wb_sunny,
                  size: 14,
                  color: AppColors.summerBadgeText,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  weather.season.displayName,
                  style: AppTextStyles.badge.copyWith(
                    color: AppColors.summerBadgeText,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Harmony indicator
          Center(
            child: Column(
              children: [
                Text(
                  outfit.harmonyScore.toStringAsFixed(2),
                  style: AppTextStyles.h2,
                ),
                const SizedBox(height: AppSpacing.xs),
                const Text(
                  'Harmony',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onWearThis,
                  child: const Text('Wear this'),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onShuffle,
                  icon: const Icon(Icons.shuffle, size: 16),
                  label: const Text('Shuffle outfit'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActionsSection extends StatelessWidget {
  const _QuickActionsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Quick Actions', style: AppTextStyles.sectionHeader),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            _QuickActionButton(
              icon: Icons.photo_camera_outlined,
              label: 'Classify Item',
              onPressed: () {},
            ),
            _QuickActionButton(
              icon: Icons.add_photo_alternate_outlined,
              label: 'Add Photo',
              onPressed: () {},
            ),
            _QuickActionButton(
              icon: Icons.upload_file_outlined,
              label: 'Import CSV',
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryBrown,
        backgroundColor: AppColors.cardBackground,
        side: const BorderSide(color: AppColors.borderLight),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        textStyle: AppTextStyles.buttonMedium.copyWith(fontSize: 12),
      ),
    );
  }
}

class _SuggestedItemsSection extends ConsumerWidget {
  const _SuggestedItemsSection({required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Suggested Items', style: AppTextStyles.sectionHeader),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                width: 140,
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
                    // Image placeholder
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                        color: AppColors.borderLight,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(AppSpacing.cardRadius),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Item Name',
                            style: AppTextStyles.itemName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.sm,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.borderLight,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Casual',
                                  style: TextStyle(fontSize: 10),
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
            },
          ),
        ),
      ],
    );
  }
}
