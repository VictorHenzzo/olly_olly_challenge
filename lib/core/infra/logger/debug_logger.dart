import 'package:olly_olly_challenge/core/infra/logger/logger.dart';
import 'package:logger/logger.dart' as logger;

class DebugLogger extends Logger {
  final logger.Logger _logger;

  DebugLogger({
    required final logger.Logger logger,
  }) : _logger = logger;

  @override
  void info(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  @override
  void warning(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }
}
