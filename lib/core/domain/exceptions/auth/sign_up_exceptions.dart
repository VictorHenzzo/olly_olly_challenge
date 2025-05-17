import 'package:weather_app/core/infra/exception/app_exception.dart';

sealed class SignUpException extends AppException {
  const SignUpException([super.message]);

  factory SignUpException.fromCode(final String code) {
    switch (code) {
      case 'email-already-in-use':
        return EmailAlreadyInUseSignUpException(code);
      case 'invalid-email':
        return InvalidEmailSignUpException(code);
      case 'weak-password':
        return WeakPasswordSignUpException(code);
      default:
        return UnknownSignUpException(code);
    }
  }
}

final class EmailAlreadyInUseSignUpException extends SignUpException {
  const EmailAlreadyInUseSignUpException(super.message);
}

final class InvalidEmailSignUpException extends SignUpException {
  const InvalidEmailSignUpException(super.message);
}

final class WeakPasswordSignUpException extends SignUpException {
  const WeakPasswordSignUpException(super.message);
}

final class UnknownSignUpException extends SignUpException {
  const UnknownSignUpException([super.message]);
}
