import 'package:injectable/injectable.dart';
import 'package:weather_app/core/data/data_sources/geolocation_data_source/geolocation_data_source.dart';
import 'package:weather_app/core/data/data_sources/geolocation_data_source/geolocation_data_source_exception.dart';
import 'package:weather_app/core/data/models/position_model.dart';
import 'package:weather_app/core/domain/entities/position_entity.dart';
import 'package:weather_app/core/domain/enums/location_access_permission.dart';
import 'package:weather_app/core/domain/repositories/geolocation_repository.dart';
import 'package:weather_app/core/infra/either/either.dart';
import 'package:weather_app/core/infra/exception/app_exception.dart';

@Injectable(as: GeolocationRepository)
class GeolocationRepositoryImpl implements GeolocationRepository {
  GeolocationRepositoryImpl(this._dataSource);

  final GeolocationDataSource _dataSource;

  @override
  Future<Either<AppException, PositionEntity>> getCurrentPosition() async {
    try {
      final position = await _dataSource.getCurrentPosition();
      final model = PositionModel(
        latitude: position.latitude,
        longitude: position.longitude,
      );
      return Right(model.toEntity());
    } on GeolocationDataSourceException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, LocationAccessPermission>>
      checkPermission() async {
    try {
      final result = await _dataSource.checkPermission();
      return Right(result);
    } on GeolocationDataSourceException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, LocationAccessPermission>>
      requestPermission() async {
    try {
      final result = await _dataSource.requestPermission();
      return Right(result);
    } on GeolocationDataSourceException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<AppException, void>> openAppSettings() async {
    try {
      await _dataSource.openAppSettings();
      return const Right(null);
    } on GeolocationDataSourceException catch (e) {
      return Left(e);
    }
  }
}
