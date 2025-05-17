import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/domain/exceptions/auth/sign_up_exceptions.dart';
import 'package:weather_app/core/domain/use_cases/auth/sign_up_use_case.dart';
import 'package:weather_app/core/infra/either/either.dart';

import '../../../../mocks/repositories/mock_auth_repository.dart';

void main() {
  late SignUpUseCaseImpl useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = SignUpUseCaseImpl(mockRepository);
  });

  const email = 'test@example.com';
  const password = 'password123';

  test('should return void on success and call repository once', () async {
    // arrange
    mockRepository.stubSignUpWithEmailAndPassword(const Right(null));

    // act
    final result = await useCase(email: email, password: password);

    // assert
    expect(result, const Right<SignUpException, void>(null));
    verify(
      () => mockRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return SignUpException on failure and call repository once',
      () async {
    // arrange
    const exception = EmailAlreadyInUseSignUpException(
      'email-already-in-use',
    );
    mockRepository.stubSignUpWithEmailAndPassword(const Left(exception));

    // act
    final result = await useCase(email: email, password: password);

    // assert
    expect(result, const Left<SignUpException, void>(exception));
    verify(
      () => mockRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
