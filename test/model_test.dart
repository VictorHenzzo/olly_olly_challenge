import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/data/models/city_model.dart';
import 'package:weather_app/core/data/models/position_model.dart';
import 'package:weather_app/core/data/models/weather/cloud_status_model.dart';
import 'package:weather_app/core/data/models/weather/current_weather_model.dart';
import 'package:weather_app/core/data/models/weather/forecast_entry_model.dart';
import 'package:weather_app/core/data/models/weather/forecast_report_model.dart';
import 'package:weather_app/core/data/models/weather/weather_conditions_model.dart';
import 'package:weather_app/core/data/models/weather/weather_status_model.dart';
import 'package:weather_app/core/data/models/weather/wind_status_model.dart';

import 'fixtures/city_fixture.dart';
import 'fixtures/position_fixture.dart';
// Weather fixtures
import 'fixtures/weather/cloud_status_fixture.dart';
import 'fixtures/weather/current_weather_fixture.dart';
import 'fixtures/weather/forecast_entry_fixture.dart';
import 'fixtures/weather/forecast_report_fixture.dart';
import 'fixtures/weather/weather_conditions_fixture.dart';
import 'fixtures/weather/weather_status_fixture.dart';
import 'fixtures/weather/wind_status_fixture.dart';

void main() {
  test('PositionEntity', () {
    final json = PositionFixture.json();
    final entity = PositionFixture.entity();
    final model = PositionModel.fromJson(json).toEntity();
    expect(model, equals(entity));
  });

  test('CloudStatusEntity', () {
    final json = CloudStatusFixture.json();
    final entity = CloudStatusFixture.entity();
    final model = CloudStatusModel.fromJson(json).toEntity();
    expect(model, equals(entity));
  });

  test('CurrentWeatherEntity', () {
    final json = CurrentWeatherFixture.json();
    final entity = CurrentWeatherFixture.entity();
    final model = CurrentWeatherModel.fromJson(json).toEntity();
    expect(model, equals(entity));
  });

  test('ForecastEntryEntity', () {
    final json = ForecastEntryFixture.json();
    final entity = ForecastEntryFixture.entity();
    final model = ForecastEntryModel.fromJson(json).toEntity();
    expect(model, equals(entity));
  });

  test('ForecastReportEntity', () {
    final json = ForecastReportFixture.json();
    final entity = ForecastReportFixture.entity();
    final model = ForecastReportModel.fromJson(json).toEntity();
    expect(model, equals(entity));
  });

  test('WeatherConditionsEntity', () {
    final json = WeatherConditionsFixture.json();
    final entity = WeatherConditionsFixture.entity();
    final model = WeatherConditionsModel.fromJson(json).toEntity();
    expect(model, equals(entity));
  });

  test('WeatherStatusEntity', () {
    final json = WeatherStatusFixture.json();
    final entity = WeatherStatusFixture.entity();
    final model = WeatherStatusModel.fromJson(json).toEntity();
    expect(model, equals(entity));
  });

  test('WindStatusEntity', () {
    final json = WindStatusFixture.json();
    final entity = WindStatusFixture.entity();
    final model = WindStatusModel.fromJson(json).toEntity();
    expect(model, equals(entity));
  });

  test('CityEntity', () {
    final json = CityFixture.json();
    final entity = CityFixture.entity();
    final model = CityModel.fromJson(json).toEntity();
    expect(model, equals(entity));
  });
}
