import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/domain/entities/position_entity.dart';
import 'package:olly_olly_challenge/core/domain/use_cases/weather/fetch_forecast_report_use_case.dart';
import 'package:olly_olly_challenge/core/infra/exception/app_exception.dart';

import '../../../../fixtures/position_fixture.dart';
import '../../../../fixtures/weather/forecast_report_fixture.dart';
import '../../../../mocks/repositories/mock_weather_repository.dart';
import '../../../../test_helpers.dart';

void main() {
  late FetchForecastReportUseCaseImpl useCase;
  late MockWeatherRepository mockRepository;
  late PositionEntity position;

  setUpAll(TestHelpers.registerFallbackValues);

  setUp(() {
    mockRepository = MockWeatherRepository();
    useCase = FetchForecastReportUseCaseImpl(mockRepository);
    position = PositionFixture.entity();
  });

  test('should return entity on success and call repository once', () async {
    // arrange
    final entity = ForecastReportFixture.entity();
    mockRepository.stubFetchForecastReport(entity);

    // act
    final result = await useCase(position);

    // assert
    expect(result.rightOrNull, entity);
    verify(
      () => mockRepository.fetchForecastReport(position),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return AppException on failure and call repository once',
      () async {
    // arrange
    const exception = AppException('error');
    mockRepository.stubFetchForecastReportException(exception);

    // act
    final result = await useCase(position);

    // assert
    expect(result.leftOrNull, exception);
    verify(
      () => mockRepository.fetchForecastReport(position),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
