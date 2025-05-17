import 'package:flutter/material.dart';
import 'package:weather_app/main/modules/splash/bloc/splash_bloc.dart';
import 'package:weather_app/main/shared/ui_context.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({required this.bloc, super.key});

  final SplashBloc bloc;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    widget.bloc.add(const InitializeSplashEvent());
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    final uiContext = UiContext.of(context);
    final dimension = uiContext.shp(10);

    return Scaffold(
      body: Center(
        child: SizedBox.square(
          dimension: dimension,
          child: CircularProgressIndicator(
            strokeCap: StrokeCap.round,
            strokeWidth: 10,
            backgroundColor: uiContext.colorScheme.primary,
            color: uiContext.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
