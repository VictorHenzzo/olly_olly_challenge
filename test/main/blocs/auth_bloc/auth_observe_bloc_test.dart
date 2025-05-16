import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/domain/enums/auth/auth_status.dart';
import 'package:olly_olly_challenge/core/navigation/routes/app_directions.dart';
import 'package:olly_olly_challenge/main/blocs/auth_bloc/auth_observe_bloc.dart';

import '../../../mocks/infra/app_navigator_mock.dart';
import '../../../mocks/use_cases/mock_observe_auth_status_use_case.dart';

void main() {
  late AuthObserverBloc sut;
  late MockFetchAuthStatusUseCase fetchAuthStatusUseCase;
  late MockAppNavigator navigator;
  late StreamController<AuthStatus> streamController;

  setUp(() {
    fetchAuthStatusUseCase = MockFetchAuthStatusUseCase();
    navigator = MockAppNavigator();
    sut = AuthObserverBloc(fetchAuthStatusUseCase, navigator);
    streamController = StreamController<AuthStatus>();
    fetchAuthStatusUseCase.stubObserve(streamController.stream);
  });

  test('should initialize with null subscription', () {
    expect(sut.subscription, isNull);
  });

  group('Initialize', () {
    blocTest<AuthObserverBloc, AuthObserverState>(
      'should emit states and navigate based on auth status stream',
      build: () => sut,
      act: (final bloc) {
        bloc.add(const InitializeAuthObserverEvent());

        streamController
          ..add(AuthStatus.authenticated)
          ..add(AuthStatus.unauthenticated)
          ..add(AuthStatus.authenticated);
      },
      expect: () => const <AuthObserverState>[],
      verify: (final _) {
        verifyInOrder(
          [
            () => navigator.pushNamedAndRemoveAll<void>(
                  AppDirections.homeScreen,
                ),
            () => navigator.pushNamedAndRemoveAll<void>(
                  AppDirections.authScreen,
                ),
            () => navigator.pushNamedAndRemoveAll<void>(
                  AppDirections.homeScreen,
                ),
          ],
        );
        verifyNoMoreInteractions(navigator);
      },
    );
  });

  group('Dispose', () {
    test('should cancel subscription when disposed', () async {
      // act
      sut.add(const InitializeAuthObserverEvent());
      // wait for any pending async initializations to finish
      await Future<void>.delayed(Duration.zero);
      await sut.close();

      // assert
      expect(streamController.hasListener, false);
    });
  });
}
