import 'package:weather_app/core/data/models/position_model.dart';
import 'package:weather_app/core/domain/entities/position_entity.dart';

abstract class PositionFixture {
  static PositionEntity entity() => const PositionEntity(
        latitude: 1,
        longitude: 2,
      );

  static PositionModel model() => const PositionModel(
        latitude: 1,
        longitude: 2,
      );

  static Map<String, dynamic> json() => {
        'lat': 1,
        'lon': 2,
      };
}
