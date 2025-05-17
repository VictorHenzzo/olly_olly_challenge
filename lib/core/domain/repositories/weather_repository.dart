import 'package:weather_app/core/domain/entities/position_entity.dart';
import 'package:weather_app/core/domain/entities/weather/current_weather_entity.dart';
import 'package:weather_app/core/domain/entities/weather/forecast_report_entity.dart';
import 'package:weather_app/core/infra/either/either.dart';
import 'package:weather_app/core/infra/exception/app_exception.dart';

abstract class WeatherRepository {
  Future<Either<AppException, CurrentWeatherEntity>> fetchCurrentWeather(
    final PositionEntity position,
  );
  Future<Either<AppException, ForecastReportEntity>> fetchForecastReport(
    final PositionEntity position,
  );
}
