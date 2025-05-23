import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:weather_app/core/data/data_sources/auth_data_source/auth_data_source.dart';
import 'package:weather_app/core/data/data_sources/auth_data_source/auth_data_source_exception.dart';
import 'package:weather_app/core/domain/enums/auth/auth_status.dart';

class FirebaseDataSourceImpl implements AuthDataSource {
  FirebaseDataSourceImpl(this.firebaseAuth);

  final fa.FirebaseAuth firebaseAuth;

  @override
  Future<String?> getToken() async {
    try {
      final user = firebaseAuth.currentUser;
      return await user?.getIdToken();
    } on fa.FirebaseAuthException catch (e) {
      throw AuthDataSourceException(e.code);
    } catch (e) {
      throw AuthDataSourceException(
        'An unexpected error occurred while getting token: $e',
      );
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(
    final String email,
    final String password,
  ) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on fa.FirebaseAuthException catch (e) {
      throw AuthDataSourceException(e.code);
    } catch (e) {
      throw AuthDataSourceException(
        'An unexpected error occurred while signing in: $e',
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } on fa.FirebaseAuthException catch (e) {
      throw AuthDataSourceException(e.code);
    } catch (e) {
      throw AuthDataSourceException(
        'An unexpected error occurred while signing out: $e',
      );
    }
  }

  @override
  Future<void> signUpWithEmailAndPassword(
    final String email,
    final String password,
  ) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on fa.FirebaseAuthException catch (e) {
      throw AuthDataSourceException(e.code);
    } catch (e) {
      throw AuthDataSourceException(
        'An unexpected error occurred while signing up: $e',
      );
    }
  }

  @override
  Future<AuthStatus> fetchAuthState() async {
    try {
      final user = firebaseAuth.currentUser;
      return switch (user == null) {
        true => AuthStatus.unauthenticated,
        false => AuthStatus.authenticated,
      };
    } on fa.FirebaseAuthException catch (e) {
      throw AuthDataSourceException(e.code);
    } catch (e) {
      throw AuthDataSourceException(
        'An unexpected error occurred while fetching auth state: $e',
      );
    }
  }
}
