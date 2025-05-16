import 'package:equatable/equatable.dart';

/// Represents wind information including speed, direction, and gust data.
class WindStatusEntity extends Equatable {
  const WindStatusEntity({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  /// Wind speed in meters per second
  final double speed;

  /// Wind direction in degrees (meteorological)
  final int deg;

  /// Wind gust in meters per second
  final double gust;

  @override
  List<Object?> get props => [speed, deg, gust];
}
