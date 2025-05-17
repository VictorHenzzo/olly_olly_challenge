import 'package:injectable/injectable.dart';
import 'package:weather_app/core/domain/exceptions/auth/sign_up_exceptions.dart';
import 'package:weather_app/core/domain/repositories/auth_repository.dart';
import 'package:weather_app/core/infra/either/either.dart';

abstract class SignUpUseCase {
  Future<Either<SignUpException, void>> call({
    required final String email,
    required final String password,
  });
}

@Injectable(as: SignUpUseCase)
class SignUpUseCaseImpl implements SignUpUseCase {
  SignUpUseCaseImpl(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<Either<SignUpException, void>> call({
    required final String email,
    required final String password,
  }) =>
      authRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
}
