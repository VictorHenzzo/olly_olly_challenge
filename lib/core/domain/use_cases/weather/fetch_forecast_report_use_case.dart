import 'package:injectable/injectable.dart';
import 'package:weather_app/core/domain/entities/position_entity.dart';
import 'package:weather_app/core/domain/entities/weather/forecast_report_entity.dart';
import 'package:weather_app/core/domain/repositories/weather_repository.dart';
import 'package:weather_app/core/infra/either/either.dart';
import 'package:weather_app/core/infra/exception/app_exception.dart';

abstract class FetchForecastReportUseCase {
  Future<Either<AppException, ForecastReportEntity>> call(
    final PositionEntity position,
  );
}

@Injectable(as: FetchForecastReportUseCase)
class FetchForecastReportUseCaseImpl implements FetchForecastReportUseCase {
  FetchForecastReportUseCaseImpl(this.weatherRepository);

  final WeatherRepository weatherRepository;

  @override
  Future<Either<AppException, ForecastReportEntity>> call(
    final PositionEntity position,
  ) {
    return weatherRepository.fetchForecastReport(position);
  }
}
