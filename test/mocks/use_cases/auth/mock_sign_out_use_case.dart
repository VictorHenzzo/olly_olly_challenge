import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/domain/use_cases/auth/sign_out_use_case.dart';
import 'package:weather_app/core/infra/either/either.dart';
import 'package:weather_app/core/infra/exception/app_exception.dart';

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
