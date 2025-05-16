import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/data/data_sources/auth_data_source/auth_data_source.dart';
import 'package:olly_olly_challenge/core/data/data_sources/auth_data_source/auth_data_source_exception.dart';
import 'package:olly_olly_challenge/core/domain/enums/auth/auth_status.dart';

class MockAuthDataSource extends Mock implements AuthDataSource {
  void stubSignUpWithEmailAndPassword() {
    when(
      () => signUpWithEmailAndPassword(any(), any()),
    ).thenAnswer((final _) async {});
  }

  void stubSignUpWithEmailAndPasswordException(final String code) {
    when(
      () => signUpWithEmailAndPassword(any(), any()),
    ).thenThrow(AuthDataSourceException(code));
  }

  void stubSignInWithEmailAndPassword() {
    when(
      () => signInWithEmailAndPassword(any(), any()),
    ).thenAnswer((final _) async {});
  }

  void stubSignInWithEmailAndPasswordException(final String code) {
    when(
      () => signInWithEmailAndPassword(any(), any()),
    ).thenThrow(AuthDataSourceException(code));
  }

  void stubSignOut() {
    when(signOut).thenAnswer((final _) async {});
  }

  void stubSignOutException(final String code) {
    when(signOut).thenThrow(AuthDataSourceException(code));
  }

  void stubFetchAuthState(final Stream<AuthStatus> stream) {
    when(fetchAuthState).thenAnswer((final _) => stream);
  }
}
