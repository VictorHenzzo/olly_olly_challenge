import 'package:flutter/material.dart';
import 'package:weather_app/main/modules/splash/bloc/splash_bloc.dart';
import 'package:weather_app/main/shared/widgets/screen_loading.dart';

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
    return const Scaffold(body: ScreenLoading());
  }
}
