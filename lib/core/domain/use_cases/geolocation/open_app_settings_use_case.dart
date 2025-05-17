import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/domain/exceptions/geolocation/open_app_settings_exception.dart';
import 'package:weather_app/core/domain/repositories/geolocation_repository.dart';
import 'package:weather_app/core/infra/either/either.dart';

abstract class OpenAppSettingsUseCase {
  Future<Either<OpenAppSettingsException, void>> call();
}

@Injectable(as: OpenAppSettingsUseCase)
class OpenAppSettingsUseCaseImpl implements OpenAppSettingsUseCase {
  OpenAppSettingsUseCaseImpl(
    this._repository, {
    this.isWeb = kIsWeb,
  });

  final GeolocationRepository _repository;
  final bool isWeb;

  @override
  Future<Either<OpenAppSettingsException, void>> call() async {
    if (isWeb) {
      return const Left(PlatformNotSupportedOpenAppSettingsException());
    }

    final result = await _repository.openAppSettings();
    return result.map(
      onLeft: (final _) => const Left(UnknownOpenAppSettingsException()),
      onRight: (final _) => const Right(null),
    );
  }
}
