import 'package:olly_olly_challenge/core/data/models/weather/current_weather_model.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/current_weather_entity.dart';

import 'cloud_status_fixture.dart';
import 'weather_conditions_fixture.dart';
import 'weather_status_fixture.dart';
import 'wind_status_fixture.dart';

abstract class CurrentWeatherFixture {
  static CurrentWeatherEntity entity() => CurrentWeatherEntity(
        conditions: WeatherConditionsFixture.entity(),
        visibility: 10000,
        wind: WindStatusFixture.entity(),
        clouds: CloudStatusFixture.entity(),
        weather: [WeatherStatusFixture.entity()],
      );

  static CurrentWeatherModel model() => CurrentWeatherModel(
        conditions: WeatherConditionsFixture.model(),
        visibility: 10000,
        wind: WindStatusFixture.model(),
        clouds: CloudStatusFixture.model(),
        weather: [WeatherStatusFixture.model()],
      );

  static Map<String, dynamic> json() => {
        'weather': [WeatherStatusFixture.json()],
        'base': 'stations',
        'main': WeatherConditionsFixture.json(),
        'visibility': 10000,
        'wind': WindStatusFixture.json(),
        'clouds': CloudStatusFixture.json(),
        'dt': 1747396888,
        'timezone': -10800,
        'id': 3470127,
        'name': 'Belo Horizonte',
        'cod': 200,
      };
}
