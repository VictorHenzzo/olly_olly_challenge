/// Provides logging capabilities to record messages, warnings, and errors.
///
/// Use this to track application behavior, report issues, and aid in debugging.
/// Log entries can include optional error objects and stack traces to give
/// additional context when something goes wrong.
abstract class Logger {
  /// Records an informational message.
  ///
  /// Use for events that are part of normal application flow,
  /// like successful actions, startup events, or configuration loads.
  ///
  /// - [message]: The content to be logged.
  /// - [error]: (Optional) A related error or object for context.
  /// - [stackTrace]: (Optional) Stack trace associated with the event.
  void info(
    final String message, {
    final Object? error,
    final StackTrace? stackTrace,
  });

  /// Records a warning.
  ///
  /// Use when something unexpected happens that isn’t necessarily an error,
  /// such as fallback logic, deprecated usage, or recoverable failures.
  ///
  /// - [message]: Description of the warning.
  /// - [error]: (Optional) A related error or object for context.
  /// - [stackTrace]: (Optional) Stack trace to help identify the source.
  void warning(
    final String message, {
    final Object? error,
    final StackTrace? stackTrace,
  });

  /// Records an error.
  ///
  /// Use when something fails, especially if it needs developer attention.
  /// This is useful for debugging, alerting, or crash reporting.
  ///
  /// - [message]: Description of the error event.
  /// - [error]: (Optional) The actual exception or error object.
  /// - [stackTrace]: (Optional) Stack trace at the point of failure.
  void error(
    final String message, {
    final Object? error,
    final StackTrace? stackTrace,
  });
}
