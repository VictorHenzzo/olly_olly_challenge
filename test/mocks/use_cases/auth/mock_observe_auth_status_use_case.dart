import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/domain/enums/auth/auth_status.dart';
import 'package:olly_olly_challenge/core/domain/use_cases/auth/fetch_auth_status_use_case.dart';
import 'package:olly_olly_challenge/core/infra/either/either.dart';
import 'package:olly_olly_challenge/core/infra/exception/app_exception.dart';

class MockFetchAuthStatusUseCase extends Mock
    implements FetchAuthStatusUseCase {
  void stubCall(final Either<AppException, AuthStatus> result) {
    when(call).thenAnswer((final _) async => result);
  }
}
