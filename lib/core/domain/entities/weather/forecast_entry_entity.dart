import 'package:equatable/equatable.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/cloud_status_entity.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/weather_conditions_entity.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/weather_status_entity.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/wind_status_entity.dart';

class ForecastEntryEntity extends Equatable {
  const ForecastEntryEntity({
    required this.dateTime,
    required this.conditions,
    required this.wind,
    required this.clouds,
    required this.weather,
    required this.visibility,
  });

  final DateTime dateTime;
  final WeatherConditionsEntity conditions;
  final WindStatusEntity wind;
  final CloudStatusEntity clouds;
  final List<WeatherStatusEntity> weather;
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
