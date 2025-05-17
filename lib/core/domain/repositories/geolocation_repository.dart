import 'package:weather_app/core/domain/entities/position_entity.dart';
import 'package:weather_app/core/domain/enums/location_access_permission.dart';
import 'package:weather_app/core/infra/either/either.dart';
import 'package:weather_app/core/infra/exception/app_exception.dart';

abstract class GeolocationRepository {
  Future<Either<AppException, PositionEntity>> getCurrentPosition();
  Future<Either<AppException, LocationAccessPermission>> checkPermission();
  Future<Either<AppException, LocationAccessPermission>> requestPermission();
  Future<Either<AppException, void>> openAppSettings();
}
