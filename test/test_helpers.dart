import 'package:mocktail/mocktail.dart';

import 'fixtures/position_fixture.dart';

abstract class TestHelpers {
  static void registerFallbackValues() {
    // Entities
    registerFallbackValue(PositionFixture.entity());

    // Other
    registerFallbackValue(Uri.parse('https://api.example.com'));
  }
}
