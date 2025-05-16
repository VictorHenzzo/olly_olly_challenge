import 'dart:convert';

import 'package:injectable/injectable.dart' show Injectable;
import 'package:olly_olly_challenge/core/data/data_sources/http/http_data_source.dart';
import 'package:olly_olly_challenge/core/data/data_sources/http/http_exceptions.dart';
import 'package:olly_olly_challenge/core/data/models/weather/current_weather_model.dart';
import 'package:olly_olly_challenge/core/data/models/weather/forecast_report_model.dart';
import 'package:olly_olly_challenge/core/domain/entities/position_entity.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/current_weather_entity.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/forecast_report_entity.dart';
import 'package:olly_olly_challenge/core/domain/repositories/weather_repository.dart';
import 'package:olly_olly_challenge/core/infra/either/either.dart';
import 'package:olly_olly_challenge/core/infra/env/environment.dart';
import 'package:olly_olly_challenge/core/infra/exception/app_exception.dart';

@Injectable(as: WeatherRepository)
class WeatherRepositoryImpl extends WeatherRepository {
  WeatherRepositoryImpl({
    required this.httpDataSource,
    required this.environment,
  });

  final HttpDataSource httpDataSource;
  final Environment environment;

  String get apiKey => environment.weatherApiKey;
  String get baseUrl => environment.weatherApiBaseUrl;

  static const units = 'imperial';

  @override
  Future<Either<AppException, CurrentWeatherEntity>> fetchCurrentWeather(
    final PositionEntity position,
  ) async {
    try {
      final lat = position.latitude;
      final lon = position.longitude;
      final endpoint = '/weather?lat=$lat&lon=$lon&appid=$apiKey&units=$units';
      final currentWeather = await _executeRequest(
        endpoint,
        (final json) => CurrentWeatherModel.fromJson(json).toEntity(),
      );
      return Right(currentWeather);
    } on FormatException catch (e) {
      return Left(AppException(e.toString()));
    } on HttpDataSourceException catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  @override
  Future<Either<AppException, ForecastReportEntity>> fetchForecastReport(
    final PositionEntity position,
  ) async {
    try {
      final lat = position.latitude;
      final lon = position.longitude;
      final endpoint = '/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=$units';
      final forecastReport = await _executeRequest(
        endpoint,
        (final json) => ForecastReportModel.fromJson(json).toEntity(),
      );
      return Right(forecastReport);
    } on FormatException catch (e) {
      return Left(AppException(e.toString()));
    } on HttpDataSourceException catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  Future<T> _executeRequest<T>(
    final String endpoint,
    final T Function(Map<String, dynamic>) parse,
  ) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final response = await httpDataSource.get(uri);
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return parse(json);
  }
}
