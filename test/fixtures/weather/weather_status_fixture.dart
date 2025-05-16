import 'package:olly_olly_challenge/core/data/models/weather/weather_status_model.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/weather_status_entity.dart';

abstract class WeatherStatusFixture {
  static WeatherStatusEntity entity() => const WeatherStatusEntity(
        id: 801,
        name: 'Clouds',
        description: 'few clouds',
        icon: '02d',
      );

  static WeatherStatusModel model() => const WeatherStatusModel(
        id: 801,
        name: 'Clouds',
        description: 'few clouds',
        icon: '02d',
      );

  static Map<String, dynamic> json() => {
        'id': 801,
        'main': 'Clouds',
        'description': 'few clouds',
        'icon': '02d',
      };
}
