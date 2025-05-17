import 'package:flutter/material.dart';
import 'package:weather_app/core/infra/firebase/firebase_initializer.dart';
import 'package:weather_app/core/infra/service_locator/service_locator.dart';
import 'package:weather_app/core/navigation/routes/app_directions.dart';
import 'package:weather_app/main/modules/auth/navigation/auth_route.dart';
import 'package:weather_app/main/modules/home/navigation/home_route.dart';
import 'package:weather_app/main/modules/splash/navigation/splash_route.dart';

Future<void> main() async {
  await const FirebaseInitializer().initialize();
  await ServiceLocator().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppDirections.splashScreen,
      routes: {
        AppDirections.splashScreen: const SplashRoute().build,
        AppDirections.authScreen: const AuthRoute().build,
        AppDirections.homeScreen: const HomeRoute().build,
      },
    );
  }
}
