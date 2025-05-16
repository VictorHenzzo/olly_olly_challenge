import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/domain/exceptions/auth/sign_in_exceptions.dart';
import 'package:olly_olly_challenge/core/domain/use_cases/auth/sign_in_use_case.dart';
import 'package:olly_olly_challenge/core/infra/either/either.dart';

class MockSignInUseCase extends Mock implements SignInUseCase {
  void stubSignIn() {
    when(
      () => call(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((final _) async => const Right(null));
  }

  void stubSignInException(final SignInException exception) {
    when(
      () => call(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((final _) async => Left(exception));
  }
}
