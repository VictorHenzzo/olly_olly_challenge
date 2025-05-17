import 'package:injectable/injectable.dart';
import 'package:weather_app/core/domain/repositories/auth_repository.dart';
import 'package:weather_app/core/infra/either/either.dart';
import 'package:weather_app/core/infra/exception/app_exception.dart';

abstract class SignOutUseCase {
  Future<Either<AppException, void>> call();
}

@Injectable(as: SignOutUseCase)
class SignOutUseCaseImpl implements SignOutUseCase {
  SignOutUseCaseImpl(this.authRepository);

  final AuthRepository authRepository;

  @override
  Future<Either<AppException, void>> call() => authRepository.signOut();
}
