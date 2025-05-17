import 'package:weather_app/core/domain/enums/auth/auth_status.dart';

/// Abstraction for authentication data sources.
///
/// This interface provides methods for signing in, signing up, signing out,
/// fetching authentication state, and retrieving tokens.
///
/// All methods may throw a base authentication data source exception on failure.
abstract class AuthDataSource {
  /// Signs in a user with email and password.
  ///
  /// Throws an authentication data source exception if the operation fails.
  Future<void> signInWithEmailAndPassword(
    final String email,
    final String password,
  );

  /// Signs out the current user.
  ///
  /// Throws an authentication data source exception if the operation fails.
  Future<void> signOut();

  /// Signs up a new user with email and password.
  ///
  /// Throws an authentication data source exception if the operation fails.
  Future<void> signUpWithEmailAndPassword(
    final String email,
    final String password,
  );

  /// Retrieves the current user's authentication token, if available.
  ///
  /// Throws an authentication data source exception if the operation fails.
  Future<String?> getToken();

  /// Fetches the current authentication state.
  ///
  /// Throws an authentication data source exception if the operation fails.
  Future<AuthStatus> fetchAuthState();
}
