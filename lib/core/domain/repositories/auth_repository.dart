import 'package:olly_olly_challenge/core/domain/exceptions/auth/sign_in_exceptions.dart';
import 'package:olly_olly_challenge/core/domain/exceptions/auth/sign_up_exceptions.dart';
import 'package:olly_olly_challenge/core/infra/either/either.dart';
import 'package:olly_olly_challenge/core/infra/exception/app_exception.dart';

abstract class AuthRepository {
  Future<Either<SignUpException, void>> signUpWithEmailAndPassword({
    required final String email,
    required final String password,
  });

  Future<Either<SignInException, void>> signInWithEmailAndPassword({
    required final String email,
    required final String password,
  });

  Future<Either<AppException, void>> signOut();
}
