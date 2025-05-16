import 'package:olly_olly_challenge/core/data/data_sources/http/http_response.dart';

/// Abstract class defining the contract for HTTP data source implementations.
///
/// This interface provides methods for making HTTP requests using different
/// HTTP methods (GET, POST, PUT, PATCH, DELETE). Each method returns a
/// [Future] that completes with a [HttpResponse] or throws an [HttpException]
/// if the request fails.
abstract class HttpDataSource {
  /// Makes a GET request to the specified [uri].
  ///
  /// [uri] The target URI for the request.
  /// [headers] Optional headers to include in the request.
  ///
  /// Returns a [Future] that completes with a [HttpResponse].
  /// Throws [HttpException] if the request fails.
  Future<HttpResponse> get(
    Uri uri, {
    Map<String, String> headers,
  });

  /// Makes a DELETE request to the specified [uri].
  ///
  /// [uri] The target URI for the request.
  /// [headers] Optional headers to include in the request.
  ///
  /// Returns a [Future] that completes with a [HttpResponse].
  /// Throws [HttpException] if the request fails.
  Future<HttpResponse> delete(
    Uri uri, {
    Map<String, String> headers,
  });

  /// Makes a PATCH request to the specified [uri].
  ///
  /// [uri] The target URI for the request.
  /// [body] The request body to send.
  /// [headers] Optional headers to include in the request.
  ///
  /// Returns a [Future] that completes with a [HttpResponse].
  /// Throws [HttpException] if the request fails.
  Future<HttpResponse> patch(
    Uri uri, {
    Map<String, dynamic> body,
    Map<String, String> headers,
  });

  /// Makes a POST request to the specified [uri].
  ///
  /// [uri] The target URI for the request.
  /// [body] The request body to send.
  /// [headers] Optional headers to include in the request.
  ///
  /// Returns a [Future] that completes with a [HttpResponse].
  /// Throws [HttpException] if the request fails.
  Future<HttpResponse> post(
    Uri uri, {
    Map<String, dynamic> body,
    Map<String, String> headers,
  });

  /// Makes a PUT request to the specified [uri].
  ///
  /// [uri] The target URI for the request.
  /// [body] The request body to send.
  /// [headers] Optional headers to include in the request.
  ///
  /// Returns a [Future] that completes with a [HttpResponse].
  /// Throws [HttpException] if the request fails.
  Future<HttpResponse> put(
    Uri uri, {
    Map<String, dynamic> body,
    Map<String, String> headers,
  });
}
