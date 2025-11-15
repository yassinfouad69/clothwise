import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clothwise/src/app/router.dart';
import 'package:clothwise/src/app/theme/app_theme.dart';
import 'package:clothwise/src/app/theme/theme_provider.dart';

/// Root application widget
class ClothWiseApp extends ConsumerWidget {
  const ClothWiseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'ClothWise',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: appRouter,
      builder: (context, child) {
        // Set status bar style based on current theme
        final isDark = Theme.of(context).brightness == Brightness.dark;
        SystemChrome.setSystemUIOverlayStyle(
          isDark ? AppTheme.darkStatusBarStyle : AppTheme.lightStatusBarStyle,
        );

        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling, // Prevent user text scaling
          ),
          child: child!,
        );
      },
    );
  }
}
