import 'package:flutter_test/flutter_test.dart';
import 'package:olly_olly_challenge/core/domain/enums/auth/auth_status.dart';
import 'package:olly_olly_challenge/core/domain/use_cases/auth/fetch_auth_status_use_case.dart';

import '../../../../mocks/repositories/mock_auth_repository.dart';

void main() {
  late FetchAuthStatusUseCase sut;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    sut = FetchAuthStatusUseCaseImpl(mockRepository);
  });

  test('should return a stream of AuthStatus', () async {
    // arrange
    final stream = Stream.value(AuthStatus.authenticated);
    mockRepository.stubFetchAuthState(stream);

    // act
    final result = sut.call();

    // assert
    await expectLater(result, emits(AuthStatus.authenticated));
  });
}
