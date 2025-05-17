import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/domain/entities/position_entity.dart';
import 'package:weather_app/core/domain/exceptions/geolocation/fetch_position_exception.dart';
import 'package:weather_app/core/domain/use_cases/geolocation/fetch_position_use_case.dart';
import 'package:weather_app/core/infra/either/either.dart';

class MockFetchPositionUseCase extends Mock implements FetchPositionUseCase {
  void stubFetchPosition(final PositionEntity position) {
    when(call).thenAnswer(
      (final _) async => Right(position),
    );
  }

  void stubFetchPositionException(final FetchPositionException exception) {
    when(call).thenAnswer(
      (final _) async => Left(exception),
    );
  }
}
