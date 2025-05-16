import 'package:equatable/equatable.dart';

/// Represents the weather status information including condition
/// details and icon.
class WeatherStatusEntity extends Equatable {
  const WeatherStatusEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
  });

  /// Weather condition ID
  final int id;

  /// Group of weather parameters (Rain, Snow, Clouds etc.)
  final String name;

  /// Weather condition description within the group
  final String description;

  /// Weather icon ID
  final String icon;

  @override
  List<Object?> get props => [id, name, description, icon];
}
