import 'package:logger/logger.dart' as logger;
import 'package:olly_olly_challenge/core/infra/logger/logger.dart';

class DebugLogger extends Logger {
  DebugLogger({
    required final logger.Logger logger,
  }) : _logger = logger;
  final logger.Logger _logger;

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
