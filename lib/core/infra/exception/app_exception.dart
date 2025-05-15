import 'package:equatable/equatable.dart';

/// A generic application-level exception.
///
/// This can be extended or used directly to represent custom errors
/// across the app. It optionally wraps another error object (e.g. a message,
/// another exception, or detailed error data).
class AppException extends Equatable implements Exception {
  /// Creates an [AppException] with an optional [error] object.
  ///
  /// The [error] can be a string message, another exception, or any
  /// useful diagnostic data.
  const AppException([this.error]);

  /// The underlying error or message associated with this exception.
  final Object? error;

  @override
  String toString() => 'AppException: $error';

  @override
  List<Object?> get props => [error];
}
