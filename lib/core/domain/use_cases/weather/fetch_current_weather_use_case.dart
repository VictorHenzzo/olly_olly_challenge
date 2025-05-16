import 'package:olly_olly_challenge/core/domain/entities/position_entity.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/current_weather_entity.dart';
import 'package:olly_olly_challenge/core/domain/repositories/weather_repository.dart';
import 'package:olly_olly_challenge/core/infra/either/either.dart';
import 'package:olly_olly_challenge/core/infra/exception/app_exception.dart';

abstract class FetchCurrentWeatherUseCase {
  Future<Either<AppException, CurrentWeatherEntity>> call(
    final PositionEntity position,
  );
}

class FetchCurrentWeatherUseCaseImpl implements FetchCurrentWeatherUseCase {
  FetchCurrentWeatherUseCaseImpl(this.weatherRepository);

  final WeatherRepository weatherRepository;

  @override
  Future<Either<AppException, CurrentWeatherEntity>> call(
    final PositionEntity position,
  ) {
    return weatherRepository.fetchCurrentWeather(position);
  }
}
