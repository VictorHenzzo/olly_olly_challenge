import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/current_weather_entity.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/forecast_report_entity.dart';
import 'package:olly_olly_challenge/core/domain/repositories/weather_repository.dart';
import 'package:olly_olly_challenge/core/infra/either/either.dart';
import 'package:olly_olly_challenge/core/infra/exception/app_exception.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {
  void stubFetchCurrentWeather(
    final CurrentWeatherEntity result,
  ) {
    when(
      () => fetchCurrentWeather(any()),
    ).thenAnswer(
      (final _) async => Right(result),
    );
  }

  void stubFetchCurrentWeatherException(final AppException exception) {
    when(
      () => fetchCurrentWeather(any()),
    ).thenAnswer((final _) async => Left(exception));
  }

  void stubFetchForecastReport(
    final ForecastReportEntity result,
  ) {
    when(
      () => fetchForecastReport(any()),
    ).thenAnswer((final _) async => Right(result));
  }

  void stubFetchForecastReportException(final AppException exception) {
    when(
      () => fetchForecastReport(any()),
    ).thenAnswer((final _) async => Left(exception));
  }
}
