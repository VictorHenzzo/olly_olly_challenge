import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/forecast_report_entity.dart';
import 'package:olly_olly_challenge/core/domain/use_cases/weather/fetch_forecast_report_use_case.dart';
import 'package:olly_olly_challenge/core/infra/either/either.dart';
import 'package:olly_olly_challenge/core/infra/exception/app_exception.dart';

class MockFetchForecastReportUseCase extends Mock
    implements FetchForecastReportUseCase {
  void stubFetchForecastReport(final ForecastReportEntity forecast) {
    when(
      () => call(any()),
    ).thenAnswer((final _) async => Right(forecast));
  }

  void stubFetchForecastReportException(final AppException exception) {
    when(
      () => call(any()),
    ).thenAnswer((final _) async => Left(exception));
  }
}
