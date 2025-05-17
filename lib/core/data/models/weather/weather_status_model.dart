import 'package:weather_app/core/domain/entities/weather/weather_status_entity.dart';

class WeatherStatusModel extends WeatherStatusEntity {
  const WeatherStatusModel({
    required super.id,
    required super.name,
    required super.description,
    required super.icon,
  });

  factory WeatherStatusModel.fromJson(final Map<String, dynamic> json) {
    return WeatherStatusModel(
      id: json['id'] as int,
      name: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'main': name,
      'description': description,
      'icon': icon,
    };
  }

  WeatherStatusModel copyWith({
    final int? id,
    final String? name,
    final String? description,
    final String? icon,
  }) {
    return WeatherStatusModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
    );
  }

  WeatherStatusEntity toEntity() {
    return WeatherStatusEntity(
      id: id,
      name: name,
      description: description,
      icon: icon,
    );
  }
}
