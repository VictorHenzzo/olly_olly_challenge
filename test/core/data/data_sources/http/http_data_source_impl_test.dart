import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/data/data_sources/http/http_data_source_impl.dart';
import 'package:olly_olly_challenge/core/data/data_sources/http/http_exceptions.dart';
import 'package:olly_olly_challenge/core/data/data_sources/http/http_response.dart';

import '../../../../test_helpers.dart';

void main() {
  late HttpDataSourceImpl dataSource;
  late _MockClient mockClient;

  setUpAll(TestHelpers.registerFallbackValues);

  setUp(() {
    mockClient = _MockClient();
    dataSource = HttpDataSourceImpl(client: mockClient);
  });

  final uri = Uri.parse('https://api.example.com/test');
  final headers = {'Authorization': 'Bearer token'};
  final body = {'data': 'test'};
  final response = http.Response('{"data": "test"}', 200);
  final badRequestResponse = http.Response('{"error": "Bad Request"}', 400);
  final serverErrorResponse = http.Response('{"error": "Server Error"}', 500);

  group('GET', () {
    test('should call client.get with correct values', () async {
      // arrange
      mockClient.stubGet(response);

      // act
      await dataSource.get(uri, headers: headers);

      // assert
      verify(
        () => mockClient.get(
          uri,
          headers: {
            ...headers,
            'Content-Type': 'application/json',
          },
        ),
      ).called(1);
      verifyNoMoreInteractions(mockClient);
    });

    test('should convert response to HttpResponse', () async {
      // arrange
      mockClient.stubGet(response);

      // act
      final result = await dataSource.get(uri);

      // assert
      expect(result, isA<HttpResponse>());
      expect(result.statusCode, equals(200));
      expect(result.body, equals('{"data": "test"}'));
    });

    test('should rethrow client exception', () async {
      // arrange
      final exception = Exception('Network error');
      mockClient.stubGetException(exception);

      // act & assert
      expect(
        () => dataSource.get(uri),
        throwsA(
          isA<HttpDataSourceException>().having(
            (final e) => e.message,
            'message',
            contains('Network error'),
          ),
        ),
      );
    });

    test('should convert 4xx response to HttpException', () async {
      // arrange
      mockClient.stubGet(badRequestResponse);

      // act & assert
      expect(
        () => dataSource.get(uri),
        throwsA(
          isA<BadRequestException>().having(
            (final e) => e.message,
            'message',
            '{"error": "Bad Request"}',
          ),
        ),
      );
    });

    test('should convert 5xx response to HttpException', () async {
      // arrange
      mockClient.stubGet(serverErrorResponse);

      // act & assert
      expect(
        () => dataSource.get(uri),
        throwsA(
          isA<ServerException>().having(
            (final e) => e.message,
            'message',
            '{"error": "Server Error"}',
          ),
        ),
      );
    });
  });

  group('POST', () {
    test('should call client.post with correct values', () async {
      // arrange
      mockClient.stubPost(response);

      // act
      await dataSource.post(uri, body: body, headers: headers);

      // assert
      verify(
        () => mockClient.post(
          uri,
          headers: {
            ...headers,
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockClient);
    });

    test('should convert response to HttpResponse', () async {
      // arrange
      mockClient.stubPost(response);

      // act
      final result = await dataSource.post(uri, body: body);

      // assert
      expect(result, isA<HttpResponse>());
      expect(result.statusCode, equals(200));
      expect(result.body, equals('{"data": "test"}'));
    });

    test('should rethrow client exception', () async {
      // arrange
      final exception = Exception('Network error');
      mockClient.stubPostException(exception);

      // act & assert
      expect(
        () => dataSource.post(uri, body: body),
        throwsA(
          isA<HttpDataSourceException>().having(
            (final e) => e.message,
            'message',
            contains('Network error'),
          ),
        ),
      );
    });

    test('should convert 4xx response to HttpException', () async {
      // arrange
      mockClient.stubPost(badRequestResponse);

      // act & assert
      expect(
        () => dataSource.post(uri, body: body),
        throwsA(
          isA<BadRequestException>().having(
            (final e) => e.message,
            'message',
            '{"error": "Bad Request"}',
          ),
        ),
      );
    });

    test('should convert 5xx response to HttpException', () async {
      // arrange
      mockClient.stubPost(serverErrorResponse);

      // act & assert
      expect(
        () => dataSource.post(uri, body: body),
        throwsA(
          isA<ServerException>().having(
            (final e) => e.message,
            'message',
            '{"error": "Server Error"}',
          ),
        ),
      );
    });
  });

  group('PUT', () {
    test('should call client.put with correct values', () async {
      // arrange
      mockClient.stubPut(response);

      // act
      await dataSource.put(uri, body: body, headers: headers);

      // assert
      verify(
        () => mockClient.put(
          uri,
          headers: {
            ...headers,
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockClient);
    });

    test('should convert response to HttpResponse', () async {
      // arrange
      mockClient.stubPut(response);

      // act
      final result = await dataSource.put(uri, body: body);

      // assert
      expect(result, isA<HttpResponse>());
      expect(result.statusCode, equals(200));
      expect(result.body, equals('{"data": "test"}'));
    });

    test('should rethrow client exception', () async {
      // arrange
      final exception = Exception('Network error');
      mockClient.stubPutException(exception);

      // act & assert
      expect(
        () => dataSource.put(uri, body: body),
        throwsA(
          isA<HttpDataSourceException>().having(
            (final e) => e.message,
            'message',
            contains('Network error'),
          ),
        ),
      );
    });

    test('should convert 4xx response to HttpException', () async {
      // arrange
      mockClient.stubPut(badRequestResponse);

      // act & assert
      expect(
        () => dataSource.put(uri, body: body),
        throwsA(
          isA<BadRequestException>().having(
            (final e) => e.message,
            'message',
            '{"error": "Bad Request"}',
          ),
        ),
      );
    });

    test('should convert 5xx response to HttpException', () async {
      // arrange
      mockClient.stubPut(serverErrorResponse);

      // act & assert
      expect(
        () => dataSource.put(uri, body: body),
        throwsA(
          isA<ServerException>().having(
            (final e) => e.message,
            'message',
            '{"error": "Server Error"}',
          ),
        ),
      );
    });
  });

  group('PATCH', () {
    test('should call client.patch with correct values', () async {
      // arrange
      mockClient.stubPatch(response);

      // act
      await dataSource.patch(uri, body: body, headers: headers);

      // assert
      verify(
        () => mockClient.patch(
          uri,
          headers: {
            ...headers,
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockClient);
    });

    test('should convert response to HttpResponse', () async {
      // arrange
      mockClient.stubPatch(response);

      // act
      final result = await dataSource.patch(uri, body: body);

      // assert
      expect(result, isA<HttpResponse>());
      expect(result.statusCode, equals(200));
      expect(result.body, equals('{"data": "test"}'));
    });

    test('should rethrow client exception', () async {
      // arrange
      final exception = Exception('Network error');
      mockClient.stubPatchException(exception);

      // act & assert
      expect(
        () => dataSource.patch(uri, body: body),
        throwsA(
          isA<HttpDataSourceException>().having(
            (final e) => e.message,
            'message',
            contains('Network error'),
          ),
        ),
      );
    });

    test('should convert 4xx response to HttpException', () async {
      // arrange
      mockClient.stubPatch(badRequestResponse);

      // act & assert
      expect(
        () => dataSource.patch(uri, body: body),
        throwsA(
          isA<BadRequestException>().having(
            (final e) => e.message,
            'message',
            '{"error": "Bad Request"}',
          ),
        ),
      );
    });

    test('should convert 5xx response to HttpException', () async {
      // arrange
      mockClient.stubPatch(serverErrorResponse);

      // act & assert
      expect(
        () => dataSource.patch(uri, body: body),
        throwsA(
          isA<ServerException>().having(
            (final e) => e.message,
            'message',
            '{"error": "Server Error"}',
          ),
        ),
      );
    });
  });

  group('DELETE', () {
    test('should call client.delete with correct values', () async {
      // arrange
      mockClient.stubDelete(response);

      // act
      await dataSource.delete(uri, headers: headers);

      // assert
      verify(
        () => mockClient.delete(
          uri,
          headers: {
            ...headers,
            'Content-Type': 'application/json',
          },
        ),
      ).called(1);
      verifyNoMoreInteractions(mockClient);
    });

    test('should convert response to HttpResponse', () async {
      // arrange
      mockClient.stubDelete(response);

      // act
      final result = await dataSource.delete(uri);

      // assert
      expect(result, isA<HttpResponse>());
      expect(result.statusCode, equals(200));
      expect(result.body, equals('{"data": "test"}'));
    });

    test('should rethrow client exception', () async {
      // arrange
      final exception = Exception('Network error');
      mockClient.stubDeleteException(exception);

      // act & assert
      expect(
        () => dataSource.delete(uri),
        throwsA(
          isA<HttpDataSourceException>().having(
            (final e) => e.message,
            'message',
            contains('Network error'),
          ),
        ),
      );
    });

    test('should convert 4xx response to HttpException', () async {
      // arrange
      mockClient.stubDelete(badRequestResponse);

      // act & assert
      expect(
        () => dataSource.delete(uri),
        throwsA(
          isA<BadRequestException>().having(
            (final e) => e.message,
            'message',
            '{"error": "Bad Request"}',
          ),
        ),
      );
    });

    test('should convert 5xx response to HttpException', () async {
      // arrange
      mockClient.stubDelete(serverErrorResponse);

      // act & assert
      expect(
        () => dataSource.delete(uri),
        throwsA(
          isA<ServerException>().having(
            (final e) => e.message,
            'message',
            '{"error": "Server Error"}',
          ),
        ),
      );
    });
  });
}

class _MockClient extends Mock implements http.Client {
  void stubGet(final http.Response response) {
    when(
      () => get(
        any(),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((final _) async => response);
  }

  void stubGetException(final Object throwable) {
    when(
      () => get(
        any(),
        headers: any(named: 'headers'),
      ),
    ).thenThrow(throwable);
  }

  void stubPost(final http.Response response) {
    when(
      () => post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((final _) async => response);
  }

  void stubPostException(final Object throwable) {
    when(
      () => post(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenThrow(throwable);
  }

  void stubPut(final http.Response response) {
    when(
      () => put(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((final _) async => response);
  }

  void stubPutException(final Object throwable) {
    when(
      () => put(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenThrow(throwable);
  }

  void stubPatch(final http.Response response) {
    when(
      () => patch(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((final _) async => response);
  }

  void stubPatchException(final Object throwable) {
    when(
      () => patch(
        any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenThrow(throwable);
  }

  void stubDelete(final http.Response response) {
    when(
      () => delete(
        any(),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((final _) async => response);
  }

  void stubDeleteException(final Object throwable) {
    when(
      () => delete(
        any(),
        headers: any(named: 'headers'),
      ),
    ).thenThrow(throwable);
  }
}
