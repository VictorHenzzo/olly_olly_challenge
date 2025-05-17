import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/infra/logger/logger.dart';

class MockLogger extends Mock implements Logger {
  void stubInfo() {
    when(
      () => info(
        any(),
        error: any(named: 'error'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenAnswer((final _) {});
  }

  void stubWarning() {
    when(
      () => warning(
        any(),
        error: any(named: 'error'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenAnswer((final _) {});
  }

  void stubError() {
    when(
      () => error(
        any(),
        error: any(named: 'error'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenAnswer((final _) {});
  }
}
