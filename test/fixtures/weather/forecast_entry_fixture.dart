import 'package:weather_app/core/data/models/weather/forecast_entry_model.dart';
import 'package:weather_app/core/domain/entities/weather/forecast_entry_entity.dart';

import 'cloud_status_fixture.dart';
import 'weather_conditions_fixture.dart';
import 'weather_status_fixture.dart';
import 'wind_status_fixture.dart';

abstract class ForecastEntryFixture {
  static ForecastEntryEntity entity() => ForecastEntryEntity(
        weather: [WeatherStatusFixture.entity()],
        clouds: CloudStatusFixture.entity(),
        wind: WindStatusFixture.entity(),
        visibility: 10000,
        dateTime: DateTime(2025, 5, 16, 12),
        conditions: WeatherConditionsFixture.entity(),
      );

  static ForecastEntryModel model() => ForecastEntryModel(
        weather: [WeatherStatusFixture.entity()],
        clouds: CloudStatusFixture.entity(),
        wind: WindStatusFixture.entity(),
        visibility: 10000,
        dateTime: DateTime(2025, 5, 16, 12),
        conditions: WeatherConditionsFixture.entity(),
      );

  static Map<String, dynamic> json() => {
        'dt': 1747396800,
        'main': WeatherConditionsFixture.json(),
        'weather': [WeatherStatusFixture.json()],
        'clouds': CloudStatusFixture.json(),
        'wind': WindStatusFixture.json(),
        'visibility': 10000,
        'pop': 0,
        'sys': {'pod': 'd'},
        'dt_txt': '2025-05-16 12:00:00',
      };
}
