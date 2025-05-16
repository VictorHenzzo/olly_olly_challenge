import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/data/data_sources/http/http_data_source.dart';
import 'package:olly_olly_challenge/core/data/data_sources/http/http_exceptions.dart';
import 'package:olly_olly_challenge/core/data/data_sources/http/http_response.dart';

class MockHttpDataSource extends Mock implements HttpDataSource {
  void stubGet(final HttpResponse response) {
    when(() => get(any(), headers: any(named: 'headers')))
        .thenAnswer((final _) async => response);
  }

  void stubGetException(final HttpDataSourceException exception) {
    when(() => get(any(), headers: any(named: 'headers'))).thenThrow(exception);
  }
}
