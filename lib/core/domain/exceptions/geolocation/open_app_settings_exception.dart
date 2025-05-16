import 'package:olly_olly_challenge/core/infra/exception/app_exception.dart';

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
