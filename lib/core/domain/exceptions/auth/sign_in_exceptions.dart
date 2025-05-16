import 'package:olly_olly_challenge/core/infra/exception/app_exception.dart';

sealed class SignInException extends AppException {
  const SignInException([super.message]);

  factory SignInException.fromCode(final String code) {
    switch (code) {
      case 'invalid-credential':
        return InvalidCredentialSignInException(code);
      case 'user-not-found':
        return UserNotFoundSignInException(code);
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

class UserNotFoundSignInException extends SignInException {
  const UserNotFoundSignInException([super.message]);
}

class WrongPasswordSignInException extends SignInException {
  const WrongPasswordSignInException([super.message]);
}

class UnknownSignInException extends SignInException {
  const UnknownSignInException([super.message]);
}
