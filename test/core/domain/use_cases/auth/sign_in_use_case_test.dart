import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/domain/exceptions/auth/sign_in_exceptions.dart';
import 'package:weather_app/core/domain/use_cases/auth/sign_in_use_case.dart';
import 'package:weather_app/core/infra/either/either.dart';

import '../../../../mocks/repositories/mock_auth_repository.dart';

void main() {
  late SignInUseCaseImpl useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = SignInUseCaseImpl(mockRepository);
  });

  const email = 'test@example.com';
  const password = 'password123';

  test('should return void on success and call repository once', () async {
    // arrange
    mockRepository.stubSignInWithEmailAndPassword(const Right(null));

    // act
    final result = await useCase(email: email, password: password);

    // assert
    expect(result, const Right<SignInException, void>(null));
    verify(
      () => mockRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return SignInException on failure and call repository once',
      () async {
    // arrange
    const exception = WrongPasswordSignInException();
    mockRepository.stubSignInWithEmailAndPassword(const Left(exception));

    // act
    final result = await useCase(email: email, password: password);

    // assert
    expect(result, const Left<SignInException, void>(exception));
    verify(
      () => mockRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
