# ClothWise - Development TODO List

**Last Updated:** After STEP 4 (Tests Complete)
**Status:** Home feature fully implemented with tests ✅

---

## 📊 **Current Progress**

### ✅ COMPLETED (Steps 1-4)

- [x] **STEP 1: PLAN** - Architecture, dependencies, folder structure
- [x] **STEP 2: SCAFFOLD** - Theme, routing, base components, all screens (placeholders)
- [x] **STEP 3: HOME FEATURE** - End-to-end Home → Outfit Details with real data
- [x] **STEP 4: TESTS** - Golden tests, widget tests, unit tests (17 tests passing)

**Lines of Code:** ~3,500+
**Test Coverage:** Unit, Widget, Golden tests
**Architecture:** Clean Architecture with Riverpod

---

## 🎯 **REMAINING WORK**

### **Priority 1: Core Features** (High Priority)

#### **1. Wardrobe Feature**
**Estimated Time:** 3-4 hours
**Priority:** HIGH
**Current State:** Placeholder UI only

**Tasks:**
- [ ] Create ClothingItem CRUD operations (1.5h)
  - Add new clothing item
  - Edit existing item
  - Delete item
  - View item details
- [ ] Implement Hive local storage (1h)
  - Setup Hive boxes
  - CRUD persistence
  - Data migration
- [ ] Add category filtering logic (0.5h)
  - Filter by category (Topwear, Bottomwear, etc.)
  - Filter by usage (Casual, Formal, Sport)
  - Filter by color
- [ ] Implement search functionality (0.5h)
  - Search by item name
  - Debounced search input
- [ ] Add photo upload flow (optional, 0.5h)
  - Image picker integration
  - Store image locally or upload to cloud

**Files to Create/Modify:**
- `lib/src/features/wardrobe/domain/repositories/wardrobe_repository.dart`
- `lib/src/features/wardrobe/data/datasources/wardrobe_local_datasource.dart`
- `lib/src/features/wardrobe/data/repositories/wardrobe_repository_impl.dart`
- `lib/src/features/wardrobe/presentation/providers/wardrobe_providers.dart`
- `lib/src/features/wardrobe/presentation/wardrobe_screen.dart` (update)
- `lib/src/features/wardrobe/presentation/add_item_screen.dart` (new)
- `lib/src/features/wardrobe/presentation/edit_item_screen.dart` (new)

---

#### **2. Shop Feature**
**Estimated Time:** 2-3 hours
**Priority:** MEDIUM
**Current State:** Placeholder UI only

**Tasks:**
- [ ] Implement gap analysis logic (1h)
  - Analyze wardrobe for missing categories
  - Analyze missing colors per category
  - Generate recommendations
- [ ] Create shopping suggestions provider (0.5h)
  - Riverpod provider for shop data
  - Link to wardrobe data
- [ ] Add price filter functionality (0.5h)
  - Budget, Mid-range, Premium filters
  - Filter UI already exists
- [ ] Mock Amazon product integration (1h)
  - Create fake product data source
  - Product model with price, image, description
  - "View" button navigation (optional)

**Files to Create/Modify:**
- `lib/src/features/shop/domain/entities/product.dart`
- `lib/src/features/shop/domain/repositories/shop_repository.dart`
- `lib/src/features/shop/data/datasources/shop_fake_datasource.dart`
- `lib/src/features/shop/data/repositories/shop_repository_impl.dart`
- `lib/src/features/shop/presentation/providers/shop_providers.dart`
- `lib/src/features/shop/presentation/shop_screen.dart` (update)

---

#### **3. Profile Feature**
**Estimated Time:** 2 hours
**Priority:** MEDIUM
**Current State:** Placeholder UI only

**Tasks:**
- [ ] Implement user preferences persistence (1h)
  - Save/load default city
  - Save/load temperature unit
  - Save/load gender preference
  - Save/load color harmony mode
- [ ] Add export wardrobe functionality (0.5h)
  - Export to CSV
  - Generate file with item list
- [ ] Implement clear wardrobe with confirmation (0.5h)
  - Show confirmation dialog
  - Clear all items from Hive

**Files to Create/Modify:**
- `lib/src/features/profile/domain/repositories/profile_repository.dart`
- `lib/src/features/profile/data/datasources/profile_local_datasource.dart`
- `lib/src/features/profile/data/repositories/profile_repository_impl.dart`
- `lib/src/features/profile/presentation/providers/profile_providers.dart`
- `lib/src/features/profile/presentation/profile_screen.dart` (update)

---

### **Priority 2: Enhancement Features** (Medium Priority)

#### **4. Settings Modal**
**Estimated Time:** 1 hour
**Priority:** LOW
**Current State:** Placeholder modal exists

**Tasks:**
- [ ] Implement actual settings functionality (0.5h)
  - Navigate to account settings
  - Navigate to style preferences
  - Navigate to notification settings
- [ ] Add demo views (optional, 0.5h)
  - View classify result demo
  - View empty states demo

**Files to Modify:**
- `lib/src/features/profile/presentation/settings_modal.dart`

---

#### **5. Internationalization (i18n)**
**Estimated Time:** 2-3 hours
**Priority:** MEDIUM
**Current State:** intl package installed, no translations

