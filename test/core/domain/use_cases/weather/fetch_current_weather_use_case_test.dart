import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/domain/entities/position_entity.dart';
import 'package:olly_olly_challenge/core/domain/use_cases/weather/fetch_current_weather_use_case.dart';
import 'package:olly_olly_challenge/core/infra/exception/app_exception.dart';

import '../../../../fixtures/position_fixture.dart';
import '../../../../fixtures/weather/current_weather_fixture.dart';
import '../../../../mocks/repositories/mock_weather_repository.dart';
import '../../../../test_helpers.dart';

void main() {
  late FetchCurrentWeatherUseCaseImpl useCase;
  late MockWeatherRepository mockRepository;
  late PositionEntity position;

  setUpAll(TestHelpers.registerFallbackValues);

  setUp(() {
    mockRepository = MockWeatherRepository();
    useCase = FetchCurrentWeatherUseCaseImpl(mockRepository);
    position = PositionFixture.entity();
  });

  test('should return entity on success and call repository once', () async {
    // arrange
    final entity = CurrentWeatherFixture.entity();
    mockRepository.stubFetchCurrentWeather(entity);

    // act
    final result = await useCase(position);

    // assert
    expect(result.rightOrNull, entity);
    verify(
      () => mockRepository.fetchCurrentWeather(position),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return AppException on failure and call repository once',
      () async {
    // arrange
    const exception = AppException('error');
    mockRepository.stubFetchCurrentWeatherException(exception);

    // act
    final result = await useCase(position);

    // assert
    expect(result.leftOrNull, exception);
    verify(
      () => mockRepository.fetchCurrentWeather(position),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
