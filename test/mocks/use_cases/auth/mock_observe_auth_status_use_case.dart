import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/domain/enums/auth/auth_status.dart';
import 'package:weather_app/core/domain/use_cases/auth/fetch_auth_status_use_case.dart';
import 'package:weather_app/core/infra/either/either.dart';
import 'package:weather_app/core/infra/exception/app_exception.dart';

class MockFetchAuthStatusUseCase extends Mock
    implements FetchAuthStatusUseCase {
  void stubCall(final Either<AppException, AuthStatus> result) {
    when(call).thenAnswer((final _) async => result);
  }
}