**Tasks:**
- [ ] Setup ARB files (0.5h)
  - Create `app_en.arb`
  - Create `app_ar.arb`
- [ ] Generate localization code (0.5h)
  - Run code generation
  - Setup AppLocalizations
- [ ] Extract all hardcoded strings (1h)
  - Replace with localization keys
  - ~50-100 strings to translate
- [ ] Add RTL support for Arabic (1h)
  - Test layout in RTL mode
  - Fix any layout issues

**Files to Create:**
- `lib/l10n/app_en.arb`
- `lib/l10n/app_ar.arb`
- `lib/src/core/localization/app_localizations.dart` (generated)

---

#### **6. Additional Tests**
**Estimated Time:** 2-3 hours
**Priority:** MEDIUM
**Current State:** 17 tests for Home feature

**Tasks:**
- [ ] Add unit tests for Wardrobe repository (1h)
- [ ] Add widget tests for Wardrobe screen (1h)
- [ ] Add golden test for Outfit Details screen (0.5h)
- [ ] Add integration tests for navigation (0.5h)

**Target:** 30+ total tests

---

### **Priority 3: Polish & Optimization** (Low Priority)

#### **7. Performance Optimization**
**Estimated Time:** 1-2 hours

**Tasks:**
- [ ] Add image caching improvements
- [ ] Optimize list builders with `const` constructors
- [ ] Add pagination for large wardrobes
- [ ] Profile app performance

---

#### **8. Error Handling & Edge Cases**
**Estimated Time:** 1 hour

**Tasks:**
- [ ] Add network error handling (when connecting real API)
- [ ] Add validation for user inputs
- [ ] Handle empty wardrobe states properly
- [ ] Add retry mechanisms

---

#### **9. UI Polish**
**Estimated Time:** 2-3 hours

**Tasks:**
- [ ] Add animations/transitions
- [ ] Add haptic feedback
- [ ] Improve loading states
- [ ] Add empty state illustrations
- [ ] Dark mode support (when designs available)

---

## 📈 **TOTAL EFFORT ESTIMATE**

### **By Priority:**

| Priority | Features | Estimated Hours |
|----------|----------|-----------------|
| **HIGH** | Wardrobe Feature | 3-4h |
| **MEDIUM** | Shop Feature | 2-3h |
| **MEDIUM** | Profile Feature | 2h |
| **MEDIUM** | i18n (EN/AR) | 2-3h |
| **MEDIUM** | Additional Tests | 2-3h |
| **LOW** | Settings Modal | 1h |
| **LOW** | Performance | 1-2h |
| **LOW** | Error Handling | 1h |
| **LOW** | UI Polish | 2-3h |

**Total Minimum:** 16 hours
**Total Maximum:** 22 hours
**Realistic Estimate:** 18-20 hours for complete app

### **Phase-wise Breakdown:**

**Phase 1 (Core MVP):** 7-9 hours
- Wardrobe CRUD (3-4h)
- Shop Gap Analysis (2-3h)
- Profile Settings (2h)

**Phase 2 (Enhancement):** 5-7 hours
- i18n Support (2-3h)
- Additional Tests (2-3h)
- Settings Modal (1h)

**Phase 3 (Polish):** 4-6 hours
- Performance (1-2h)
- Error Handling (1h)
- UI Polish (2-3h)

---

## 🚀 **Recommended Next Steps**

### **Option A: Feature Complete (Fastest Path)**
1. Implement Wardrobe CRUD (3-4h)
2. Implement Shop Gap Analysis (2-3h)
3. Implement Profile Settings (2h)
4. **Total: 7-9 hours → Feature-complete app**

### **Option B: Production Ready (Recommended)**
1. Do Option A (7-9h)
2. Add i18n EN/AR (2-3h)
3. Add more tests (2-3h)
4. Polish UI (2h)
5. **Total: 13-17 hours → Production-ready app**

### **Option C: Full Polish (Best Quality)**
1. Do Option B (13-17h)
2. Performance optimization (1-2h)
3. Error handling (1h)
4. Full UI polish (2-3h)
5. **Total: 17-23 hours → Fully polished app**

---

## 📝 **Decision Point**

**Which path do you want to take?**

- **Path A** (7-9h): Core features only, app works end-to-end
- **Path B** (13-17h): Production-ready with i18n and tests ✅ **RECOMMENDED**
- **Path C** (17-23h): Fully polished, optimized, perfect

**Or we can pause here and you can:**
- Test the current app thoroughly
- Gather feedback
- Decide what features are most important
- Continue development later

---

## ✅ **What's Already Done**

- ✅ Complete architecture setup
- ✅ All UI screens (placeholders for Wardrobe/Shop/Profile)
- ✅ Home feature fully functional
- ✅ Outfit details fully functional
- ✅ Navigation working (go_router)
- ✅ Theme system complete
- ✅ 17 tests passing
- ✅ Clean Architecture implemented
- ✅ Riverpod state management
- ✅ Repository pattern
- ✅ Fake data layer ready to swap with real API

**The app is RUNNABLE and TESTABLE right now!** 🎉

---

**Let me know which path you want to take, or if you want to take a break and test what we've built!** 🚀
