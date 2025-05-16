import 'package:olly_olly_challenge/core/domain/entities/position_entity.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/current_weather_entity.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/forecast_report_entity.dart';
import 'package:olly_olly_challenge/core/infra/either/either.dart';
import 'package:olly_olly_challenge/core/infra/exception/app_exception.dart';

abstract class WeatherRepository {
  Future<Either<AppException, CurrentWeatherEntity>> fetchCurrentWeather(
    final PositionEntity position,
  );
  Future<Either<AppException, ForecastReportEntity>> fetchForecastReport(
    final PositionEntity position,
  );
}
