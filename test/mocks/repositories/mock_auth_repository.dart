import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/domain/exceptions/auth/sign_in_exceptions.dart';
import 'package:olly_olly_challenge/core/domain/exceptions/auth/sign_up_exceptions.dart';
import 'package:olly_olly_challenge/core/domain/repositories/auth_repository.dart';
import 'package:olly_olly_challenge/core/infra/either/either.dart';

class MockAuthRepository extends Mock implements AuthRepository {
  void stubSignUpWithEmailAndPassword(
    final Either<SignUpException, void> result,
  ) {
    when(
      () => signUpWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((final _) async => result);
  }

  void stubSignInWithEmailAndPassword(
    final Either<SignInException, void> result,
  ) {
    when(
      () => signInWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((final _) async => result);
  }
}
