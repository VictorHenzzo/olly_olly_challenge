import 'package:equatable/equatable.dart';

/// A generic application-level exception.
///
/// This can be extended or used directly to represent custom errors
/// across the app. It optionally wraps another error object (e.g. a message,
/// another exception, or detailed error data).
class AppException extends Equatable implements Exception {
  /// Creates an [AppException] with an optional [message] object.
  const AppException([this.message]);

  /// A human-readable description of the message.
  final String? message;

  @override
  String toString() => 'AppException: $message';

  @override
  List<Object?> get props => [message];
}
