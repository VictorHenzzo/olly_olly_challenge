part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

final class SignInEvent extends AuthEvent {
  const SignInEvent({
    required super.email,
    required super.password,
  });
}

final class SignUpEvent extends AuthEvent {
  const SignUpEvent({
    required super.email,
    required super.password,
  });
}
