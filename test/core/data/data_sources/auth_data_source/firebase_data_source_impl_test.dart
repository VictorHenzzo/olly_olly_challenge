import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/data/data_sources/auth_data_source/auth_data_source_exception.dart';
import 'package:olly_olly_challenge/core/data/data_sources/auth_data_source/firebase_data_source_impl.dart';
import 'package:olly_olly_challenge/core/domain/enums/auth/auth_status.dart';

void main() {
  late FirebaseDataSourceImpl sut;
  late _MockFirebaseAuth firebaseAuth;
  late _MockUser user;

  setUp(() {
    firebaseAuth = _MockFirebaseAuth();
    user = _MockUser();
    sut = FirebaseDataSourceImpl(firebaseAuth);
  });

  group('getToken', () {
    test('should return token when user is signed in', () async {
      // arrange
      firebaseAuth.stubCurrentUser(user);
      user.stubGetIdToken('test-token');

      // act
      final result = await sut.getToken();

      // assert
      expect(result, equals('test-token'));
      verifyInOrder([
        () => firebaseAuth.currentUser,
        () => user.getIdToken(),
      ]);
      verifyNoMoreInteractions(firebaseAuth);
      verifyNoMoreInteractions(user);
    });

    test('should return null when user is not signed in', () async {
      // arrange
      firebaseAuth.stubCurrentUser(null);

      // act
      final result = await sut.getToken();

      // assert
      expect(result, isNull);
    });

    test('should throw FirebaseAuthException when get current user fails',
        () async {
      // arrange
      firebaseAuth.stubCurrentUserException(
        fa.FirebaseAuthException(code: 'error'),
      );

      // act & assert
      expect(
        () => sut.getToken(),
        throwsA(
          isA<AuthDataSourceException>().having(
            (final e) => e.message,
            'message',
            'error',
          ),
        ),
      );
    });

    test('should throw FirebaseAuthException when getIdToken fails', () async {
      // arrange
      firebaseAuth.stubCurrentUser(user);
      user.stubGetIdTokenException(
        fa.FirebaseAuthException(code: 'error'),
      );

      // act & assert
      expect(
        () => sut.getToken(),
        throwsA(
          isA<AuthDataSourceException>().having(
            (final e) => e.message,
            'message',
            'error',
          ),
        ),
      );
    });
  });

  group('signInWithEmailAndPassword', () {
    test('should sign in successfully', () async {
      // arrange
      firebaseAuth.stubSignInWithEmailAndPassword();

      // act
      await sut.signInWithEmailAndPassword('test@test.com', 'password');

      // assert
      verify(
        () => firebaseAuth.signInWithEmailAndPassword(
          email: 'test@test.com',
          password: 'password',
        ),
      ).called(1);
      verifyNoMoreInteractions(firebaseAuth);
    });

    test('should throw FirebaseAuthException when sign in fails', () async {
      // arrange
      firebaseAuth.stubSignInWithEmailAndPasswordException(
        fa.FirebaseAuthException(code: 'error'),
      );

      // act & assert
      expect(
        () => sut.signInWithEmailAndPassword('test@test.com', 'password'),
        throwsA(
          isA<AuthDataSourceException>().having(
            (final e) => e.message,
            'message',
            'error',
          ),
        ),
      );
    });
  });

  group('signOut', () {
    test('should sign out successfully', () async {
      // arrange
      firebaseAuth.stubSignOut();

      // act
      await sut.signOut();

      // assert
      verify(() => firebaseAuth.signOut()).called(1);
      verifyNoMoreInteractions(firebaseAuth);
    });

    test('should throw FirebaseAuthException when sign out fails', () async {
      // arrange
      firebaseAuth.stubSignOutException(
        fa.FirebaseAuthException(code: 'error'),
      );

      // act & assert
      expect(
        () => sut.signOut(),
        throwsA(
          isA<AuthDataSourceException>().having(
            (final e) => e.message,
            'message',
            'error',
          ),
        ),
      );
    });
  });

  group('signUpWithEmailAndPassword', () {
    test('should sign up successfully', () async {
      // arrange
      firebaseAuth.stubCreateUserWithEmailAndPassword();

      // act
      await sut.signUpWithEmailAndPassword('test@test.com', 'password');

      // assert
      verify(
        () => firebaseAuth.createUserWithEmailAndPassword(
          email: 'test@test.com',
          password: 'password',
        ),
      ).called(1);
      verifyNoMoreInteractions(firebaseAuth);
    });

    test('should throw FirebaseAuthException when sign up fails', () async {
      // arrange
      firebaseAuth.stubCreateUserWithEmailAndPasswordException(
        fa.FirebaseAuthException(code: 'error'),
      );

      // act & assert
      expect(
        () => sut.signUpWithEmailAndPassword('test@test.com', 'password'),
        throwsA(
          isA<AuthDataSourceException>().having(
            (final e) => e.message,
            'message',
            'error',
          ),
        ),
      );
    });
  });

  group('fetchAuthState', () {
    test('should return unauthenticated when user is null', () async {
      // arrange
      firebaseAuth.stubCurrentUser(null);

      // act
      final result = await sut.fetchAuthState();

      // assert
      expect(result, equals(AuthStatus.unauthenticated));
    });

    test('should return authenticated when user is not null', () async {
      // arrange
      firebaseAuth.stubCurrentUser(user);

      // act
      final result = await sut.fetchAuthState();

      // assert
      expect(result, equals(AuthStatus.authenticated));
    });

    test('should return AppException when error occurs', () async {
      // arrange
      firebaseAuth.stubCurrentUserException(Exception('Test error'));

      // act & assert
      expect(
        () => sut.fetchAuthState(),
        throwsA(isA<AuthDataSourceException>()),
      );
    });
  });
}

class _MockFirebaseAuth extends Mock implements fa.FirebaseAuth {
  void stubCurrentUser(final fa.User? user) {
    when(() => currentUser).thenReturn(user);
  }

  void stubCurrentUserException(final Object throwable) {
    when(() => currentUser).thenThrow(throwable);
  }

  void stubSignInWithEmailAndPassword() {
    when(
      () => signInWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((final _) async => _MockUserCredential());
  }

  void stubSignInWithEmailAndPasswordException(final Object throwable) {
    when(
      () => signInWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenThrow(throwable);
  }

  void stubSignOut() {
    when(signOut).thenAnswer((final _) async {});
  }

  void stubSignOutException(final Object throwable) {
    when(signOut).thenThrow(throwable);
  }

  void stubCreateUserWithEmailAndPassword() {
    when(
      () => createUserWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((final _) async => _MockUserCredential());
  }

  void stubCreateUserWithEmailAndPasswordException(final Object throwable) {
    when(
      () => createUserWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenThrow(throwable);
  }
}

class _MockUser extends Mock implements fa.User {
  void stubGetIdToken(final String token) {
    when(getIdToken).thenAnswer((final _) async => token);
  }

  void stubGetIdTokenException(final Object throwable) {
    when(getIdToken).thenThrow(throwable);
  }
}

class _MockUserCredential extends Mock implements fa.UserCredential {}
