import 'package:weather_app/core/domain/entities/weather/wind_status_entity.dart';

class WindStatusModel extends WindStatusEntity {
  const WindStatusModel({
    required super.speed,
    required super.deg,
    required super.gust,
  });

  factory WindStatusModel.fromJson(final Map<String, dynamic> json) {
    return WindStatusModel(
      speed: (json['speed'] as num).toDouble(),
      deg: json['deg'] as int,
      gust: (json['gust'] as num).toDouble(),
    );
  }

  WindStatusModel copyWith({
    final double? speed,
    final int? deg,
    final double? gust,
  }) {
    return WindStatusModel(
      speed: speed ?? this.speed,
      deg: deg ?? this.deg,
      gust: gust ?? this.gust,
    );
  }

  WindStatusEntity toEntity() {
    return WindStatusEntity(
      speed: speed,
      deg: deg,
      gust: gust,
    );
  }
}
