import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:clothwise/src/app/theme/app_colors.dart';
import 'package:clothwise/src/app/theme/app_spacing.dart';
import 'package:clothwise/src/app/theme/app_text_styles.dart';
import 'package:clothwise/src/features/recommendations/presentation/recommendations_screen.dart';

/// Home screen - Upload photo for outfit recommendations
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null && mounted) {
        // Navigate to recommendations screen
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RecommendationsScreen(
              imagePath: image.path,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error selecting image: $e')),
        );
      }
    }
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (photo != null && mounted) {
        // Navigate to recommendations screen
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RecommendationsScreen(
              imagePath: photo.path,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error taking photo: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/logo.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.primaryBrown,
                      child: const Center(
                        child: Icon(
                          Icons.dry_cleaning,
                          size: 22,
                          color: AppColors.cardBackground,
                        ),
                      ),
                    );
                  },
                ),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: AppSpacing.lg),

            // Title
            const Text(
              'Upload Your Photo',
              style: AppTextStyles.h2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),

            // Subtitle
            Text(
              'Get personalized outfit recommendations',
              style: AppTextStyles.bodyRegular.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.xl),

            // Gallery Option
            _UploadOption(
              icon: Icons.photo_library_outlined,
              title: 'Choose from Gallery',
              subtitle: 'Upload a photo from your device',
              onTap: _pickFromGallery,
            ),

            const SizedBox(height: AppSpacing.lg),

            // Camera Option
            _UploadOption(
              icon: Icons.camera_alt_outlined,
              title: 'Scan with Camera',
              subtitle: 'Take a photo using your camera',
              onTap: _takePhoto,
            ),

            const SizedBox(height: AppSpacing.md),

            // Supported formats
            Text(
              'JPG, JPEG, PNG supported',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppSpacing.xl),

            // Last Outfits Section
            const _LastOutfitsSection(),
          ],
        ),
      ),
    );
  }
}

