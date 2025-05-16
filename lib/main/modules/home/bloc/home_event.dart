part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class FetchDataHomeEvent extends HomeEvent {
  const FetchDataHomeEvent();
}

final class SignOutHomeEvent extends HomeEvent {
  const SignOutHomeEvent();
}

final class OpenAppSettingsHomeEvent extends HomeEvent {
  const OpenAppSettingsHomeEvent();
}
