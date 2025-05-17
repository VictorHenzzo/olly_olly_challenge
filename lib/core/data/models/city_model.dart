import 'package:weather_app/core/data/models/position_model.dart';
import 'package:weather_app/core/domain/entities/city_entity.dart';
import 'package:weather_app/core/domain/entities/position_entity.dart';

class CityModel extends CityEntity {
  const CityModel({
    required super.id,
    required super.name,
    required super.position,
    required super.country,
    required super.population,
    required super.timezone,
    required super.sunrise,
    required super.sunset,
  });

  factory CityModel.fromJson(final Map<String, dynamic> json) {
    final positionJson = json['coord'] as Map<String, dynamic>;

    return CityModel(
      id: json['id'].toString(),
      name: json['name'] as String,
      position: PositionModel.fromJson(positionJson).toEntity(),
      country: json['country'] as String,
      population: json['population'] as int,
      timezone: json['timezone'] as int,
      sunrise: json['sunrise'] as int,
      sunset: json['sunset'] as int,
    );
  }

  CityModel copyWith({
    final String? id,
    final String? name,
    final PositionEntity? position,
    final String? country,
    final int? population,
    final int? timezone,
    final int? sunrise,
    final int? sunset,
  }) {
    return CityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      country: country ?? this.country,
      population: population ?? this.population,
      timezone: timezone ?? this.timezone,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
    );
  }

  CityEntity toEntity() {
    return CityEntity(
      id: id,
      name: name,
      position: position,
      country: country,
      population: population,
      timezone: timezone,
      sunrise: sunrise,
      sunset: sunset,
    );
  }
}
