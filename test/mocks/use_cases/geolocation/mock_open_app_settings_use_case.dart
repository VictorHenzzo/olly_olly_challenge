import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/domain/exceptions/geolocation/open_app_settings_exception.dart';
import 'package:weather_app/core/domain/use_cases/geolocation/open_app_settings_use_case.dart';
import 'package:weather_app/core/infra/either/either.dart';

class MockOpenAppSettingsUseCase extends Mock
    implements OpenAppSettingsUseCase {
  void stubOpenAppSettings() {
    when(call).thenAnswer(
      (final _) async => const Right(null),
    );
  }

  void stubOpenAppSettingsException(final OpenAppSettingsException exception) {
    when(call).thenAnswer(
      (final _) async => Left(exception),
    );
  }
}
