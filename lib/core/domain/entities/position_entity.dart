import 'package:equatable/equatable.dart';

class PositionEntity extends Equatable {
  const PositionEntity({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => [latitude, longitude];
}
