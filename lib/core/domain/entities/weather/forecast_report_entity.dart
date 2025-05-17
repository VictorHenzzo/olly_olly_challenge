import 'package:equatable/equatable.dart';
import 'package:weather_app/core/domain/entities/city_entity.dart';
import 'package:weather_app/core/domain/entities/weather/forecast_entry_entity.dart';

/// Represents a weather forecast report for a city, containing multiple forecast entries.
class ForecastReportEntity extends Equatable {
  /// Creates a [ForecastReportEntity] with a list of forecast entries and city info.
  const ForecastReportEntity({
    required this.entries,
    required this.city,
  });

  /// List of forecast entries (e.g., for different times/days).
  final List<ForecastEntryEntity> entries;

  /// The city for which this forecast applies.
  final CityEntity city;

  @override
  List<Object?> get props => [entries, city];
}
