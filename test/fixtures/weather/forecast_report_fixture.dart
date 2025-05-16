import 'package:olly_olly_challenge/core/data/models/weather/forecast_report_model.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/forecast_report_entity.dart';

import '../city_fixture.dart';
import 'forecast_entry_fixture.dart';

abstract class ForecastReportFixture {
  static ForecastReportEntity entity() => ForecastReportEntity(
        city: CityFixture.entity(),
        entries: [ForecastEntryFixture.entity()],
      );

  static ForecastReportModel model() => ForecastReportModel(
        city: CityFixture.entity(),
        entries: [ForecastEntryFixture.entity()],
      );

  static Map<String, dynamic> json() => {
        'cod': '200',
        'message': 0,
        'cnt': 40,
        'list': [ForecastEntryFixture.json()],
        'city': CityFixture.json(),
      };
}
