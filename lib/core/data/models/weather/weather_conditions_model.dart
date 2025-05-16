import 'package:olly_olly_challenge/core/domain/entities/weather/weather_conditions_entity.dart';

class WeatherConditionsModel extends WeatherConditionsEntity {
  const WeatherConditionsModel({
    required super.temp,
    required super.feelsLike,
    required super.tempMin,
    required super.tempMax,
    required super.pressure,
    required super.seaLevel,
    required super.grndLevel,
    required super.humidity,
  });

  factory WeatherConditionsModel.fromJson(final Map<String, dynamic> json) {
    return WeatherConditionsModel(
      temp: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      tempMin: (json['temp_min'] as num).toDouble(),
      tempMax: (json['temp_max'] as num).toDouble(),
      pressure: json['pressure'] as int,
      seaLevel: json['sea_level'] as int,
      grndLevel: json['grnd_level'] as int,
      humidity: json['humidity'] as int,
    );
  }

  WeatherConditionsModel copyWith({
    final double? temp,
    final double? feelsLike,
    final double? tempMin,
    final double? tempMax,
    final int? pressure,
    final int? seaLevel,
    final int? grndLevel,
    final int? humidity,
  }) {
    return WeatherConditionsModel(
      temp: temp ?? this.temp,
      feelsLike: feelsLike ?? this.feelsLike,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      pressure: pressure ?? this.pressure,
      seaLevel: seaLevel ?? this.seaLevel,
      grndLevel: grndLevel ?? this.grndLevel,
      humidity: humidity ?? this.humidity,
    );
  }

  WeatherConditionsEntity toEntity() {
    return WeatherConditionsEntity(
      temp: temp,
      feelsLike: feelsLike,
      tempMin: tempMin,
      tempMax: tempMax,
      pressure: pressure,
      seaLevel: seaLevel,
      grndLevel: grndLevel,
      humidity: humidity,
    );
  }
}
