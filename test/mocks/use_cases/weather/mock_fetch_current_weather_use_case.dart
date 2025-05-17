import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/domain/entities/weather/current_weather_entity.dart';
import 'package:weather_app/core/domain/use_cases/weather/fetch_current_weather_use_case.dart';
import 'package:weather_app/core/infra/either/either.dart';
import 'package:weather_app/core/infra/exception/app_exception.dart';

class MockFetchCurrentWeatherUseCase extends Mock
    implements FetchCurrentWeatherUseCase {
  void stubFetchCurrentWeather(final CurrentWeatherEntity weather) {
    when(
      () => call(any()),
    ).thenAnswer((final _) async => Right(weather));
  }

  void stubFetchCurrentWeatherException(final AppException exception) {
    when(
      () => call(any()),
    ).thenAnswer((final _) async => Left(exception));
  }
}
