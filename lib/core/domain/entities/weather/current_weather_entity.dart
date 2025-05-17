import 'package:equatable/equatable.dart';
import 'package:weather_app/core/domain/entities/weather/cloud_status_entity.dart';
import 'package:weather_app/core/domain/entities/weather/weather_conditions_entity.dart';
import 'package:weather_app/core/domain/entities/weather/weather_status_entity.dart';
import 'package:weather_app/core/domain/entities/weather/wind_status_entity.dart';

/// Represents the current weather data for a specific location.
/// Contains temperature, wind, cloud, and weather status information.
class CurrentWeatherEntity extends Equatable {
  /// Creates a [CurrentWeatherEntity] with all required weather data.
  const CurrentWeatherEntity({
    required this.conditions,
    required this.wind,
    required this.clouds,
    required this.weather,
    required this.visibility,
  });

  /// Main weather conditions (temperature, pressure, humidity, etc).
  final WeatherConditionsEntity conditions;

  /// Wind status (speed, direction, gust).
  final WindStatusEntity wind;

  /// Cloud coverage information.
  final CloudStatusEntity clouds;

  /// List of weather status (e.g., rain, snow, clear, etc).
  final List<WeatherStatusEntity> weather;

  /// Visibility in meters.
  final double visibility;

  @override
  List<Object?> get props => [
        conditions,
        wind,
        clouds,
        weather,
        visibility,
      ];
}
