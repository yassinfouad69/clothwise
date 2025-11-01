import 'package:flutter_test/flutter_test.dart';
import 'package:clothwise/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:clothwise/src/features/home/domain/entities/weather.dart';
import 'package:clothwise/src/features/home/domain/entities/outfit.dart';

void main() {
  group('HomeRepositoryImpl', () {
    late HomeRepositoryImpl repository;

    setUp(() {
      repository = HomeRepositoryImpl();
    });

    group('getCurrentWeather', () {
      test('should return weather data', () async {
        // Act
        final weather = await repository.getCurrentWeather();

        // Assert
        expect(weather, isA<Weather>());
        expect(weather.temperature, equals(33.0));
        expect(weather.city, equals('Cairo'));
        expect(weather.season, equals(Season.summer));
      });

      test('should cache weather data on subsequent calls', () async {
        // Act
        final weather1 = await repository.getCurrentWeather();
        final weather2 = await repository.getCurrentWeather();

        // Assert
        expect(weather1, equals(weather2));
      });
    });

    group('getTodayOutfit', () {
      test('should return outfit with all required items', () async {
        // Act
        final outfit = await repository.getTodayOutfit();

        // Assert
        expect(outfit, isA<Outfit>());
        expect(outfit.topwear, isNotNull);
        expect(outfit.bottomwear, isNotNull);
        expect(outfit.footwear, isNotNull);
        expect(outfit.harmonyScore, greaterThanOrEqualTo(0.85));
        expect(outfit.harmonyScore, lessThanOrEqualTo(1.0));
      });

      test('should cache outfit on subsequent calls', () async {
        // Act
        final outfit1 = await repository.getTodayOutfit();
        final outfit2 = await repository.getTodayOutfit();

        // Assert
        expect(outfit1.id, equals(outfit2.id));
      });

      test('should include reasoning for outfit', () async {
        // Act
        final outfit = await repository.getTodayOutfit();

        // Assert
        expect(outfit.reasons, isNotEmpty);
        expect(outfit.reasons.length, equals(3));
        expect(
          outfit.reasons.any((r) => r.type == ReasonType.weather),
          isTrue,
        );
        expect(
          outfit.reasons.any((r) => r.type == ReasonType.color),
          isTrue,
        );
        expect(
          outfit.reasons.any((r) => r.type == ReasonType.usage),
          isTrue,
        );
      });
    });

    group('getNewOutfit', () {
      test('should return a different outfit than cached', () async {
        // Arrange
        final outfit1 = await repository.getTodayOutfit();

        // Act
        final outfit2 = await repository.getNewOutfit();

        // Assert
        expect(outfit2, isA<Outfit>());
        expect(outfit2.id, isNot(equals(outfit1.id)));
      });

      test('should clear cache and generate new outfit', () async {
        // Arrange
        await repository.getTodayOutfit();

        // Act
        final newOutfit = await repository.getNewOutfit();
        final cachedOutfit = await repository.getTodayOutfit();

        // Assert
        expect(cachedOutfit.id, equals(newOutfit.id));
      });
    });

    group('getSuggestedItems', () {
      test('should return list of suggested outfits', () async {
        // Act
        final suggestions = await repository.getSuggestedItems();

        // Assert
        expect(suggestions, isA<List<Outfit>>());
        expect(suggestions.length, greaterThan(0));
      });

      test('each suggestion should have required items', () async {
        // Act
        final suggestions = await repository.getSuggestedItems();

        // Assert
        for (final outfit in suggestions) {
          expect(outfit.topwear, isNotNull);
          expect(outfit.bottomwear, isNotNull);
          expect(outfit.footwear, isNotNull);
          expect(outfit.harmonyScore, greaterThanOrEqualTo(0.0));
          expect(outfit.harmonyScore, lessThanOrEqualTo(1.0));
        }
      });
    });
  });
}
