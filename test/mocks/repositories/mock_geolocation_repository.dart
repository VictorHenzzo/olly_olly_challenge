import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/data/data_sources/geolocation_data_source/geolocation_data_source_exception.dart';
import 'package:olly_olly_challenge/core/domain/entities/position_entity.dart';
import 'package:olly_olly_challenge/core/domain/enums/location_access_permission.dart';
import 'package:olly_olly_challenge/core/domain/repositories/geolocation_repository.dart';
import 'package:olly_olly_challenge/core/infra/either/either.dart';

class MockGeolocationRepository extends Mock implements GeolocationRepository {
  void stubGetCurrentPosition(final PositionEntity position) {
    when(getCurrentPosition).thenAnswer((final _) async => Right(position));
  }

  void stubGetCurrentPositionException(final String code) {
    when(getCurrentPosition).thenAnswer(
      (final _) async => Left(GeolocationDataSourceException(code)),
    );
  }

  void stubCheckPermission(final LocationAccessPermission permission) {
    when(checkPermission).thenAnswer((final _) async => Right(permission));
  }

  void stubCheckPermissionException(final String code) {
    when(checkPermission).thenAnswer(
      (final _) async => Left(GeolocationDataSourceException(code)),
    );
  }

  void stubRequestPermission(final LocationAccessPermission permission) {
    when(requestPermission).thenAnswer((final _) async => Right(permission));
  }

  void stubRequestPermissionException(final String code) {
    when(requestPermission).thenAnswer(
      (final _) async => Left(GeolocationDataSourceException(code)),
    );
  }

  void stubOpenAppSettings() {
    when(openAppSettings).thenAnswer((final _) async => const Right(null));
  }

  void stubOpenAppSettingsException(final String code) {
    when(openAppSettings).thenAnswer(
      (final _) async => Left(GeolocationDataSourceException(code)),
    );
  }
}
