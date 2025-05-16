import 'package:olly_olly_challenge/core/domain/exceptions/auth/sign_up_exceptions.dart';

import 'package:olly_olly_challenge/core/infra/either/either.dart';

abstract class AuthRepository {
  Future<Either<SignUpException, void>> signUpWithEmailAndPassword({
    required final String email,
    required final String password,
  });
}
