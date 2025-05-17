import 'package:weather_app/core/domain/entities/weather/cloud_status_entity.dart';

class CloudStatusModel extends CloudStatusEntity {
  const CloudStatusModel({
    required super.all,
  });

  factory CloudStatusModel.fromJson(final Map<String, dynamic> json) {
    return CloudStatusModel(
      all: json['all'] as int,
    );
  }

  CloudStatusModel copyWith({
    final int? all,
  }) {
    return CloudStatusModel(
      all: all ?? this.all,
    );
  }

  CloudStatusEntity toEntity() {
    return CloudStatusEntity(
      all: all,
    );
  }
}
