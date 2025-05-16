import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/data/repositories/auth_repository_impl.dart';
import 'package:olly_olly_challenge/core/domain/enums/auth/auth_status.dart';
import 'package:olly_olly_challenge/core/domain/exceptions/auth/sign_in_exceptions.dart';
import 'package:olly_olly_challenge/core/domain/exceptions/auth/sign_up_exceptions.dart';
import 'package:olly_olly_challenge/core/infra/exception/app_exception.dart';

import '../../../mocks/data_sources/mock_auth_data_source.dart';

void main() {
  late AuthRepositoryImpl sut;
  late MockAuthDataSource dataSource;

  setUp(() {
    dataSource = MockAuthDataSource();
    sut = AuthRepositoryImpl(dataSource);
  });

  group('signUpWithEmailAndPassword', () {
    test('should not call data source with the correct parameters', () async {
      // arrange
      dataSource.stubSignUpWithEmailAndPassword();

      // act
      await sut.signUpWithEmailAndPassword(
        email: 'test@test.com',
        password: 'password',
      );

      // assert
      verify(
        () => dataSource.signUpWithEmailAndPassword(
          'test@test.com',
          'password',
        ),
      ).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('should return success when sign up succeeds', () async {
      // arrange
      dataSource.stubSignUpWithEmailAndPassword();

      // act
      final result = await sut.signUpWithEmailAndPassword(
        email: 'test@test.com',
        password: 'password',
      );

      // assert
      expect(result.isRight, isTrue);
    });

    test('should handle email already in use exception', () async {
      // arrange
      dataSource
          .stubSignUpWithEmailAndPasswordException('email-already-in-use');

      // act
      final result = await sut.signUpWithEmailAndPassword(
        email: 'test@test.com',
        password: 'password',
      );

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<EmailAlreadyInUseSignUpException>());
    });

    test('should handle weak password exception', () async {
      // arrange
      dataSource.stubSignUpWithEmailAndPasswordException('weak-password');

      // act
      final result = await sut.signUpWithEmailAndPassword(
        email: 'test@test.com',
        password: 'password',
      );

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<WeakPasswordSignUpException>());
    });

    test('should handle invalid email exception', () async {
      // arrange
      dataSource.stubSignUpWithEmailAndPasswordException('invalid-email');

      // act
      final result = await sut.signUpWithEmailAndPassword(
        email: 'test@test.com',
        password: 'password',
      );

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<InvalidEmailSignUpException>());
    });

    test('should handle unknown exception', () async {
      // arrange
      dataSource.stubSignUpWithEmailAndPasswordException('unknown-error');

      // act
      final result = await sut.signUpWithEmailAndPassword(
        email: 'test@test.com',
        password: 'password',
      );

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<UnknownSignUpException>());
    });
  });

  group('signInWithEmailAndPassword', () {
    test('should call data source with the correct parameters', () async {
      // arrange
      dataSource.stubSignInWithEmailAndPassword();

      // act
      await sut.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: 'password',
      );

      // assert
      verify(
        () => dataSource.signInWithEmailAndPassword(
          'test@test.com',
          'password',
        ),
      ).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('should return success when sign in succeeds', () async {
      // arrange
      dataSource.stubSignInWithEmailAndPassword();

      // act
      final result = await sut.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: 'password',
      );

      // assert
      expect(result.isRight, isTrue);
    });

    test('should handle user not found exception', () async {
      // arrange
      dataSource.stubSignInWithEmailAndPasswordException('user-not-found');

      // act
      final result = await sut.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: 'password',
      );

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<UserNotFoundSignInException>());
    });

    test('should handle wrong password exception', () async {
      // arrange
      dataSource.stubSignInWithEmailAndPasswordException('wrong-password');

      // act
      final result = await sut.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: 'password',
      );

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<WrongPasswordSignInException>());
    });

    test('should handle invalid email exception', () async {
      // arrange
      dataSource.stubSignInWithEmailAndPasswordException('invalid-email');

      // act
      final result = await sut.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: 'password',
      );

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<InvalidEmailSignInException>());
    });

    test('should handle invalid credential exception', () async {
      // arrange
      dataSource.stubSignInWithEmailAndPasswordException('invalid-credential');

      // act
      final result = await sut.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: 'password',
      );

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<InvalidCredentialSignInException>());
    });

    test('should handle unknown exception', () async {
      // arrange
      dataSource.stubSignInWithEmailAndPasswordException('unknown-error');

      // act
      final result = await sut.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: 'password',
      );

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<UnknownSignInException>());
    });
  });

  group('signOut', () {
    test('should return success when sign out succeeds', () async {
      // arrange
      dataSource.stubSignOut();

      // act
      final result = await sut.signOut();

      // assert
      expect(result.isRight, isTrue);
    });

    test('should call data source with the correct parameters', () async {
      // arrange
      dataSource.stubSignOut();

      // act
      await sut.signOut();

      // assert
      verify(() => dataSource.signOut()).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('should handle exceptions', () async {
      // arrange
      dataSource.stubSignOutException('error');

      // act
      final result = await sut.signOut();

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<AppException>());
    });
  });

  group('fetchAuthState', () {
    test('should return authenticated when user is signed in', () async {
      // arrange
      dataSource.stubFetchAuthState(AuthStatus.authenticated);

      // act
      final result = await sut.fetchAuthState();

      // assert
      expect(result.isRight, isTrue);
      expect(result.rightOrNull, equals(AuthStatus.authenticated));
      verify(() => dataSource.fetchAuthState()).called(1);
    });

    test('should return unauthenticated when user is not signed in', () async {
      // arrange
      dataSource.stubFetchAuthState(AuthStatus.unauthenticated);

      // act
      final result = await sut.fetchAuthState();

      // assert
      expect(result.isRight, isTrue);
      expect(result.rightOrNull, equals(AuthStatus.unauthenticated));
      verify(() => dataSource.fetchAuthState()).called(1);
    });

    test('should return AppException when error occurs', () async {
      // arrange
      dataSource.stubFetchAuthStateException('error');

      // act
      final result = await sut.fetchAuthState();

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<AppException>());
      verify(() => dataSource.fetchAuthState()).called(1);
    });
  });
}
