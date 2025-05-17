import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/domain/exceptions/auth/sign_in_exceptions.dart';
import 'package:weather_app/core/domain/exceptions/auth/sign_up_exceptions.dart';
import 'package:weather_app/core/navigation/routes/app_directions.dart';
import 'package:weather_app/main/modules/auth/bloc/auth_bloc.dart';

import '../../../../mocks/infra/app_navigator_mock.dart';
import '../../../../mocks/use_cases/auth/mock_sign_in_use_case.dart';
import '../../../../mocks/use_cases/auth/mock_sign_up_use_case.dart';

void main() {
  late AuthBloc sut;
  late MockSignInUseCase signInUseCase;
  late MockSignUpUseCase signUpUseCase;
  late MockAppNavigator navigator;
  const email = 'test@example.com';
  const password = 'password123';

  setUp(() {
    signInUseCase = MockSignInUseCase();
    signUpUseCase = MockSignUpUseCase();
    navigator = MockAppNavigator();
    sut = AuthBloc(signInUseCase, signUpUseCase, navigator);
  });

  group('SignIn', () {
    blocTest<AuthBloc, AuthState>(
      'should emit states in order when sign in succeeds',
      setUp: () {
        signInUseCase.stubSignIn();
      },
      build: () => sut,
      act: (final bloc) => bloc.add(
        const SignInEvent(email: email, password: password),
      ),
      expect: () => const [AuthLoading()],
      verify: (final bloc) {
        verifyInOrder([
          () => signInUseCase.call(
                email: email,
                password: password,
              ),
          () => navigator.pushNamedAndRemoveAll<void>(
                AppDirections.homeScreen,
              ),
        ]);

        verifyNoMoreInteractions(signInUseCase);
        verifyNoMoreInteractions(navigator);
        verifyNoMoreInteractions(signUpUseCase);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit states in order when sign in fails',
      setUp: () {
        signInUseCase.stubSignInException(
          const InvalidCredentialSignInException(),
        );
      },
      build: () => sut,
      act: (final bloc) =>
          bloc.add(const SignInEvent(email: email, password: password)),
      expect: () => const [
        AuthLoading(),
        AuthSignInError(InvalidCredentialSignInException()),
      ],
      verify: (final bloc) {
        verify(
          () => signInUseCase.call(
            email: email,
            password: password,
          ),
        ).called(1);

        verifyNoMoreInteractions(signInUseCase);
        verifyZeroInteractions(navigator);
      },
    );
  });

  group('SignUp', () {
    blocTest<AuthBloc, AuthState>(
      'should emit states in order when sign up succeeds',
      setUp: () {
        signUpUseCase.stubSignUp();
      },
      build: () => sut,
      act: (final bloc) =>
          bloc.add(const SignUpEvent(email: email, password: password)),
      expect: () => const [AuthLoading()],
      verify: (final bloc) {
        verifyInOrder([
          () => signUpUseCase.call(
                email: email,
                password: password,
              ),
          () => navigator.pushNamedAndRemoveAll<void>(
                AppDirections.homeScreen,
              ),
        ]);

        verifyNoMoreInteractions(signUpUseCase);
        verifyNoMoreInteractions(navigator);
        verifyZeroInteractions(signInUseCase);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit states in order when sign up fails',
      setUp: () {
        signUpUseCase.stubSignUpException(
          const UnknownSignUpException(),
        );
      },
      build: () => sut,
      act: (final bloc) =>
          bloc.add(const SignUpEvent(email: email, password: password)),
      expect: () => [
        const AuthLoading(),
        const AuthSignUpError(UnknownSignUpException()),
      ],
      verify: (final bloc) {
        verify(
          () => signUpUseCase.call(
            email: email,
            password: password,
          ),
        ).called(1);

        verifyNoMoreInteractions(signUpUseCase);
        verifyZeroInteractions(signInUseCase);
        verifyZeroInteractions(navigator);
      },
    );
  });
}
