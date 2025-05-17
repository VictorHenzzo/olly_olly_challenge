import 'package:firebase_core/firebase_core.dart';
import 'package:weather_app/core/infra/env/environment.dart';

class MockEnvironment implements Environment {
  @override
  String get weatherApiBaseUrl => 'https://api.some-mock-api.com';

  @override
  String get weatherApiKey => '1234567890';

  @override
  String get weatherApiIconUrl => 'https://api.some-mock-api.com/img/wn';

  @override
  FirebaseOptions get android => throw UnimplementedError();

  @override
  FirebaseOptions get ios => throw UnimplementedError();

  @override
  FirebaseOptions get web => throw UnimplementedError();
}
