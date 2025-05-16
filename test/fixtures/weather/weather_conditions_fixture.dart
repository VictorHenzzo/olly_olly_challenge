import 'package:olly_olly_challenge/core/data/models/weather/weather_conditions_model.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/weather_conditions_entity.dart';

abstract class WeatherConditionsFixture {
  static WeatherConditionsEntity entity() => const WeatherConditionsEntity(
        temp: 19.29,
        feelsLike: 19.21,
        tempMin: 19.29,
        tempMax: 19.29,
        pressure: 1024,
        humidity: 74,
        seaLevel: 1024,
        grndLevel: 916,
      );

  static WeatherConditionsModel model() => const WeatherConditionsModel(
        temp: 19.29,
        feelsLike: 19.21,
        tempMin: 19.29,
        tempMax: 19.29,
        pressure: 1024,
        humidity: 74,
        seaLevel: 1024,
        grndLevel: 916,
      );

  static Map<String, dynamic> json() => {
        'temp': 19.29,
        'feels_like': 19.21,
        'temp_min': 19.29,
        'temp_max': 19.29,
        'pressure': 1024,
        'humidity': 74,
        'sea_level': 1024,
        'grnd_level': 916,
      };
}
