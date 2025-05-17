import 'package:weather_app/core/domain/enums/auth/auth_status.dart';
import 'package:weather_app/core/domain/exceptions/auth/sign_in_exceptions.dart';
import 'package:weather_app/core/domain/exceptions/auth/sign_up_exceptions.dart';
import 'package:weather_app/core/infra/either/either.dart';
import 'package:weather_app/core/infra/exception/app_exception.dart';

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

  Future<Either<AppException, AuthStatus>> fetchAuthState();
}
