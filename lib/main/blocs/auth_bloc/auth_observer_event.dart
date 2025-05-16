part of 'auth_observe_bloc.dart';

sealed class AuthObserverEvent extends Equatable {
  const AuthObserverEvent();

  @override
  List<Object> get props => [];
}

final class InitializeAuthObserverEvent extends AuthObserverEvent {
  const InitializeAuthObserverEvent();
}
