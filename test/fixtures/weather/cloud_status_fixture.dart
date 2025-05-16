import 'package:olly_olly_challenge/core/data/models/weather/cloud_status_model.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/cloud_status_entity.dart';

abstract class CloudStatusFixture {
  static CloudStatusEntity entity() => const CloudStatusEntity(
        all: 20,
      );

  static CloudStatusModel model() => const CloudStatusModel(
        all: 20,
      );

  static Map<String, dynamic> json() => {
        'all': 20,
      };
}
