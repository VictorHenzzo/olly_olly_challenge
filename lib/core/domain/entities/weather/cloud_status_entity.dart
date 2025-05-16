import 'package:equatable/equatable.dart';

/// Represents cloud coverage information.
class CloudStatusEntity extends Equatable {
  const CloudStatusEntity({
    required this.all,
  });

  /// Cloud coverage percentage
  final int all;

  @override
  List<Object?> get props => [all];
}
