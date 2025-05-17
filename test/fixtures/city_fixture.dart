import 'package:weather_app/core/data/models/city_model.dart';
import 'package:weather_app/core/domain/entities/city_entity.dart';

import 'position_fixture.dart';

abstract class CityFixture {
  static CityEntity entity() => CityEntity(
        id: '3460960',
        name: 'Itabira',
        position: PositionFixture.entity(),
        country: 'BR',
        population: 99496,
        timezone: -10800,
        sunrise: 1747386846,
        sunset: 1747427080,
      );

  static CityModel model() => CityModel(
        id: '3460960',
        name: 'Itabira',
        position: PositionFixture.model(),
        country: 'BR',
        population: 99496,
        timezone: -10800,
        sunrise: 1747386846,
        sunset: 1747427080,
      );

  static Map<String, dynamic> json() => {
        'id': 3460960,
        'name': 'Itabira',
        'coord': PositionFixture.json(),
        'country': 'BR',
        'population': 99496,
        'timezone': -10800,
        'sunrise': 1747386846,
        'sunset': 1747427080,
      };
}
