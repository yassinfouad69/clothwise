import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:clothwise/src/app/theme/app_colors.dart';
import 'package:clothwise/src/app/theme/app_spacing.dart';
import 'package:clothwise/src/app/theme/app_text_styles.dart';
import 'package:clothwise/src/features/home/domain/entities/clothing_item.dart';
import 'package:clothwise/src/features/wardrobe/presentation/providers/wardrobe_providers.dart';
import 'package:clothwise/src/widgets/app_button.dart';
import 'package:clothwise/src/widgets/app_text_field.dart';

class AddItemScreen extends ConsumerStatefulWidget {
  const AddItemScreen({super.key});

  @override
  ConsumerState<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends ConsumerState<AddItemScreen> {
  File? _imageFile;
  final _nameController = TextEditingController();
  final _colorController = TextEditingController();
  ClothingCategory _selectedCategory = ClothingCategory.topwear;
  ClothingUsage _selectedUsage = ClothingUsage.casual;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _nameController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (photo != null) {
        setState(() {
          _imageFile = File(photo.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error taking photo: $e')),
        );
      }
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        setState(() {
          _imageFile = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: AppColors.primaryBrown),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: AppColors.primaryBrown),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickFromGallery();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveItem() async {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add a photo')),
      );
      return;
    }

    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter item name')),
      );
      return;
    }

    if (_colorController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter color')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await ref.read(wardrobeNotifierProvider.notifier).addItem(
            imageFile: _imageFile!,
            name: _nameController.text.trim(),
            category: _selectedCategory,
            color: _colorController.text.trim(),
            usage: _selectedUsage,
          );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item added successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
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
        title: const Text('Add New Item', style: AppTextStyles.appTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image preview/capture
            GestureDetector(
              onTap: _showImageSourceDialog,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                  border: Border.all(color: AppColors.borderLight, width: 2),
                ),
                child: _imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                        child: Image.file(
                          _imageFile!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_a_photo,
                            size: 64,
                            color: AppColors.textTertiary,
                          ),
                          SizedBox(height: AppSpacing.sm),
                          Text(
                            'Tap to add photo',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Item name
            AppTextField(
              controller: _nameController,
              hintText: 'Item name (e.g., Blue Denim Shirt)',
              labelText: 'Name',
            ),

            const SizedBox(height: AppSpacing.md),

            // Color
            AppTextField(
              controller: _colorController,
              hintText: 'Color (e.g., Blue, Red, Black)',
              labelText: 'Color',
            ),

            const SizedBox(height: AppSpacing.md),

            // Category
            const Text(
              'Category',
              style: AppTextStyles.sectionHeader,
            ),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.sm,
              children: ClothingCategory.values.map((category) {
                return ChoiceChip(
                  label: Text(category.displayName),
                  selected: _selectedCategory == category,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                  backgroundColor: AppColors.cardBackground,
                  selectedColor: AppColors.primaryBrown,
                  labelStyle: AppTextStyles.badge.copyWith(
                    color: _selectedCategory == category
                        ? AppColors.cardBackground
                        : AppColors.textPrimary,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: AppSpacing.md),

            // Usage
            const Text(
              'Usage',
              style: AppTextStyles.sectionHeader,
            ),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.sm,
              children: ClothingUsage.values.map((usage) {
                return ChoiceChip(
                  label: Text(usage.displayName),
                  selected: _selectedUsage == usage,
                  onSelected: (selected) {
                    setState(() {
                      _selectedUsage = usage;
                    });
                  },
                  backgroundColor: AppColors.cardBackground,
                  selectedColor: AppColors.primaryBrown,
                  labelStyle: AppTextStyles.badge.copyWith(
                    color: _selectedUsage == usage
                        ? AppColors.cardBackground
                        : AppColors.textPrimary,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: AppSpacing.xl),

            // Save button
            AppButton(
              label: _isLoading ? 'Saving...' : 'Save Item',
              onPressed: _isLoading ? null : _saveItem,
            ),
          ],
        ),
      ),
    );
  }
}
