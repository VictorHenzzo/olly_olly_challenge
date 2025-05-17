import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/domain/exceptions/auth/sign_up_exceptions.dart';
import 'package:weather_app/core/domain/use_cases/auth/sign_up_use_case.dart';
import 'package:weather_app/core/infra/either/either.dart';

class MockSignUpUseCase extends Mock implements SignUpUseCase {
  void stubSignUp() {
    when(
      () => call(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((final _) async => const Right(null));
  }

  void stubSignUpException(final SignUpException exception) {
    when(
      () => call(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((final _) async => Left(exception));
  }
}
