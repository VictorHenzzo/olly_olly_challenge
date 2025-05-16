import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:olly_olly_challenge/core/data/data_sources/http/http_data_source.dart';
import 'package:olly_olly_challenge/core/data/data_sources/http/http_exception.dart';
import 'package:olly_olly_challenge/core/data/data_sources/http/http_response.dart';

class HttpDataSourceImpl implements HttpDataSource {
  HttpDataSourceImpl({
    required this.client,
  });

  final http.Client client;

  @override
  Future<HttpResponse> get(
    final Uri uri, {
    final Map<String, String> headers = const {},
  }) async {
    final response = await client.get(
      uri,
      headers: _decorateHeaders(headers),
    );

    return _transformResponse(response);
  }

  @override
  Future<HttpResponse> delete(
    final Uri uri, {
    final Map<String, String> headers = const {},
  }) async {
    final response = await client.delete(
      uri,
      headers: _decorateHeaders(headers),
    );

    return _transformResponse(response);
  }

  @override
  Future<HttpResponse> patch(
    final Uri uri, {
    final Map<String, dynamic> body = const {},
    final Map<String, String> headers = const {},
  }) async {
    final response = await client.patch(
      uri,
      headers: _decorateHeaders(headers),
      body: _encodeBody(body),
    );

    return _transformResponse(response);
  }

  @override
  Future<HttpResponse> post(
    final Uri uri, {
    final Map<String, dynamic> body = const {},
    final Map<String, String> headers = const {},
  }) async {
    final response = await client.post(
      uri,
      headers: _decorateHeaders(headers),
      body: _encodeBody(body),
    );

    return _transformResponse(response);
  }

  @override
  Future<HttpResponse> put(
    final Uri uri, {
    final Map<String, dynamic> body = const {},
    final Map<String, String> headers = const {},
  }) async {
    final response = await client.put(
      uri,
      headers: _decorateHeaders(headers),
      body: _encodeBody(body),
    );

    return _transformResponse(response);
  }

  Map<String, String> _decorateHeaders(final Map<String, String> headers) {
    return {
      ...headers,
      'Content-Type': 'application/json',
    };
  }

  String _encodeBody(final Map<String, dynamic> body) {
    return jsonEncode(body);
  }

  HttpResponse _transformResponse(final http.Response response) {
    if (response.statusCode >= 400) {
      throw HttpException.fromStatusCode(
        response.statusCode,
        response.body,
      );
    }

    return HttpResponse(
      statusCode: response.statusCode,
      body: response.body,
    );
  }
}