/// Upload option card widget
class _UploadOption extends StatefulWidget {
  const _UploadOption({
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
  State<_UploadOption> createState() => _UploadOptionState();
}

class _UploadOptionState extends State<_UploadOption>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      child: Container(
        width: double.infinity,
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
            // Multiple Animated Blobs Container
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: MultiBlobPainter(
                            animation: _controller,
                            color: AppColors.primaryBrown.withValues(alpha: 0.15),
                          ),
                          size: Size.infinite,
                        );
                      },
                    ),
                    Center(
                      child: Icon(
                        widget.icon,
                        size: 40,
                        color: AppColors.primaryBrown,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              widget.title,
              style: AppTextStyles.h3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              widget.subtitle,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Last outfits section widget
class _LastOutfitsSection extends StatelessWidget {
  const _LastOutfitsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.history,
              size: 20,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'Last Outfits You Chose',
              style: AppTextStyles.sectionHeader,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
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
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image placeholder
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.borderLight,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(AppSpacing.cardRadius),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          index == 0
                              ? Icons.checkroom
                              : index == 1
                                  ? Icons.business_center
                                  : Icons.sports_basketball,
                          size: 48,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            index == 0
                                ? 'Casual Outfit'
                                : index == 1
                                    ? 'Business Meeting'
                                    : index == 2
                                        ? 'Sport Casual'
                                        : 'Evening Wear',
                            style: AppTextStyles.itemName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: AppSpacing.xs),
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
                            child: Text(
                              index == 0
                                  ? 'Casual'
                                  : index == 1
                                      ? 'Formal'
                                      : 'Sport',
                              style: const TextStyle(fontSize: 10),
                            ),
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

/// Custom painter for multiple animated blob shapes
class MultiBlobPainter extends CustomPainter {
  MultiBlobPainter({
    required this.animation,
    required this.color,
  });

  final Animation<double> animation;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate opacity with fade in/out effect
    final t = animation.value;
    final opacity = _calculateOpacity(t);

    final paint = Paint()
      ..color = color.withValues(alpha: color.a * opacity)
      ..style = PaintingStyle.fill;

    // Define multiple blobs with different sizes and speeds
    final blobs = [
      _BlobConfig(
        startX: 0.2,
        startY: 0.3,
        radiusScale: 0.15,
        speedX: 1.0,
        speedY: 1.2,
        phase: 0.0,
      ),
      _BlobConfig(
        startX: 0.7,
        startY: 0.2,
        radiusScale: 0.12,
        speedX: -0.8,
        speedY: 1.5,
        phase: 2.0,
      ),
      _BlobConfig(
        startX: 0.5,
        startY: 0.7,
        radiusScale: 0.18,
        speedX: 1.3,
        speedY: -0.9,
        phase: 4.0,
      ),
      _BlobConfig(
        startX: 0.15,
        startY: 0.75,
        radiusScale: 0.1,
        speedX: -1.1,
        speedY: -1.0,
        phase: 1.5,
      ),
      _BlobConfig(
        startX: 0.8,
        startY: 0.65,
        radiusScale: 0.14,
        speedX: 0.9,
        speedY: -1.3,
        phase: 3.0,
      ),
      _BlobConfig(
        startX: 0.35,
        startY: 0.45,
        radiusScale: 0.11,
        speedX: -1.2,
        speedY: 1.1,
        phase: 5.0,
      ),
    ];

    for (final config in blobs) {
      _drawBlob(canvas, size, paint, config);
    }
  }

  // Calculate opacity with smooth fade in/out at loop boundaries
  double _calculateOpacity(double t) {
    const fadeLength = 0.15; // Fade over first/last 15% of animation

    if (t < fadeLength) {
      // Fade in at start
      return t / fadeLength;
    } else if (t > 1.0 - fadeLength) {
      // Fade out at end
      return (1.0 - t) / fadeLength;
    } else {
      // Full opacity in middle
      return 1.0;
    }
  }

  void _drawBlob(Canvas canvas, Size size, Paint paint, _BlobConfig config) {
    // Use smooth 0-1 animation value for seamless looping
    final t = animation.value;
    final time = t * 2 * math.pi;

    // Calculate moving position with smooth looping
    final centerX = size.width *
        (config.startX +
            0.15 * math.sin(time * config.speedX + config.phase));
    final centerY = size.height *
        (config.startY +
            0.15 * math.cos(time * config.speedY + config.phase));
    final center = Offset(centerX, centerY);

    final baseRadius = math.min(size.width, size.height) * config.radiusScale;

    final path = Path();

    // Create organic blob shape with smooth looping
    const points = 8;
    for (int i = 0; i <= points; i++) {
      final angle = (i / points) * 2 * math.pi;

      // Add morphing variation with smoother frequencies
      final variation1 = math.sin(time * 2 + i + config.phase) * 0.15;
      final variation2 = math.cos(time * 3 + i * 1.2 + config.phase) * 0.1;
      final r = baseRadius * (1.0 + variation1 + variation2);

      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        // Smooth curves between points
        final prevAngle = ((i - 1) / points) * 2 * math.pi;
        final prevVariation1 = math.sin(time * 2 + (i - 1) + config.phase) * 0.15;
        final prevVariation2 =
            math.cos(time * 3 + (i - 1) * 1.2 + config.phase) * 0.1;
        final prevR = baseRadius * (1.0 + prevVariation1 + prevVariation2);

        final midAngle = (prevAngle + angle) / 2;
        final midR = (prevR + r) / 2 * 1.15;
        final cpX = center.dx + midR * math.cos(midAngle);
        final cpY = center.dy + midR * math.sin(midAngle);

        path.quadraticBezierTo(cpX, cpY, x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(MultiBlobPainter oldDelegate) => true;
}

/// Configuration for individual blob
class _BlobConfig {
  _BlobConfig({
    required this.startX,
    required this.startY,
    required this.radiusScale,
    required this.speedX,
    required this.speedY,
    required this.phase,
  });

  final double startX;
  final double startY;
  final double radiusScale;
  final double speedX;
  final double speedY;
  final double phase;
}
