import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/data/data_sources/http/http_data_source.dart';
import 'package:olly_olly_challenge/core/data/data_sources/http/http_response.dart';

class MockHttpDataSource extends Mock implements HttpDataSource {
  void stubGet(final HttpResponse response) {
    when(() => get(any(), headers: any(named: 'headers')))
        .thenAnswer((final _) async => response);
  }

  void stubGetException(final Object exception) {
    when(() => get(any(), headers: any(named: 'headers'))).thenThrow(exception);
  }

  void stubPost(final HttpResponse response) {
    when(
      () => post(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((final _) async => response);
  }

  void stubPostException(final Object exception) {
    when(
      () => post(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ),
    ).thenThrow(exception);
  }

  void stubPut(final HttpResponse response) {
    when(
      () => put(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((final _) async => response);
  }

  void stubPutException(final Object exception) {
    when(
      () => put(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ),
    ).thenThrow(exception);
  }

  void stubPatch(final HttpResponse response) {
    when(
      () => patch(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((final _) async => response);
  }

  void stubPatchException(final Object exception) {
    when(
      () => patch(
        any(),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      ),
    ).thenThrow(exception);
  }

  void stubDelete(final HttpResponse response) {
    when(() => delete(any(), headers: any(named: 'headers')))
        .thenAnswer((final _) async => response);
  }

  void stubDeleteException(final Object exception) {
    when(() => delete(any(), headers: any(named: 'headers')))
        .thenThrow(exception);
  }
}
