import 'package:weather_app/core/infra/exception/app_exception.dart';

/// Base exception class for errors that occur when trying to open app settings.
sealed class OpenAppSettingsException extends AppException {
  const OpenAppSettingsException([super.message]);
}

final class PlatformNotSupportedOpenAppSettingsException
    extends OpenAppSettingsException {
  const PlatformNotSupportedOpenAppSettingsException([super.message]);
}

final class UnknownOpenAppSettingsException extends OpenAppSettingsException {
  const UnknownOpenAppSettingsException([super.message]);
}
