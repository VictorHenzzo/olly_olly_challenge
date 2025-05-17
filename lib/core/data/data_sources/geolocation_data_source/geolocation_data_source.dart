import 'package:weather_app/core/domain/enums/location_access_permission.dart';

abstract class GeolocationDataSource {
  Future<({double latitude, double longitude})> getCurrentPosition();
  Future<LocationAccessPermission> checkPermission();
  Future<LocationAccessPermission> requestPermission();
  Future<void> openAppSettings();
}
