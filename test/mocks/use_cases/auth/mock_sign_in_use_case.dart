import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/domain/exceptions/auth/sign_in_exceptions.dart';
import 'package:weather_app/core/domain/use_cases/auth/sign_in_use_case.dart';
import 'package:weather_app/core/infra/either/either.dart';

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
