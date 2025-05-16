import 'package:olly_olly_challenge/core/domain/enums/auth/auth_status.dart';
import 'package:olly_olly_challenge/core/domain/repositories/auth_repository.dart';

abstract class FetchAuthStatusUseCase {
  Stream<AuthStatus> call();
}

class FetchAuthStatusUseCaseImpl implements FetchAuthStatusUseCase {
  FetchAuthStatusUseCaseImpl(this._repository);

  final AuthRepository _repository;

  @override
  Stream<AuthStatus> call() => _repository.fetchAuthState();
}
