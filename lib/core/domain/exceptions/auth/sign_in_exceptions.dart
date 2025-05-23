import 'package:weather_app/core/infra/exception/app_exception.dart';

/// Base exception class for sign in related errors.
sealed class SignInException extends AppException {
  const SignInException([super.message]);

  /// Creates a [SignInException] from a given error code.
  factory SignInException.fromCode(final String code) {
    switch (code) {
      case 'invalid-credential':
        return InvalidCredentialSignInException(code);
      case 'user-not-found':
        return UserNotFoundSignInException(code);
      case 'invalid-email':
        return InvalidEmailSignInException(code);
      case 'wrong-password':
        return WrongPasswordSignInException(code);

      default:
        return UnknownSignInException(code);
    }
  }
}

class InvalidCredentialSignInException extends SignInException {
  const InvalidCredentialSignInException([super.message]);
}

class InvalidEmailSignInException extends SignInException {
  const InvalidEmailSignInException([super.message]);
}

class UserNotFoundSignInException extends SignInException {
  const UserNotFoundSignInException([super.message]);
}

class WrongPasswordSignInException extends SignInException {
  const WrongPasswordSignInException([super.message]);
}

class UnknownSignInException extends SignInException {
  const UnknownSignInException([super.message]);
}
