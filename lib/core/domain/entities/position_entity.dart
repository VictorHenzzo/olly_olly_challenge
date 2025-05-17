import 'package:equatable/equatable.dart';

/// Represents a geographical position with latitude and longitude.
/// Used for location-based features and weather queries.
class PositionEntity extends Equatable {
  /// Creates a [PositionEntity] with the given latitude and longitude.
  const PositionEntity({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;

  final double longitude;

  @override
  List<Object?> get props => [latitude, longitude];
}
