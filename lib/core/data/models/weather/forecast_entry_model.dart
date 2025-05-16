import 'package:olly_olly_challenge/core/data/models/weather/cloud_status_model.dart';
import 'package:olly_olly_challenge/core/data/models/weather/weather_conditions_model.dart';
import 'package:olly_olly_challenge/core/data/models/weather/weather_status_model.dart';
import 'package:olly_olly_challenge/core/data/models/weather/wind_status_model.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/cloud_status_entity.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/forecast_entry_entity.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/weather_conditions_entity.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/weather_status_entity.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/wind_status_entity.dart';

class ForecastEntryModel extends ForecastEntryEntity {
  const ForecastEntryModel({
    required super.conditions,
    required super.wind,
    required super.clouds,
    required super.weather,
    required super.visibility,
    required super.dateTime,
  });

  factory ForecastEntryModel.fromJson(final Map<String, dynamic> json) {
    final weatherJson = json['weather'] as List<dynamic>;
    final mainJson = json['main'] as Map<String, dynamic>;
    final windJson = json['wind'] as Map<String, dynamic>;
    final cloudsJson = json['clouds'] as Map<String, dynamic>;

    return ForecastEntryModel(
      conditions: WeatherConditionsModel.fromJson(mainJson).toEntity(),
      wind: WindStatusModel.fromJson(windJson).toEntity(),
      clouds: CloudStatusModel.fromJson(cloudsJson).toEntity(),
      weather: _parseWeathers(weatherJson),
      visibility: (json['visibility'] as num).toDouble(),
      dateTime: DateTime.parse(json['dt_txt'] as String),
    );
  }

  static List<WeatherStatusEntity> _parseWeathers(
    final List<dynamic> weatherJson,
  ) {
    WeatherStatusEntity build(final dynamic weather) =>
        WeatherStatusModel.fromJson(weather as Map<String, dynamic>).toEntity();

    return weatherJson.map(build).toList(growable: false);
  }

  ForecastEntryModel copyWith({
    final WeatherConditionsEntity? conditions,
    final WindStatusEntity? wind,
    final CloudStatusEntity? clouds,
    final List<WeatherStatusEntity>? weather,
    final double? visibility,
    final DateTime? dateTime,
  }) {
    return ForecastEntryModel(
      conditions: conditions ?? this.conditions,
      wind: wind ?? this.wind,
      clouds: clouds ?? this.clouds,
      weather: weather ?? this.weather,
      visibility: visibility ?? this.visibility,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  ForecastEntryEntity toEntity() {
    return ForecastEntryEntity(
      conditions: conditions,
      wind: wind,
      clouds: clouds,
      weather: weather,
      visibility: visibility,
      dateTime: dateTime,
    );
  }
}
