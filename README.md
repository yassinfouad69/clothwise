# ClothWise

**AI-powered outfit recommendation app** - Get smart outfit suggestions based on weather, manage your wardrobe, and shop for missing pieces.

## 🎯 Features

- **Splash & Onboarding** - Beautiful introduction to the app
- **AI Outfit Recommendations** - Daily outfit suggestions based on weather
- **Wardrobe Management** - Organize and classify your clothing
- **Smart Shopping** - Discover gaps in your wardrobe
- **User Profile** - Customize preferences and settings

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── src/
│   ├── app/           # App-level configuration (router, theme)
│   ├── core/          # Shared utilities and constants
│   ├── features/      # Feature modules (data/domain/presentation)
│   └── widgets/       # Reusable UI components
```

### Tech Stack

- **Framework**: Flutter 3.x / Dart 3.x
- **State Management**: Riverpod (hooks_riverpod)
- **Routing**: go_router with typed routes
- **Theme**: Custom ThemeExtension with design system tokens
- **HTTP**: dio (prepared for API integration)
- **Local Storage**: hive
- **i18n**: intl (EN/AR support ready)
- **Testing**: golden_toolkit, widget tests, unit tests

## 🎨 Design System

### Colors
- **Primary**: `#4A3428` (Dark Brown)
- **Accent**: `#8B6F47` (Medium Brown)
- **Background**: `#EAE0D5` (Warm Beige)
- **Card Background**: `#FFFFFF` (White)

### Typography
- **Font Family**: Inter
- **Weights**: Regular (400), Medium (500), SemiBold (600), Bold (700)

### Spacing
- Consistent 4dp grid system
- Card radius: 16dp
- Button radius: 12dp

## 🚀 Getting Started

### Prerequisites
- Flutter SDK >=3.2.0
- Dart SDK >=3.2.0

### Installation

1. **Install dependencies**
   ```bash
   flutter pub get
   ```

2. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Screens Overview

### Implemented (STEP 3: HOME FEATURE ✅)

1. **Splash Screen** - Welcome with logo and Get Started/Sign In options
2. **Onboarding** - 3-page carousel explaining features
3. **Login** - Simple username/password authentication
4. **Home** - ✨ **Fully functional** with real data, loading/error states, shuffle outfit
5. **Outfit Details** - ✨ **Fully functional** with dynamic outfit data from Home
6. **Wardrobe** - Grid view of clothing items with filters (placeholder data)
7. **Shop** - Shopping suggestions based on wardrobe gaps (placeholder data)
8. **Profile** - User stats and settings (placeholder data)
9. **Settings Modal** - App configuration drawer (placeholder)

### Navigation

- **Bottom Navigation Bar**: Home | Wardrobe | Shop | Profile
- **Deep Linking**: Supported via go_router
- **Type-safe Routes**: All routes are strongly typed

## 🧪 Testing

### Test Coverage (STEP 4 ✅)

**✅ 17 Tests Passing**

- **1 Golden Test** - Home outfit card screenshot comparison
- **6 Widget Tests** - UI component behavior verification
- **9 Unit Tests** - Business logic & repository tests
- **1 Integration Test** - Full app smoke test

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Update golden files (after UI changes)
flutter test --update-goldens
```

### Test Files Created

- `test/helpers/pump_app.dart` - Test helper utilities
- `test/features/home/data/repositories/home_repository_test.dart` - **9 unit tests**
- `test/features/home/presentation/widgets/outfit_card_test.dart` - **6 widget tests**
- `test/features/home/golden/home_screen_golden_test.dart` - **1 golden test**

## 🎯 Next Steps (Phase 3)

1. **Implement Data Layer**
   - Create repository implementations
   - Add fake data sources
   - Setup Hive local storage

2. **Add Real Data**
   - Outfit generation logic
   - Weather API integration
   - Wardrobe CRUD operations

3. **Golden Tests**
   - Screenshot tests for main screens

4. **i18n**
   - English and Arabic translations

## 🛠️ Available Commands

```bash
# Get dependencies
flutter pub get

# Run app
flutter run

# Analyze code
flutter analyze

# Format code
dart format lib/ test/

# Run tests
flutter test
```

## 📝 Code Style

- **Linting**: `flutter_lints` + `very_good_analysis`
- **Const Constructors**: Used wherever possible
- **Null Safety**: Full null-safety enabled

---

**Built with ❤️ using Flutter**
