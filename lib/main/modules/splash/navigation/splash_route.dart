import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/infra/service_locator/service_locator.dart';
import 'package:weather_app/core/navigation/routes/app_directions.dart';
import 'package:weather_app/core/navigation/routes/app_route.dart';
import 'package:weather_app/main/modules/splash/bloc/splash_bloc.dart';
import 'package:weather_app/main/modules/splash/presentation/splash_screen.dart';

class SplashRoute extends AppRoute {
  const SplashRoute();

  @override
  Widget build(final BuildContext context) {
    final serviceLocator = ServiceLocator();
    final bloc = SplashBloc(
      serviceLocator.get(),
      serviceLocator.get(),
    );
    return BlocProvider(
      create: (final _) => bloc,
      child: SplashScreen(bloc: bloc),
    );
  }

  @override
  String get routePath => AppDirections.splashScreen;
}
