import 'package:equatable/equatable.dart';

/// A model class representing an HTTP response.
///
/// Contains the status code and body of the HTTP response.
class HttpResponse extends Equatable {
  /// Creates a new [HttpResponse] instance.
  ///
  /// [statusCode] represents the HTTP status code of the response.
  /// [body] contains the response body as a string.
  const HttpResponse({
    required this.statusCode,
    required this.body,
  });

  /// The HTTP status code of the response.
  final int statusCode;

  /// The response body as a string.
  final String body;

  @override
  List<Object?> get props => [statusCode, body];
}
