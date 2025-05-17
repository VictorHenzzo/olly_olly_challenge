import 'package:injectable/injectable.dart';
import 'package:weather_app/core/domain/enums/auth/auth_status.dart';
import 'package:weather_app/core/domain/repositories/auth_repository.dart';
import 'package:weather_app/core/infra/either/either.dart';
import 'package:weather_app/core/infra/exception/app_exception.dart';

abstract class FetchAuthStatusUseCase {
  Future<Either<AppException, AuthStatus>> call();
}

@Injectable(as: FetchAuthStatusUseCase)
class FetchAuthStatusUseCaseImpl implements FetchAuthStatusUseCase {
  FetchAuthStatusUseCaseImpl(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<AppException, AuthStatus>> call() =>
      _repository.fetchAuthState();
}
