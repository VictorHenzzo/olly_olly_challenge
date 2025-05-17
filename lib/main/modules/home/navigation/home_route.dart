import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/infra/service_locator/service_locator.dart';
import 'package:weather_app/core/navigation/routes/app_directions.dart';
import 'package:weather_app/core/navigation/routes/app_route.dart';
import 'package:weather_app/main/modules/home/bloc/home_bloc.dart';
import 'package:weather_app/main/modules/home/presentation/home_screen.dart';

class HomeRoute extends AppRoute {
  const HomeRoute();

  @override
  Widget build(final BuildContext context) {
    final serviceLocator = ServiceLocator();
    final bloc = HomeBloc(
      fetchPositionUseCase: serviceLocator.get(),
      fetchWeatherUseCase: serviceLocator.get(),
      fetchForecastUseCase: serviceLocator.get(),
      openAppSettingsUseCase: serviceLocator.get(),
      signOutUseCase: serviceLocator.get(),
      navigator: serviceLocator.get(),
    );
    return BlocProvider(
      create: (final _) => bloc,
      child: HomeScreen(bloc: bloc),
    );
  }

  @override
  String get routePath => AppDirections.homeScreen;
}
