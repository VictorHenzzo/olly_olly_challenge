import 'package:injectable/injectable.dart';
import 'package:olly_olly_challenge/core/domain/enums/auth/auth_status.dart';
import 'package:olly_olly_challenge/core/domain/repositories/auth_repository.dart';
import 'package:olly_olly_challenge/core/infra/either/either.dart';
import 'package:olly_olly_challenge/core/infra/exception/app_exception.dart';

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
