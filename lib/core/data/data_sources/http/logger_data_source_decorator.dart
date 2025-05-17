import 'package:weather_app/core/data/data_sources/http/http_data_source.dart';
import 'package:weather_app/core/data/data_sources/http/http_response.dart';
import 'package:weather_app/core/infra/logger/logger.dart';

class LoggerDataSourceDecorator implements HttpDataSource {
  LoggerDataSourceDecorator({
    required this.decoratee,
    required this.logger,
  });

  final HttpDataSource decoratee;
  final Logger logger;

  @override
  Future<HttpResponse> get(
    final Uri uri, {
    final Map<String, String> headers = const {},
  }) async {
    try {
      final response = await decoratee.get(uri, headers: headers);
      _logSuccess(uri, response, 'GET');
      return response;
    } catch (e) {
      _logError(uri, 'GET', e);
      rethrow;
    }
  }

  @override
  Future<HttpResponse> delete(
    final Uri uri, {
    final Map<String, String> headers = const {},
  }) async {
    try {
      final response = await decoratee.delete(uri, headers: headers);
      _logSuccess(uri, response, 'DELETE');
      return response;
    } catch (e) {
      _logError(uri, 'DELETE', e);
      rethrow;
    }
  }

  @override
  Future<HttpResponse> patch(
    final Uri uri, {
    final Map<String, dynamic> body = const {},
    final Map<String, String> headers = const {},
  }) async {
    try {
      final response = await decoratee.patch(uri, body: body, headers: headers);
      _logSuccess(uri, response, 'PATCH');
      return response;
    } catch (e) {
      _logError(uri, 'PATCH', e);
      rethrow;
    }
  }

  @override
  Future<HttpResponse> post(
    final Uri uri, {
    final Map<String, dynamic> body = const {},
    final Map<String, String> headers = const {},
  }) async {
    try {
      final response = await decoratee.post(uri, body: body, headers: headers);
      _logSuccess(uri, response, 'POST');
      return response;
    } catch (e) {
      _logError(uri, 'POST', e);
      rethrow;
    }
  }

  @override
  Future<HttpResponse> put(
    final Uri uri, {
    final Map<String, dynamic> body = const {},
    final Map<String, String> headers = const {},
  }) async {
    try {
      final response = await decoratee.put(uri, body: body, headers: headers);
      _logSuccess(uri, response, 'PUT');
      return response;
    } catch (e) {
      _logError(uri, 'PUT', e);
      rethrow;
    }
  }

  void _logSuccess(
    final Uri uri,
    final HttpResponse response,
    final String method,
  ) {
    final message = '[HTTP] $method $uri — status: ${response.statusCode}';
    logger.info(message);
  }

  void _logError(
    final Uri uri,
    final String method,
    final Object error,
  ) {
    final message = '[HTTP] $method $uri';
    logger.error(message, error: error);
  }
}
