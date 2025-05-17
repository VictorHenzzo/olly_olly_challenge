import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/infra/service_locator/service_locator.dart';
import 'package:weather_app/core/navigation/routes/app_directions.dart';
import 'package:weather_app/core/navigation/routes/app_route.dart';
import 'package:weather_app/main/modules/auth/bloc/auth_bloc.dart';
import 'package:weather_app/main/modules/auth/presentation/auth_screen.dart';

class AuthRoute extends AppRoute {
  const AuthRoute();

  @override
  Widget build(final BuildContext context) {
    final serviceLocator = ServiceLocator();
    final bloc = AuthBloc(
      serviceLocator.get(),
      serviceLocator.get(),
      serviceLocator.get(),
    );
    return BlocProvider(
      create: (final _) => bloc,
      child: AuthScreen(bloc: bloc),
    );
  }

  @override
  String get routePath => AppDirections.authScreen;
}
