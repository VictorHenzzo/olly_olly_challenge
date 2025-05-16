import 'package:flutter_test/flutter_test.dart';
import 'package:olly_olly_challenge/core/domain/enums/auth/auth_status.dart';
import 'package:olly_olly_challenge/core/domain/use_cases/auth/fetch_auth_status_use_case.dart';
import 'package:olly_olly_challenge/core/infra/either/either.dart';
import 'package:olly_olly_challenge/core/infra/exception/app_exception.dart';

import '../../../../mocks/repositories/mock_auth_repository.dart';

void main() {
  late FetchAuthStatusUseCase sut;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    sut = FetchAuthStatusUseCaseImpl(mockRepository);
  });

  test('should return AuthStatus when successful', () async {
    // arrange
    mockRepository.stubFetchAuthState(
      const Right(AuthStatus.authenticated),
    );

    // act
    final result = await sut.call();

    // assert
    expect(result.isRight, isTrue);
    expect(result.rightOrNull, equals(AuthStatus.authenticated));
  });

  test('should return AppException when fails', () async {
    // arrange
    mockRepository.stubFetchAuthState(
      const Left(AppException('error')),
    );

    // act
    final result = await sut.call();

    // assert
    expect(result.isLeft, isTrue);
    expect(result.leftOrNull, isA<AppException>());
  });
}
