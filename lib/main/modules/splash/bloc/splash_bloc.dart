import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:olly_olly_challenge/core/domain/enums/auth/auth_status.dart';
import 'package:olly_olly_challenge/core/domain/use_cases/auth/fetch_auth_status_use_case.dart';
import 'package:olly_olly_challenge/core/navigation/navigation/app_navigator.dart';
import 'package:olly_olly_challenge/core/navigation/routes/app_directions.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(
    this.fetchAuthStatusUseCase,
    this.appNavigator,
  ) : super(const SplashState()) {
    on<InitializeSplashEvent>(_onInitializeSplashEvent);
  }

  final FetchAuthStatusUseCase fetchAuthStatusUseCase;
  final AppNavigator appNavigator;

  Future<void> _onInitializeSplashEvent(
    final InitializeSplashEvent event,
    final Emitter<SplashState> emit,
  ) async {
    final result = await fetchAuthStatusUseCase();
    return switch (result.rightOrNull) {
      AuthStatus.authenticated =>
        appNavigator.pushNamedAndRemoveAll(AppDirections.homeScreen),
      _ => appNavigator.pushNamedAndRemoveAll(AppDirections.authScreen),
    };
  }
}
