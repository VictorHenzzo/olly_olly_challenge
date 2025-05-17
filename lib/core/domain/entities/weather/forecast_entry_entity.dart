import 'package:equatable/equatable.dart';
import 'package:weather_app/core/domain/entities/weather/cloud_status_entity.dart';
import 'package:weather_app/core/domain/entities/weather/weather_conditions_entity.dart';
import 'package:weather_app/core/domain/entities/weather/weather_status_entity.dart';
import 'package:weather_app/core/domain/entities/weather/wind_status_entity.dart';

/// Represents a single forecast entry for a specific date and time.
/// Contains weather conditions, wind, clouds, and visibility for that period.
class ForecastEntryEntity extends Equatable {
  /// Creates a [ForecastEntryEntity] for a given date/time and weather data.
  const ForecastEntryEntity({
    required this.dateTime,
    required this.conditions,
    required this.wind,
    required this.clouds,
    required this.weather,
    required this.visibility,
  });

  /// The date and time of this forecast entry.
  final DateTime dateTime;

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
        dateTime,
        conditions,
        wind,
        clouds,
        weather,
        visibility,
      ];
}

// {
//             "dt": 1747396800,
//             "main": {
//                 "temp": 18.72,
//                 "feels_like": 18.53,
//                 "temp_min": 18.72,
//                 "temp_max": 18.72,
//                 "pressure": 1024,
//                 "sea_level": 1024,
//                 "grnd_level": 933,
//                 "humidity": 72,
//                 "temp_kf": 0
//             },
//             "weather": [
//                 {
//                     "id": 801,
//                     "main": "Clouds",
//                     "description": "few clouds",
//                     "icon": "02d"
//                 }
//             ],
//             "clouds": {
//                 "all": 20
//             },
//             "wind": {
//                 "speed": 1.11,
//                 "deg": 99,
//                 "gust": 3.15
//             },
//             "visibility": 10000,
//             "pop": 0,
//             "sys": {
//                 "pod": "d"
//             },
//             "dt_txt": "2025-05-16 12:00:00"
//         }
