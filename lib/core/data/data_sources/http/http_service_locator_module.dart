import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:olly_olly_challenge/core/data/data_sources/http/http_data_source.dart';
import 'package:olly_olly_challenge/core/data/data_sources/http/http_data_source_impl.dart';
import 'package:olly_olly_challenge/core/data/data_sources/http/logger_data_source_decorator.dart';
import 'package:olly_olly_challenge/core/infra/logger/logger.dart';

@module
abstract class HttpServiceLocatorModule {
  @lazySingleton
  Client get httpClient => Client();

  @lazySingleton
  HttpDataSource httpDataSource(final Client client, final Logger logger) {
    final dataSource = HttpDataSourceImpl(client: httpClient);
    return LoggerDataSourceDecorator(decoratee: dataSource, logger: logger);
  }
}
