import 'package:equatable/equatable.dart';

/// Represents the current weather conditions including temperature, feels like,
/// minimum and maximum temperatures, pressure, humidity, and various weather statuses.
class WeatherConditionsEntity extends Equatable {
  const WeatherConditionsEntity({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
  });

  /// Current temperature in Fahrenheit
  final double temp;

  /// Temperature that accounts for the human perception of weather
  /// in Fahrenheit
  final double feelsLike;

  /// Minimum temperature at the moment in Fahrenheit
  final double tempMin;

  /// Maximum temperature at the moment in Fahrenheit
  final double tempMax;

  /// Atmospheric pressure in hPa
  final int pressure;

  /// Atmospheric pressure on the sea level in hPa
  final int seaLevel;

  /// Atmospheric pressure on the ground level in hPa
  final int grndLevel;

  /// Humidity percentage
  final int humidity;

  @override
  List<Object?> get props => [
        temp,
        feelsLike,
        tempMin,
        tempMax,
        pressure,
        seaLevel,
        grndLevel,
        humidity,
      ];
}
