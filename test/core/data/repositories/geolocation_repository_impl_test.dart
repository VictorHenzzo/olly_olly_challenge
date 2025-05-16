import 'package:flutter_test/flutter_test.dart';
import 'package:olly_olly_challenge/core/data/data_sources/geolocation_data_source/geolocation_data_source_exception.dart';
import 'package:olly_olly_challenge/core/data/repositories/geolocation_repository.dart';
import 'package:olly_olly_challenge/core/domain/enums/location_access_permission.dart';

import '../../../fixtures/position_fixture.dart';
import '../../../mocks/data_sources/mock_geolocation_data_source.dart';

void main() {
  late GeolocationRepositoryImpl sut;
  late MockGeolocationDataSource dataSource;

  setUp(() {
    dataSource = MockGeolocationDataSource();
    sut = GeolocationRepositoryImpl(dataSource);
  });

  group('getCurrentPosition', () {
    test('should return position when data source succeeds', () async {
      // arrange
      final position = PositionFixture.entity();
      dataSource.stubGetCurrentPosition(
        (latitude: position.latitude, longitude: position.longitude),
      );

      // act
      final result = await sut.getCurrentPosition();

      // assert
      expect(result.isRight, isTrue);
      expect(
        result.rightOrNull,
        equals(position),
      );
    });

    test('should return error when data source throws ', () async {
      // arrange
      dataSource.stubGetCurrentPositionException('error');

      // act
      final result = await sut.getCurrentPosition();

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<GeolocationDataSourceException>());
    });
  });

  group('checkPermission', () {
    test('should return permission when data source succeeds', () async {
      // arrange
      dataSource.stubCheckPermission(LocationAccessPermission.permitted);

      // act
      final result = await sut.checkPermission();

      // assert
      expect(result.isRight, isTrue);
      expect(result.rightOrNull, equals(LocationAccessPermission.permitted));
    });

    test('should return error when data source throws ', () async {
      // arrange
      dataSource.stubCheckPermissionException('error');

      // act
      final result = await sut.checkPermission();

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<GeolocationDataSourceException>());
    });
  });

  group('requestPermission', () {
    test('should return permission when data source succeeds', () async {
      // arrange
      dataSource.stubRequestPermission(LocationAccessPermission.permitted);

      // act
      final result = await sut.requestPermission();

      // assert
      expect(result.isRight, isTrue);
      expect(result.rightOrNull, equals(LocationAccessPermission.permitted));
    });

    test('should return error when data source throws ', () async {
      // arrange
      dataSource.stubRequestPermissionException('error');

      // act
      final result = await sut.requestPermission();

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<GeolocationDataSourceException>());
    });
  });

  group('openAppSettings', () {
    test('should return void when data source succeeds', () async {
      // arrange
      dataSource.stubOpenAppSettings();

      // act
      final result = await sut.openAppSettings();

      // assert
      expect(result.isRight, isTrue);
    });

    test('should return error when data source throws ', () async {
      // arrange
      dataSource.stubOpenAppSettingsException('error');

      // act
      final result = await sut.openAppSettings();

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<GeolocationDataSourceException>());
    });
  });
}
