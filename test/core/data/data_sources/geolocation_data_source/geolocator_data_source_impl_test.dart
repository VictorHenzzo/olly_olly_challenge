import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/data/data_sources/geolocation_data_source/geolocation_data_source_exception.dart';
import 'package:olly_olly_challenge/core/data/data_sources/geolocation_data_source/geolocator_data_source_impl.dart';
import 'package:olly_olly_challenge/core/domain/enums/location_access_permission.dart';

void main() {
  late GeolocatorDataSourceImpl dataSource;
  late _MockGeolocatorAdapter mockAdapter;

  setUp(() {
    mockAdapter = _MockGeolocatorAdapter();
    dataSource = GeolocatorDataSourceImpl(geolocatorAdapter: mockAdapter);
  });

  group('checkPermission', () {
    test('should return denied when permission is denied', () async {
      // arrange
      mockAdapter.stubCheckPermission(geo.LocationPermission.denied);

      // act
      final result = await dataSource.checkPermission();

      // assert
      expect(result, equals(LocationAccessPermission.denied));
      verify(() => mockAdapter.checkPermission()).called(1);
    });

    test('should return deniedForever when permission is denied forever',
        () async {
      // arrange
      mockAdapter.stubCheckPermission(geo.LocationPermission.deniedForever);

      // act
      final result = await dataSource.checkPermission();

      // assert
      expect(result, equals(LocationAccessPermission.deniedForever));
      verify(() => mockAdapter.checkPermission()).called(1);
    });

    test('should return permitted when permission is whileInUse', () async {
      // arrange
      mockAdapter.stubCheckPermission(geo.LocationPermission.whileInUse);

      // act
      final result = await dataSource.checkPermission();

      // assert
      expect(result, equals(LocationAccessPermission.permitted));
      verify(() => mockAdapter.checkPermission()).called(1);
    });

    test('should return permitted when permission is always', () async {
      // arrange
      mockAdapter.stubCheckPermission(geo.LocationPermission.always);

      // act
      final result = await dataSource.checkPermission();

      // assert
      expect(result, equals(LocationAccessPermission.permitted));
      verify(() => mockAdapter.checkPermission()).called(1);
    });

    test('should return unknown when permission is unableToDetermine',
        () async {
      // arrange
      mockAdapter.stubCheckPermission(geo.LocationPermission.unableToDetermine);

      // act
      final result = await dataSource.checkPermission();

      // assert
      expect(result, equals(LocationAccessPermission.unknown));
      verify(() => mockAdapter.checkPermission()).called(1);
    });

    test('should throw exception when checking permission fails', () async {
      // arrange
      mockAdapter
          .stubCheckPermissionError(Exception('Permission check failed'));

      // act & assert
      expect(
        () => dataSource.checkPermission(),
        throwsA(isA<GeolocationDataSourceException>()),
      );
      verify(() => mockAdapter.checkPermission()).called(1);
    });
  });

  group('requestPermission', () {
    test('should return denied when permission is denied', () async {
      // arrange
      mockAdapter.stubRequestPermission(geo.LocationPermission.denied);

      // act
      final result = await dataSource.requestPermission();

      // assert
      expect(result, equals(LocationAccessPermission.denied));
      verify(() => mockAdapter.requestPermission()).called(1);
    });

    test('should return deniedForever when permission is denied forever',
        () async {
      // arrange
      mockAdapter.stubRequestPermission(geo.LocationPermission.deniedForever);

      // act
      final result = await dataSource.requestPermission();

      // assert
      expect(result, equals(LocationAccessPermission.deniedForever));
      verify(() => mockAdapter.requestPermission()).called(1);
    });

    test('should return permitted when permission is whileInUse', () async {
      // arrange
      mockAdapter.stubRequestPermission(geo.LocationPermission.whileInUse);

      // act
      final result = await dataSource.requestPermission();

      // assert
      expect(result, equals(LocationAccessPermission.permitted));
      verify(() => mockAdapter.requestPermission()).called(1);
    });

    test('should return permitted when permission is always', () async {
      // arrange
      mockAdapter.stubRequestPermission(geo.LocationPermission.always);

      // act
      final result = await dataSource.requestPermission();

      // assert
      expect(result, equals(LocationAccessPermission.permitted));
      verify(() => mockAdapter.requestPermission()).called(1);
    });

    test('should return unknown when permission is unableToDetermine',
        () async {
      // arrange
      mockAdapter
          .stubRequestPermission(geo.LocationPermission.unableToDetermine);

      // act
      final result = await dataSource.requestPermission();

      // assert
      expect(result, equals(LocationAccessPermission.unknown));
      verify(() => mockAdapter.requestPermission()).called(1);
    });

    test('should throw exception when requesting permission fails', () async {
      // arrange
      mockAdapter
          .stubRequestPermissionError(Exception('Permission request failed'));

      // act & assert
      expect(
        () => dataSource.requestPermission(),
        throwsA(isA<GeolocationDataSourceException>()),
      );
      verify(() => mockAdapter.requestPermission()).called(1);
    });
  });

  group('getCurrentPosition', () {
    test('should return position when successful', () async {
      // arrange
      final position = geo.Position(
        latitude: 123,
        longitude: 321,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
      );

      mockAdapter.stubGetCurrentPosition(position);

      // act
      final result = await dataSource.getCurrentPosition();

      // assert
      expect(result.latitude, equals(123));
      expect(result.longitude, equals(321));
      verify(() => mockAdapter.getCurrentPosition()).called(1);
    });

    test('should throw exception when getting position fails', () async {
      // arrange
      mockAdapter
          .stubGetCurrentPositionError(Exception('Position check failed'));

      // act & assert
      expect(
        () => dataSource.getCurrentPosition(),
        throwsA(isA<GeolocationDataSourceException>()),
      );
      verify(() => mockAdapter.getCurrentPosition()).called(1);
    });
  });

  group('openAppSettings', () {
    test('should call openAppSettings on adapter', () async {
      // arrange
      mockAdapter.stubOpenAppSettings();

      // act
      await dataSource.openAppSettings();

      // assert
      verify(() => mockAdapter.openAppSettings()).called(1);
    });

    test('should throw exception when opening app settings fails', () async {
      // arrange
      mockAdapter.stubOpenAppSettingsError(Exception('Settings open failed'));

      // act & assert
      expect(
        () => dataSource.openAppSettings(),
        throwsA(isA<GeolocationDataSourceException>()),
      );
      verify(() => mockAdapter.openAppSettings()).called(1);
    });
  });
}

class _MockGeolocatorAdapter extends Mock implements GeolocatorAdapter {
  void stubCheckPermission(final geo.LocationPermission permission) {
    when(checkPermission).thenAnswer((final _) async => permission);
  }

  void stubCheckPermissionError(final Object error) {
    when(checkPermission).thenThrow(error);
  }

  void stubRequestPermission(final geo.LocationPermission permission) {
    when(requestPermission).thenAnswer((final _) async => permission);
  }

  void stubRequestPermissionError(final Object error) {
    when(requestPermission).thenThrow(error);
  }

  void stubGetCurrentPosition(final geo.Position position) {
    when(getCurrentPosition).thenAnswer((final _) async => position);
  }

  void stubGetCurrentPositionError(final Object error) {
    when(getCurrentPosition).thenThrow(error);
  }

  void stubOpenAppSettings() {
    when(openAppSettings).thenAnswer((final _) async => {});
  }

  void stubOpenAppSettingsError(final Object error) {
    when(openAppSettings).thenThrow(error);
  }
}
