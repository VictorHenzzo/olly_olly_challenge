import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:olly_olly_challenge/core/domain/enums/auth/auth_status.dart';
import 'package:olly_olly_challenge/core/domain/use_cases/auth/fetch_auth_status_use_case.dart';
import 'package:olly_olly_challenge/core/navigation/navigation/app_navigator.dart';
import 'package:olly_olly_challenge/core/navigation/routes/app_directions.dart';

part 'auth_observer_event.dart';
part 'auth_observer_state.dart';

class AuthObserverBloc extends Bloc<AuthObserverEvent, AuthObserverState> {
  AuthObserverBloc(
    this.fetchAuthStatusUseCase,
    this.appNavigator,
  ) : super(const AuthObserverState()) {
    on<InitializeAuthObserverEvent>(_onInitializeAuthEvent);
  }

  final FetchAuthStatusUseCase fetchAuthStatusUseCase;
  final AppNavigator appNavigator;

  StreamSubscription<void>? subscription;

  Future<void> _onInitializeAuthEvent(
    final InitializeAuthObserverEvent event,
    final Emitter<AuthObserverState> emit,
  ) async {
    subscription = fetchAuthStatusUseCase().listen(
      (final authStatus) async {
        await _onAuthStatusChanged(authStatus);
      },
    );
  }

  Future<void> _onAuthStatusChanged(
    final AuthStatus authStatus,
  ) async {
    return switch (authStatus) {
      AuthStatus.authenticated =>
        appNavigator.pushNamedAndRemoveAll(AppDirections.homeScreen),
      _ => appNavigator.pushNamedAndRemoveAll(AppDirections.authScreen),
    };
  }

  @override
  Future<void> close() async {
    await subscription?.cancel();
    subscription = null;
    return super.close();
  }
}
