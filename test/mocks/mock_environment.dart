import 'package:weather_app/core/infra/env/environment.dart';

class MockEnvironment implements Environment {
  @override
  String get weatherApiBaseUrl => 'https://api.some-mock-api.com';

  @override
  String get weatherApiKey => '1234567890';
}
