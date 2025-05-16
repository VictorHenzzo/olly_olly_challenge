import 'package:injectable/injectable.dart';

@injectable
class Environment {
  const Environment();

  String get weatherApiKey => const String.fromEnvironment(
        'WEATHER_API_KEY',
      );
  String get weatherApiBaseUrl => const String.fromEnvironment(
        'WEATHER_API_BASE_URL',
      );
}
