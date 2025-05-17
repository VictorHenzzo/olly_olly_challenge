import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/domain/exceptions/auth/sign_in_exceptions.dart';
import 'package:weather_app/core/domain/exceptions/auth/sign_up_exceptions.dart';
import 'package:weather_app/core/domain/use_cases/auth/sign_in_use_case.dart';
import 'package:weather_app/core/domain/use_cases/auth/sign_up_use_case.dart';
import 'package:weather_app/core/navigation/navigation/app_navigator.dart';
import 'package:weather_app/core/navigation/routes/app_directions.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this.signInUseCase,
    this.signUpUseCase,
    this.navigator,
  ) : super(const AuthInitial()) {
    on<SignInEvent>(_onSignInEvent);
    on<SignUpEvent>(_onSignUpEvent);
  }

  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final AppNavigator navigator;

  Future<void> _onSignInEvent(
    final SignInEvent event,
    final Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await signInUseCase.call(
      email: event.email,
      password: event.password,
    );
    result.fold(
      onLeft: (final exception) => emit(AuthSignInError(exception)),
      onRight: (final _) => navigator.pushNamedAndRemoveAll<void>(
        AppDirections.homeScreen,
      ),
    );
  }

  Future<void> _onSignUpEvent(
    final SignUpEvent event,
    final Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await signUpUseCase.call(
      email: event.email,
      password: event.password,
    );
    result.fold(
      onLeft: (final exception) => emit(AuthSignUpError(exception)),
      onRight: (final _) => navigator.pushNamedAndRemoveAll<void>(
        AppDirections.homeScreen,
      ),
    );
  }
}
