import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/data/data_sources/http/http_exceptions.dart';
import 'package:olly_olly_challenge/core/data/data_sources/http/http_response.dart';
import 'package:olly_olly_challenge/core/data/repositories/weather_repository_impl.dart';
import 'package:olly_olly_challenge/core/domain/entities/position_entity.dart';
import 'package:olly_olly_challenge/core/infra/exception/app_exception.dart';

import '../../../../test/mocks/data_sources/mock_http_data_source.dart';
import '../../../fixtures/position_fixture.dart';
import '../../../fixtures/weather/current_weather_fixture.dart';
import '../../../fixtures/weather/forecast_report_fixture.dart';
import '../../../mocks/mock_environment.dart';
import '../../../test_helpers.dart';

void main() {
  late MockHttpDataSource mockHttpDataSource;
  late WeatherRepositoryImpl repository;
  late MockEnvironment mockEnvironment;

  late PositionEntity position;
  late String expectedForecastEndpoint;
  late String expectedCurrentWeatherEndpoint;

  setUpAll(TestHelpers.registerFallbackValues);

  setUp(() {
    mockHttpDataSource = MockHttpDataSource();
    mockEnvironment = MockEnvironment();
    repository = WeatherRepositoryImpl(
      httpDataSource: mockHttpDataSource,
      environment: mockEnvironment,
    );

    position = PositionFixture.entity();
    final lat = position.latitude;
    final lon = position.longitude;
    final baseUrl = mockEnvironment.weatherApiBaseUrl;
    final apiKey = mockEnvironment.weatherApiKey;
    expectedForecastEndpoint =
        '$baseUrl/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=imperial';
    expectedCurrentWeatherEndpoint =
        '$baseUrl/weather?lat=$lat&lon=$lon&appid=$apiKey&units=imperial';
  });

  group('fetchCurrentWeather', () {
    test('should call data source with the correct values', () async {
      // arrange
      final response = HttpResponse(
        statusCode: 200,
        body: jsonEncode(CurrentWeatherFixture.json()),
      );
      mockHttpDataSource.stubGet(response);

      // act
      await repository.fetchCurrentWeather(position);

      // assert
      verify(
        () => mockHttpDataSource.get(
          Uri.parse(expectedCurrentWeatherEndpoint),
          headers: any(named: 'headers'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockHttpDataSource);
    });

    test('should be able to return a entity', () async {
      // arrange
      final response = HttpResponse(
        statusCode: 200,
        body: jsonEncode(CurrentWeatherFixture.json()),
      );
      mockHttpDataSource.stubGet(response);

      // act
      final result = await repository.fetchCurrentWeather(position);

      // assert
      expect(result.isRight, isTrue);
      expect(result.rightOrNull, equals(CurrentWeatherFixture.entity()));
    });

    test('should return failure on http error', () async {
      // arrange
      mockHttpDataSource.stubGetException(
        const NotFoundException(message: 'Not found'),
      );

      // act
      final result = await repository.fetchCurrentWeather(position);

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<AppException>());
    });

    test('should return error on other HttpDataSourceException', () async {
      // arrange
      mockHttpDataSource.stubGetException(
        const HttpDataSourceException('Some error'),
      );

      // act
      final result = await repository.fetchCurrentWeather(position);

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<AppException>());
    });

    test('should return error on invalid json', () async {
      // arrange
      const response = HttpResponse(statusCode: 200, body: '');
      mockHttpDataSource.stubGet(response);

      // act
      final result = await repository.fetchCurrentWeather(position);

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<AppException>());
    });
  });

  group('fetchForecastReport', () {
    test('should call data source with the correct values', () async {
      // arrange
      final response = HttpResponse(
        statusCode: 200,
        body: jsonEncode(ForecastReportFixture.json()),
      );
      mockHttpDataSource.stubGet(response);

      // act
      await repository.fetchForecastReport(position);

      // assert
      verify(
        () => mockHttpDataSource.get(
          Uri.parse(expectedForecastEndpoint),
          headers: any(named: 'headers'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockHttpDataSource);
    });

    test('should be able to return a entity', () async {
      // arrange
      final response = HttpResponse(
        statusCode: 200,
        body: jsonEncode(ForecastReportFixture.json()),
      );
      mockHttpDataSource.stubGet(response);

      // act
      final result = await repository.fetchForecastReport(position);

      // assert
      expect(result.isRight, isTrue);
      expect(result.rightOrNull, equals(ForecastReportFixture.entity()));
    });

    test('should return failure on http error', () async {
      // arrange
      mockHttpDataSource.stubGetException(
        const NotFoundException(message: 'Not found'),
      );

      // act
      final result = await repository.fetchForecastReport(position);

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<AppException>());
    });

    test('should return error on other HttpDataSourceException', () async {
      // arrange
      mockHttpDataSource.stubGetException(
        const HttpDataSourceException('Some error'),
      );

      // act
      final result = await repository.fetchForecastReport(position);

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<AppException>());
    });

    test('should return error on invalid json', () async {
      // arrange
      const response = HttpResponse(statusCode: 200, body: '');
      mockHttpDataSource.stubGet(response);

      // act
      final result = await repository.fetchForecastReport(position);

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<AppException>());
    });
  });
}
