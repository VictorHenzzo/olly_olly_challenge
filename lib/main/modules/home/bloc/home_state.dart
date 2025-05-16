part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeLoaded extends HomeState {
  const HomeLoaded({
    required this.position,
    required this.currentWeather,
    required this.forecastReport,
  });

  final PositionEntity position;
  final CurrentWeatherEntity currentWeather;
  final ForecastReportEntity forecastReport;

  @override
  List<Object> get props => [position, currentWeather, forecastReport];
}

final class HomeError extends HomeState {
  const HomeError();
}

final class HomeLocationPermissionDenied extends HomeState {
  const HomeLocationPermissionDenied({
    required this.canOpenAppSettings,
    required this.isPermanentlyDenied,
  });

  final bool canOpenAppSettings;
  final bool isPermanentlyDenied;

  @override
  List<Object> get props => [canOpenAppSettings, isPermanentlyDenied];
}
