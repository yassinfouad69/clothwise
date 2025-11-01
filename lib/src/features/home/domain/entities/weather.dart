import 'package:equatable/equatable.dart';

/// Weather information for outfit recommendations
class Weather extends Equatable {
  const Weather({
    required this.temperature,
    required this.city,
    required this.season,
    required this.condition,
  });

  final double temperature; // in Celsius
  final String city;
  final Season season;
  final WeatherCondition condition;

  @override
  List<Object?> get props => [temperature, city, season, condition];
}

/// Seasons for outfit selection
enum Season {
  summer,
  winter,
  spring,
  autumn;

  String get displayName {
    switch (this) {
      case Season.summer:
        return 'summer';
      case Season.winter:
        return 'winter';
      case Season.spring:
        return 'spring';
      case Season.autumn:
        return 'autumn';
    }
  }
}

/// Weather conditions
enum WeatherCondition {
  sunny,
  cloudy,
  rainy,
  snowy;

  String get displayName {
    switch (this) {
      case WeatherCondition.sunny:
        return 'Sunny';
      case WeatherCondition.cloudy:
        return 'Cloudy';
      case WeatherCondition.rainy:
        return 'Rainy';
      case WeatherCondition.snowy:
        return 'Snowy';
    }
  }
}
