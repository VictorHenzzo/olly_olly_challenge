part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthSignInError extends AuthState {
  const AuthSignInError(this.exception);

  final SignInException exception;

  @override
  List<Object> get props => [exception];
}

final class AuthSignUpError extends AuthState {
  const AuthSignUpError(this.exception);

  final SignUpException exception;

  @override
  List<Object> get props => [exception];
}
