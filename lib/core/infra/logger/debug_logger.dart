import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart' as l;
import 'package:olly_olly_challenge/core/infra/logger/logger.dart';

@Injectable(as: Logger)
class DebugLogger extends Logger {
  DebugLogger() : _logger = l.Logger();
  final l.Logger _logger;

  @override
  void info(
    final String message, {
    final Object? error,
    final StackTrace? stackTrace,
  }) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  @override
  void error(
    final String message, {
    final Object? error,
    final StackTrace? stackTrace,
  }) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  @override
  void warning(
    final String message, {
    final Object? error,
    final StackTrace? stackTrace,
  }) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }
}
