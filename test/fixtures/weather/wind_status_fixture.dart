import 'package:olly_olly_challenge/core/data/models/weather/wind_status_model.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/wind_status_entity.dart';

abstract class WindStatusFixture {
  static WindStatusEntity entity() => const WindStatusEntity(
        speed: 1.11,
        deg: 99,
        gust: 3.15,
      );

  static WindStatusModel model() => const WindStatusModel(
        speed: 1.11,
        deg: 99,
        gust: 3.15,
      );

  static Map<String, dynamic> json() => {
        'speed': 1.11,
        'deg': 99,
        'gust': 3.15,
      };
}
