import 'package:equatable/equatable.dart';
import 'package:weather_app/core/domain/entities/weather/cloud_status_entity.dart';
import 'package:weather_app/core/domain/entities/weather/weather_conditions_entity.dart';
import 'package:weather_app/core/domain/entities/weather/weather_status_entity.dart';
import 'package:weather_app/core/domain/entities/weather/wind_status_entity.dart';

class CurrentWeatherEntity extends Equatable {
  const CurrentWeatherEntity({
    required this.conditions,
    required this.wind,
    required this.clouds,
    required this.weather,
    required this.visibility,
  });

  final WeatherConditionsEntity conditions;
  final WindStatusEntity wind;
  final CloudStatusEntity clouds;
  final List<WeatherStatusEntity> weather;
  final double visibility;

  @override
  List<Object?> get props => [conditions, wind, clouds, weather, visibility];
}
