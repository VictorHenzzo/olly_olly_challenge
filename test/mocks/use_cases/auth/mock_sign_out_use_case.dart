import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/domain/use_cases/auth/sign_out_use_case.dart';
import 'package:olly_olly_challenge/core/infra/either/either.dart';
import 'package:olly_olly_challenge/core/infra/exception/app_exception.dart';

class MockSignOutUseCase extends Mock implements SignOutUseCase {
  void stubSignOut() {
    when(call).thenAnswer(
      (final _) async => const Right(null),
    );
  }

  void stubSignOutException(final AppException exception) {
    when(call).thenAnswer(
      (final _) async => Left(exception),
    );
  }
}
