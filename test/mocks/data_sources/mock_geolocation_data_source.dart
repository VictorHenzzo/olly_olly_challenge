import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/data/data_sources/geolocation_data_source/geolocation_data_source.dart';
import 'package:olly_olly_challenge/core/data/data_sources/geolocation_data_source/geolocation_data_source_exception.dart';
import 'package:olly_olly_challenge/core/domain/enums/location_access_permission.dart';

class MockGeolocationDataSource extends Mock implements GeolocationDataSource {
  void stubGetCurrentPosition(
    final ({double latitude, double longitude}) position,
  ) {
    when(getCurrentPosition).thenAnswer((final _) async => position);
  }

  void stubGetCurrentPositionException(final String code) {
    when(getCurrentPosition).thenThrow(GeolocationDataSourceException(code));
  }

  void stubCheckPermission(final LocationAccessPermission permission) {
    when(checkPermission).thenAnswer((final _) async => permission);
  }

  void stubCheckPermissionException(final String code) {
    when(checkPermission).thenThrow(GeolocationDataSourceException(code));
  }

  void stubRequestPermission(final LocationAccessPermission permission) {
    when(requestPermission).thenAnswer((final _) async => permission);
  }

  void stubRequestPermissionException(final String code) {
    when(requestPermission).thenThrow(GeolocationDataSourceException(code));
  }

  void stubOpenAppSettings() {
    when(openAppSettings).thenAnswer((final _) async {});
  }

  void stubOpenAppSettingsException(final String code) {
    when(openAppSettings).thenThrow(GeolocationDataSourceException(code));
  }
}
