import 'package:injectable/injectable.dart';
import 'package:weather_app/core/domain/exceptions/auth/sign_in_exceptions.dart';
import 'package:weather_app/core/domain/repositories/auth_repository.dart';
import 'package:weather_app/core/infra/either/either.dart';

abstract class SignInUseCase {
  Future<Either<SignInException, void>> call({
    required final String email,
    required final String password,
  });
}

@Injectable(as: SignInUseCase)
class SignInUseCaseImpl implements SignInUseCase {
  SignInUseCaseImpl(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<Either<SignInException, void>> call({
    required final String email,
    required final String password,
  }) =>
      authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
}
