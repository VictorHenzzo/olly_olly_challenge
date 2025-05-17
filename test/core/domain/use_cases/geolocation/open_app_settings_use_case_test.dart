import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/domain/exceptions/geolocation/open_app_settings_exception.dart';
import 'package:weather_app/core/domain/use_cases/geolocation/open_app_settings_use_case.dart';

import '../../../../mocks/repositories/mock_geolocation_repository.dart';

void main() {
  late OpenAppSettingsUseCaseImpl sut;
  late MockGeolocationRepository repository;

  setUp(() {
    repository = MockGeolocationRepository();
    sut = OpenAppSettingsUseCaseImpl(repository, isWeb: false);
  });

  test('should return success when repository succeeds', () async {
    // Arrange
    repository.stubOpenAppSettings();

    // Act
    final result = await sut();

    // Assert
    expect(result.isRight, isTrue);
    verify(() => repository.openAppSettings()).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return error on web', () async {
    // Arrange
    sut = OpenAppSettingsUseCaseImpl(repository, isWeb: true);
    // Act
    final result = await sut();

    // Assert
    expect(result.isLeft, isTrue);
    expect(
      result.leftOrNull,
      isA<PlatformNotSupportedOpenAppSettingsException>(),
    );
    verifyZeroInteractions(repository);
  });

  test('should return failure when repository returns error', () async {
    // Arrange
    repository.stubOpenAppSettingsException('Error');

    // Act
    final result = await sut();

    // Assert
    expect(result.isLeft, isTrue);
    expect(
      result.leftOrNull,
      isA<UnknownOpenAppSettingsException>(),
    );
    verify(() => repository.openAppSettings()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
