import 'package:injectable/injectable.dart';
import 'package:weather_app/core/domain/entities/position_entity.dart';
import 'package:weather_app/core/domain/enums/location_access_permission.dart';
import 'package:weather_app/core/domain/exceptions/geolocation/fetch_position_exception.dart';
import 'package:weather_app/core/domain/repositories/geolocation_repository.dart';
import 'package:weather_app/core/infra/either/either.dart';

abstract class FetchPositionUseCase {
  Future<Either<FetchPositionException, PositionEntity>> call();
}

@Injectable(as: FetchPositionUseCase)
class FetchPositionUseCaseImpl implements FetchPositionUseCase {
  FetchPositionUseCaseImpl(this._repository);

  final GeolocationRepository _repository;

  @override
  Future<Either<FetchPositionException, PositionEntity>> call() async {
    final permission = await _getValidPermission();
    if (permission == null) {
      return const Left(UnknownFetchPositionException());
    }
    if (permission == LocationAccessPermission.deniedForever) {
      return const Left(DeniedForeverFetchPositionException());
    }

    return switch (permission) {
      LocationAccessPermission.permitted => _fetchPosition(),
      LocationAccessPermission.denied =>
        const Left(DeniedFetchPositionException()),
      LocationAccessPermission.deniedForever =>
        const Left(DeniedForeverFetchPositionException()),
      LocationAccessPermission.unknown =>
        const Left(UnknownFetchPositionException()),
    };
  }

  Future<LocationAccessPermission?> _getValidPermission() async {
    final checkResult = await _repository.checkPermission();
    if (checkResult.isLeft) {
      return null;
    }

    if ({
      LocationAccessPermission.deniedForever,
      LocationAccessPermission.permitted,
    }.contains(checkResult.rightOrNull)) {
      return checkResult.rightOrNull;
    }

    final requested = await _repository.requestPermission();
    return requested.rightOrNull;
  }

  Future<Either<FetchPositionException, PositionEntity>>
      _fetchPosition() async {
    final result = await _repository.getCurrentPosition();
    return result.map(
      onLeft: (final _) => const Left(UnknownFetchPositionException()),
      onRight: Right.new,
    );
  }
}
