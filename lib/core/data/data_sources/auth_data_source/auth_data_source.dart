import 'package:olly_olly_challenge/core/domain/enums/auth/auth_status.dart';

abstract class AuthDataSource {
  Future<void> signInWithEmailAndPassword(
    final String email,
    final String password,
  );
  Future<void> signOut();
  Future<void> signUpWithEmailAndPassword(
    final String email,
    final String password,
  );
  Future<String?> getToken();
  Future<AuthStatus> fetchAuthState();
}
