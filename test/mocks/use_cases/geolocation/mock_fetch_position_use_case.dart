import 'package:mocktail/mocktail.dart';
import 'package:olly_olly_challenge/core/domain/entities/position_entity.dart';
import 'package:olly_olly_challenge/core/domain/exceptions/geolocation/fetch_position_exception.dart';
import 'package:olly_olly_challenge/core/domain/use_cases/geolocation/fetch_position_use_case.dart';
import 'package:olly_olly_challenge/core/infra/either/either.dart';

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
