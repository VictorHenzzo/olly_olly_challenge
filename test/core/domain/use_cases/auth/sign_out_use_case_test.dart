import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/domain/use_cases/auth/sign_out_use_case.dart';
import 'package:weather_app/core/infra/either/either.dart';
import 'package:weather_app/core/infra/exception/app_exception.dart';

import '../../../../mocks/repositories/mock_auth_repository.dart';

void main() {
  late SignOutUseCaseImpl useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = SignOutUseCaseImpl(mockRepository);
  });

  test('should return void on success and call repository once', () async {
    // arrange
    mockRepository.stubSignOut(const Right(null));

    // act
    final result = await useCase();

    // assert
    expect(result, const Right<AppException, void>(null));
    verify(() => mockRepository.signOut()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return AppException on failure and call repository once',
      () async {
    // arrange
    const exception = AppException('error');
    mockRepository.stubSignOut(const Left(exception));

    // act
    final result = await useCase();

    // assert
    expect(result, const Left<AppException, void>(exception));
    verify(() => mockRepository.signOut()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
