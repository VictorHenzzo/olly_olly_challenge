import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/infra/firebase/firebase_initializer.dart';
import 'package:weather_app/core/infra/service_locator/service_locator.dart';
import 'package:weather_app/core/navigation/navigator/app_navigator.dart';
import 'package:weather_app/core/navigation/routes/app_directions.dart';
import 'package:weather_app/main/modules/auth/navigation/auth_route.dart';
import 'package:weather_app/main/modules/home/navigation/home_route.dart';
import 'package:weather_app/main/modules/splash/navigation/splash_route.dart';
import 'package:weather_app/main/shared/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await const FirebaseInitializer().initialize();
  await ServiceLocator().initialize();
  Intl.defaultLocale = 'en_US';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    final textTheme = createTextTheme(context, 'Open Sans', 'Roboto Slab');
    final theme = AppTheme(textTheme).light();

    return MaterialApp(
      title: 'Weather App',
      navigatorKey: const AppNavigator().navigatorKey,
      debugShowCheckedModeBanner: false,
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
