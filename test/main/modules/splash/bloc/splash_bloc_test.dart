import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/domain/enums/auth/auth_status.dart';
import 'package:olly_olly_challenge/core/infra/either/either.dart';
import 'package:olly_olly_challenge/core/infra/exception/app_exception.dart';
import 'package:olly_olly_challenge/core/navigation/routes/app_directions.dart';
import 'package:olly_olly_challenge/main/modules/splash/bloc/splash_bloc.dart';

import '../../../../mocks/infra/app_navigator_mock.dart';
import '../../../../mocks/use_cases/auth/mock_observe_auth_status_use_case.dart';

void main() {
  late SplashBloc sut;
  late MockFetchAuthStatusUseCase fetchAuthStatusUseCase;
  late MockAppNavigator navigator;

  setUp(() {
    fetchAuthStatusUseCase = MockFetchAuthStatusUseCase();
    navigator = MockAppNavigator();
    sut = SplashBloc(fetchAuthStatusUseCase, navigator);
  });

  group('InitializeSplashEvent', () {
    blocTest<SplashBloc, SplashState>(
      'should navigate to home screen when user is authenticated',
      setUp: () {
        fetchAuthStatusUseCase.stubCall(
          const Right(AuthStatus.authenticated),
        );
      },
      build: () => sut,
      act: (final bloc) {
        bloc.add(const InitializeSplashEvent());
      },
      expect: () => const <SplashState>[],
      verify: (final _) {
        verifyInOrder(
          [
            () => fetchAuthStatusUseCase.call(),
            () => navigator.pushNamedAndRemoveAll<void>(
                  AppDirections.homeScreen,
                ),
          ],
        );
        verifyNoMoreInteractions(navigator);
        verifyNoMoreInteractions(fetchAuthStatusUseCase);
      },
    );

    blocTest<SplashBloc, SplashState>(
      'should navigate to auth screen when user is unauthenticated',
      setUp: () {
        fetchAuthStatusUseCase.stubCall(
          const Right(AuthStatus.unauthenticated),
        );
      },
      build: () => sut,
      act: (final bloc) {
        bloc.add(const InitializeSplashEvent());
      },
      expect: () => const <SplashState>[],
      verify: (final _) {
        verifyInOrder(
          [
            () => fetchAuthStatusUseCase.call(),
            () => navigator.pushNamedAndRemoveAll<void>(
                  AppDirections.authScreen,
                ),
          ],
        );
        verifyNoMoreInteractions(navigator);
        verifyNoMoreInteractions(fetchAuthStatusUseCase);
      },
    );

    blocTest<SplashBloc, SplashState>(
      'should navigate to auth screen when error occurs',
      setUp: () {
        fetchAuthStatusUseCase.stubCall(
          const Left(AppException('error')),
        );
      },
      build: () => sut,
      act: (final bloc) {
        bloc.add(const InitializeSplashEvent());
      },
      expect: () => const <SplashState>[],
      verify: (final _) {
        verifyInOrder(
          [
            () => fetchAuthStatusUseCase.call(),
            () => navigator.pushNamedAndRemoveAll<void>(
                  AppDirections.authScreen,
                ),
          ],
        );
        verifyNoMoreInteractions(navigator);
        verifyNoMoreInteractions(fetchAuthStatusUseCase);
      },
    );
  });
}
