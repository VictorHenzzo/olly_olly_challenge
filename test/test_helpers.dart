import 'package:mocktail/mocktail.dart';

abstract class TestHelpers {
  static void registerFallbackValues() {
    registerFallbackValue(Uri.parse('https://api.example.com'));
  }
}
