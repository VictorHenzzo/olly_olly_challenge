import 'package:weather_app/core/domain/entities/position_entity.dart';

class PositionModel extends PositionEntity {
  const PositionModel({
    required super.latitude,
    required super.longitude,
  });

  factory PositionModel.empty() => const PositionModel(
        latitude: 0,
        longitude: 0,
      );

  factory PositionModel.fromEntity(final PositionEntity entity) =>
      PositionModel(
        latitude: entity.latitude,
        longitude: entity.longitude,
      );

  factory PositionModel.fromJson(final Map<String, dynamic> json) =>
      PositionModel(
        latitude: (json['lat'] as num).toDouble(),
        longitude: (json['lon'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  PositionModel copyWith({
    final double? latitude,
    final double? longitude,
  }) =>
      PositionModel(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  PositionEntity toEntity() => PositionEntity(
        latitude: latitude,
        longitude: longitude,
      );
}
