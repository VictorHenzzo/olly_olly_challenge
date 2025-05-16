import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/data/data_sources/http/http_response.dart';
import 'package:olly_olly_challenge/core/data/data_sources/http/logger_data_source_decorator.dart';
import 'package:olly_olly_challenge/core/infra/exception/app_exception.dart';

import '../../../../mocks/data_sources/mock_http_data_source.dart';
import '../../../../mocks/infra/mock_logger.dart';
import '../../../../test_helpers.dart';

void main() {
  late MockHttpDataSource mockHttpDataSource;
  late MockLogger mockLogger;
  late LoggerDataSourceDecorator decorator;

  final uri = Uri.parse('https://test.com');
  const headers = {'Content-Type': 'application/json'};
  const body = {'data': 'test'};
  const response = HttpResponse(statusCode: 200, body: '{"data": "test"}');
  const exception = AppException('Test error');

  setUpAll(TestHelpers.registerFallbackValues);

  setUp(() {
    mockHttpDataSource = MockHttpDataSource();
    mockLogger = MockLogger();
    decorator = LoggerDataSourceDecorator(
      decoratee: mockHttpDataSource,
      logger: mockLogger,
    );
  });

  group('get', () {
    test('on success, should call decoratee then logger and return response',
        () async {
      // arrange
      mockHttpDataSource.stubGet(response);

      // act
      final result = await decorator.get(uri, headers: headers);

      // assert
      verifyInOrder([
        () => mockHttpDataSource.get(uri, headers: headers),
        () => mockLogger.info('[HTTP] GET $uri — status: 200'),
      ]);
      expect(result, response);
    });

    test('on failure, should call decoratee then logger and rethrow', () async {
      // arrange
      mockHttpDataSource.stubGetException(exception);

      // act
      final call = decorator.get(uri, headers: headers);

      // assert
      await expectLater(call, throwsA(exception));
      verifyInOrder([
        () => mockHttpDataSource.get(uri, headers: headers),
        () => mockLogger.error(
              '[HTTP] GET $uri',
              error: exception,
            ),
      ]);
    });
  });

  group('post', () {
    test('on success, should call decoratee then logger and return response',
        () async {
      // arrange
      mockHttpDataSource.stubPost(response);

      // act
      final result = await decorator.post(uri, body: body, headers: headers);

      // assert
      verifyInOrder([
        () => mockHttpDataSource.post(uri, body: body, headers: headers),
        () => mockLogger.info('[HTTP] POST $uri — status: 200'),
      ]);
      expect(result, response);
    });

    test('on failure, should call decoratee then logger and rethrow', () async {
      // arrange
      mockHttpDataSource.stubPostException(exception);

      // act
      final call = decorator.post(uri, body: body, headers: headers);

      // assert
      await expectLater(call, throwsA(exception));
      verifyInOrder([
        () => mockHttpDataSource.post(uri, body: body, headers: headers),
        () => mockLogger.error(
              '[HTTP] POST $uri',
              error: exception,
            ),
      ]);
    });
  });

  group('put', () {
    test('on success, should call decoratee then logger and return response',
        () async {
      // arrange
      mockHttpDataSource.stubPut(response);

      // act
      final result = await decorator.put(uri, body: body, headers: headers);

      // assert
      verifyInOrder([
        () => mockHttpDataSource.put(uri, body: body, headers: headers),
        () => mockLogger.info('[HTTP] PUT $uri — status: 200'),
      ]);
      expect(result, response);
    });

    test('on failure, should call decoratee then logger and rethrow', () async {
      // arrange
      mockHttpDataSource.stubPutException(exception);

      // act
      final call = decorator.put(uri, body: body, headers: headers);

      // assert
      await expectLater(call, throwsA(exception));
      verifyInOrder([
        () => mockHttpDataSource.put(uri, body: body, headers: headers),
        () => mockLogger.error(
              '[HTTP] PUT $uri',
              error: exception,
            ),
      ]);
    });
  });

  group('patch', () {
    test('on success, should call decoratee then logger and return response',
        () async {
      // arrange
      mockHttpDataSource.stubPatch(response);

      // act
      final result = await decorator.patch(uri, body: body, headers: headers);

      // assert
      verifyInOrder([
        () => mockHttpDataSource.patch(uri, body: body, headers: headers),
        () => mockLogger.info('[HTTP] PATCH $uri — status: 200'),
      ]);
      expect(result, response);
    });

    test('on failure, should call decoratee then logger and rethrow', () async {
      // arrange
      mockHttpDataSource.stubPatchException(exception);

      // act
      final call = decorator.patch(uri, body: body, headers: headers);

      // assert
      await expectLater(call, throwsA(exception));
      verifyInOrder([
        () => mockHttpDataSource.patch(uri, body: body, headers: headers),
        () => mockLogger.error(
              '[HTTP] PATCH $uri',
              error: exception,
            ),
      ]);
    });
  });

  group('delete', () {
    test('on success, should call decoratee then logger and return response',
        () async {
      // arrange
      mockHttpDataSource.stubDelete(response);

      // act
      final result = await decorator.delete(uri, headers: headers);

      // assert
      verifyInOrder([
        () => mockHttpDataSource.delete(uri, headers: headers),
        () => mockLogger.info('[HTTP] DELETE $uri — status: 200'),
      ]);
      expect(result, response);
    });

    test('on failure, should call decoratee then logger and rethrow', () async {
      // arrange
      mockHttpDataSource.stubDeleteException(exception);

      // act
      final call = decorator.delete(uri, headers: headers);

      // assert
      await expectLater(call, throwsA(exception));
      verifyInOrder([
        () => mockHttpDataSource.delete(uri, headers: headers),
        () => mockLogger.error(
              '[HTTP] DELETE $uri',
              error: exception,
            ),
      ]);
    });
  });
}
