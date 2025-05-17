import 'package:flutter/material.dart';
import 'package:weather_app/core/infra/firebase/firebase_initializer.dart';
import 'package:weather_app/core/infra/service_locator/service_locator.dart';
import 'package:weather_app/core/navigation/routes/app_directions.dart';
import 'package:weather_app/main/modules/auth/navigation/auth_route.dart';
import 'package:weather_app/main/modules/home/navigation/home_route.dart';
import 'package:weather_app/main/modules/splash/navigation/splash_route.dart';
import 'package:weather_app/main/shared/theme/theme_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await const FirebaseInitializer().initialize();
  await ServiceLocator().initialize();
  final theme = await const ThemeGenerator().generateTheme();
  runApp(MyApp(theme: theme));
}

class MyApp extends StatelessWidget {
  const MyApp({
    required this.theme,
    super.key,
  });

  final ThemeData theme;

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: theme,
      initialRoute: AppDirections.splashScreen,
      routes: {
        AppDirections.splashScreen: const SplashRoute().build,
        AppDirections.authScreen: const AuthRoute().build,
        AppDirections.homeScreen: const HomeRoute().build,
      },
    );
  }
}
