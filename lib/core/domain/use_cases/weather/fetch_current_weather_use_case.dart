import 'package:injectable/injectable.dart';
import 'package:weather_app/core/domain/entities/position_entity.dart';
import 'package:weather_app/core/domain/entities/weather/current_weather_entity.dart';
import 'package:weather_app/core/domain/repositories/weather_repository.dart';
import 'package:weather_app/core/infra/either/either.dart';
import 'package:weather_app/core/infra/exception/app_exception.dart';

abstract class FetchCurrentWeatherUseCase {
  Future<Either<AppException, CurrentWeatherEntity>> call(
    final PositionEntity position,
  );
}

@Injectable(as: FetchCurrentWeatherUseCase)
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
