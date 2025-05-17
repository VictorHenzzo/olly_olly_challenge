import 'package:equatable/equatable.dart';
import 'package:weather_app/core/domain/entities/position_entity.dart';

/// Represents a city with its geographical and temporal information.
class CityEntity extends Equatable {
  const CityEntity({
    required this.id,
    required this.name,
    required this.position,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  /// City ID
  final String id;

  /// City name
  final String name;

  /// Geographical coordinates of the city
  final PositionEntity position;

  /// Country code (e.g., BR, US, GB)
  final String country;

  /// City population
  final int population;

  /// Shift in seconds from UTC
  final int timezone;

  /// Sunrise time in Unix timestamp (UTC)
  final int sunrise;

  /// Sunset time in Unix timestamp (UTC)
  final int sunset;

  @override
  List<Object?> get props => [
        id,
        name,
        position,
        country,
        population,
        timezone,
        sunrise,
        sunset,
      ];
}
