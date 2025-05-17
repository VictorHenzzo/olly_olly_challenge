/// Represents the possible states of location access permission for the app.
///
/// Used to determine if the app can access the device's location services.
enum LocationAccessPermission {
  denied,
  deniedForever,
  permitted,
  unknown,
}
