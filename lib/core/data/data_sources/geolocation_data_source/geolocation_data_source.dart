import 'package:weather_app/core/domain/enums/location_access_permission.dart';

/// Abstraction for accessing geolocation services.
///
/// This interface provides methods for retrieving the current position,
/// checking and requesting location permissions, and opening app settings.
///
/// All methods may throw a base geolocation data source exception on failure.
abstract class GeolocationDataSource {
  /// Gets the current device position (latitude and longitude).
  ///
  /// Returns a [Future] that completes with the current position.
  /// Throws a geolocation data source exception if the operation fails.
  Future<({double latitude, double longitude})> getCurrentPosition();

  /// Checks the current location permission status.
  ///
  /// Returns a [Future] that completes with the permission status.
  /// Throws a geolocation data source exception if the operation fails.
  Future<LocationAccessPermission> checkPermission();

  /// Requests location permission from the user.
  ///
  /// Returns a [Future] that completes with the new permission status.
  /// Throws a geolocation data source exception if the operation fails.
  Future<LocationAccessPermission> requestPermission();

  /// Opens the app settings for the user to change location permissions.
  ///
  /// Returns a [Future] that completes when the operation finishes.
  /// Throws a geolocation data source exception if the operation fails.
  Future<void> openAppSettings();
}
