import 'package:olly_olly_challenge/core/data/models/city_model.dart';
import 'package:olly_olly_challenge/core/data/models/weather/forecast_entry_model.dart';
import 'package:olly_olly_challenge/core/domain/entities/city_entity.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/forecast_entry_entity.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/forecast_report_entity.dart';

class ForecastReportModel extends ForecastReportEntity {
  const ForecastReportModel({
    required super.city,
    required super.entries,
  });

  factory ForecastReportModel.fromJson(final Map<String, dynamic> json) {
    final cityJson = json['city'] as Map<String, dynamic>;
    final listJson = json['list'] as List<dynamic>;

    return ForecastReportModel(
      city: CityModel.fromJson(cityJson).toEntity(),
      entries: _parseEntries(listJson),
    );
  }

  static List<ForecastEntryEntity> _parseEntries(
    final List<dynamic> listJson,
  ) {
    ForecastEntryEntity build(final dynamic entry) =>
        ForecastEntryModel.fromJson(entry as Map<String, dynamic>).toEntity();

    return listJson.map(build).toList(growable: false);
  }

  ForecastReportModel copyWith({
    final CityEntity? city,
    final List<ForecastEntryEntity>? entries,
  }) {
    return ForecastReportModel(
      city: city ?? this.city,
      entries: entries ?? this.entries,
    );
  }

  ForecastReportEntity toEntity() {
    return ForecastReportEntity(
      city: city,
      entries: entries,
    );
  }
}
