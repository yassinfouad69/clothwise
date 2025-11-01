import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:clothwise/src/features/splash/presentation/splash_screen.dart';
import 'package:clothwise/src/features/splash/presentation/onboarding_screen.dart';
import 'package:clothwise/src/features/auth/presentation/login_screen.dart';
import 'package:clothwise/src/features/home/presentation/home_screen.dart';
import 'package:clothwise/src/features/outfit/presentation/outfit_details_screen.dart';
import 'package:clothwise/src/features/wardrobe/presentation/wardrobe_screen.dart';
import 'package:clothwise/src/features/shop/presentation/shop_screen.dart';
import 'package:clothwise/src/features/profile/presentation/profile_screen.dart';
import 'package:clothwise/src/widgets/app_scaffold.dart';

/// Route paths
abstract class RoutePaths {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String home = '/home';
  static const String outfitDetails = '/outfit/:id';
  static const String wardrobe = '/wardrobe';
  static const String shop = '/shop';
  static const String profile = '/profile';
}

/// Route names
abstract class RouteNames {
  static const String splash = 'splash';
  static const String onboarding = 'onboarding';
  static const String login = 'login';
  static const String home = 'home';
  static const String outfitDetails = 'outfit-details';
  static const String wardrobe = 'wardrobe';
  static const String shop = 'shop';
  static const String profile = 'profile';
}

/// Global navigation key for accessing router from anywhere
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey =
    GlobalKey<NavigatorState>();

/// GoRouter configuration
final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: RoutePaths.splash,
  debugLogDiagnostics: true,
  routes: [
    // Splash & Onboarding (no bottom nav)
    GoRoute(
      path: RoutePaths.splash,
      name: RouteNames.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RoutePaths.onboarding,
      name: RouteNames.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: RoutePaths.login,
      name: RouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),

    // Main app with bottom navigation
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) {
        return AppScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: RoutePaths.home,
          name: RouteNames.home,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          path: RoutePaths.wardrobe,
          name: RouteNames.wardrobe,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const WardrobeScreen(),
          ),
        ),
        GoRoute(
          path: RoutePaths.shop,
          name: RouteNames.shop,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ShopScreen(),
          ),
        ),
        GoRoute(
          path: RoutePaths.profile,
          name: RouteNames.profile,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const ProfileScreen(),
          ),
        ),
      ],
    ),

    // Outfit Details (full screen, outside shell)
    GoRoute(
      path: RoutePaths.outfitDetails,
      name: RouteNames.outfitDetails,
      builder: (context, state) {
        final outfitId = state.pathParameters['id'] ?? '1';
        return OutfitDetailsScreen(outfitId: outfitId);
      },
    ),
  ],
);
