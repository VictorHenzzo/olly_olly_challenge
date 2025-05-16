import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:olly_olly_challenge/core/domain/entities/position_entity.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/current_weather_entity.dart';
import 'package:olly_olly_challenge/core/domain/entities/weather/forecast_report_entity.dart';
import 'package:olly_olly_challenge/core/domain/exceptions/geolocation/fetch_position_exception.dart';
import 'package:olly_olly_challenge/core/domain/use_cases/auth/sign_out_use_case.dart';
import 'package:olly_olly_challenge/core/domain/use_cases/geolocation/fetch_position_use_case.dart';
import 'package:olly_olly_challenge/core/domain/use_cases/geolocation/open_app_settings_use_case.dart';
import 'package:olly_olly_challenge/core/domain/use_cases/weather/fetch_current_weather_use_case.dart';
import 'package:olly_olly_challenge/core/domain/use_cases/weather/fetch_forecast_report_use_case.dart';
import 'package:olly_olly_challenge/core/navigation/navigation/app_navigator.dart';
import 'package:olly_olly_challenge/core/navigation/routes/app_directions.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.fetchPositionUseCase,
    required this.fetchWeatherUseCase,
    required this.fetchForecastUseCase,
    required this.openAppSettingsUseCase,
    required this.signOutUseCase,
    required this.navigator,
    @visibleForTesting this.isWeb = kIsWeb,
  }) : super(const HomeInitial()) {
    on<FetchDataHomeEvent>(_onFetchDataHomeEvent);
    on<SignOutHomeEvent>(_onSignOutHomeEvent);
    on<OpenAppSettingsHomeEvent>(_onOpenAppSettingsHomeEvent);
  }

  final FetchPositionUseCase fetchPositionUseCase;
  final FetchCurrentWeatherUseCase fetchWeatherUseCase;
  final FetchForecastReportUseCase fetchForecastUseCase;
  final OpenAppSettingsUseCase openAppSettingsUseCase;
  final SignOutUseCase signOutUseCase;
  final AppNavigator navigator;
  final bool isWeb;

  Future<void> _onFetchDataHomeEvent(
    final FetchDataHomeEvent event,
    final Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());

    final position = await fetchPositionUseCase.call();

    return position.foldAsync(
      onLeft: (final exception) => _onFetchPositionError(exception, emit),
      onRight: (final position) => _fetchWeatherData(position, emit),
    );
  }

  Future<void> _onFetchPositionError(
    final FetchPositionException exception,
    final Emitter<HomeState> emit,
  ) async {
    final canOpenAppSettings = !isWeb;
    final newState = switch (exception) {
      DeniedFetchPositionException() => HomeLocationPermissionDenied(
          canOpenAppSettings: canOpenAppSettings,
          isPermanentlyDenied: false,
        ),
      DeniedForeverFetchPositionException() => HomeLocationPermissionDenied(
          canOpenAppSettings: canOpenAppSettings,
          isPermanentlyDenied: true,
        ),
      UnknownFetchPositionException() => const HomeError(),
    };

    emit(newState);
  }

  Future<void> _fetchWeatherData(
    final PositionEntity position,
    final Emitter<HomeState> emit,
  ) async {
    final weatherData = await Future.wait([
      fetchWeatherUseCase.call(position).then(
            (final val) => val.rightOrNull,
          ),
      fetchForecastUseCase.call(position).then(
            (final val) => val.rightOrNull,
          ),
    ]);

    final currentWeather = weatherData[0] as CurrentWeatherEntity?;
    final forecastReport = weatherData[1] as ForecastReportEntity?;

    if (currentWeather == null || forecastReport == null) {
      return emit(const HomeError());
    }

    emit(
      HomeLoaded(
        position: position,
        currentWeather: currentWeather,
        forecastReport: forecastReport,
      ),
    );
  }

  Future<void> _onSignOutHomeEvent(
    final SignOutHomeEvent event,
    final Emitter<HomeState> emit,
  ) async {
    await signOutUseCase.call();
    await navigator.pushNamedAndRemoveAll<void>(
      AppDirections.authScreen,
    );
  }

  Future<void> _onOpenAppSettingsHomeEvent(
    final OpenAppSettingsHomeEvent event,
    final Emitter<HomeState> emit,
  ) async {
    final result = await openAppSettingsUseCase.call();
    if (result.isLeft) {
      return emit(const HomeError());
    }
  }
}
