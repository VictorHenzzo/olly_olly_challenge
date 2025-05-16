import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/domain/enums/auth/auth_status.dart';
import 'package:olly_olly_challenge/core/domain/use_cases/auth/fetch_auth_status_use_case.dart';

class MockFetchAuthStatusUseCase extends Mock
    implements FetchAuthStatusUseCase {
  void stubObserve(final Stream<AuthStatus> stream) {
    when(call).thenAnswer((final _) => stream);
  }
}
