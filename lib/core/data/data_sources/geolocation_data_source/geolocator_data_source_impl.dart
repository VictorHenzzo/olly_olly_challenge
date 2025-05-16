import 'package:geolocator/geolocator.dart' as geo;
import 'package:injectable/injectable.dart';
import 'package:olly_olly_challenge/core/data/data_sources/geolocation_data_source/geolocation_data_source.dart';
import 'package:olly_olly_challenge/core/data/data_sources/geolocation_data_source/geolocation_data_source_exception.dart';
import 'package:olly_olly_challenge/core/domain/enums/location_access_permission.dart';

@Injectable(as: GeolocationDataSource)
class GeolocatorDataSourceImpl implements GeolocationDataSource {
  const GeolocatorDataSourceImpl({
    @factoryParam final GeolocatorAdapter? geolocatorAdapter,
  }) : adapter = geolocatorAdapter ?? const GeolocatorAdapter();

  final GeolocatorAdapter adapter;

  @override
  Future<LocationAccessPermission> checkPermission() async {
    try {
      final result = await adapter.checkPermission();
      return switch (result) {
        geo.LocationPermission.denied => LocationAccessPermission.denied,
        geo.LocationPermission.deniedForever =>
          LocationAccessPermission.deniedForever,
        geo.LocationPermission.whileInUse => LocationAccessPermission.permitted,
        geo.LocationPermission.always => LocationAccessPermission.permitted,
        geo.LocationPermission.unableToDetermine =>
          LocationAccessPermission.unknown,
      };
    } catch (e) {
      throw GeolocationDataSourceException(
        'An unexpected error occurred while checking permission: $e',
      );
    }
  }

  @override
  Future<LocationAccessPermission> requestPermission() async {
    try {
      final result = await adapter.requestPermission();
      return switch (result) {
        geo.LocationPermission.denied => LocationAccessPermission.denied,
        geo.LocationPermission.deniedForever =>
          LocationAccessPermission.deniedForever,
        geo.LocationPermission.whileInUse => LocationAccessPermission.permitted,
        geo.LocationPermission.always => LocationAccessPermission.permitted,
        geo.LocationPermission.unableToDetermine =>
          LocationAccessPermission.unknown,
      };
    } catch (e) {
      throw GeolocationDataSourceException(
        'An unexpected error occurred while requesting permission: $e',
      );
    }
  }

  @override
  Future<({double latitude, double longitude})> getCurrentPosition() async {
    try {
      final position = await adapter.getCurrentPosition();
      return (
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      throw GeolocationDataSourceException(
        'An unexpected error occurred while getting position: $e',
      );
    }
  }

  @override
  Future<void> openAppSettings() async {
    try {
      await adapter.openAppSettings();
    } catch (e) {
      throw GeolocationDataSourceException(
        'An unexpected error occurred while opening app settings: $e',
      );
    }
  }
}

class GeolocatorAdapter {
  const GeolocatorAdapter();

  Future<geo.LocationPermission> checkPermission() async {
    return geo.Geolocator.checkPermission();
  }

  Future<geo.LocationPermission> requestPermission() async {
    return geo.Geolocator.requestPermission();
  }

  Future<geo.Position> getCurrentPosition() async {
    return geo.Geolocator.getCurrentPosition();
  }

  Future<void> openAppSettings() async {
    await geo.Geolocator.openAppSettings();
  }
}
