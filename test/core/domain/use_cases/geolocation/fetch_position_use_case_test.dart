import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/domain/enums/location_access_permission.dart';
import 'package:weather_app/core/domain/exceptions/geolocation/fetch_position_exception.dart';
import 'package:weather_app/core/domain/use_cases/geolocation/fetch_position_use_case.dart';

import '../../../../fixtures/position_fixture.dart';
import '../../../../mocks/repositories/mock_geolocation_repository.dart';

void main() {
  late FetchPositionUseCaseImpl sut;
  late MockGeolocationRepository repository;

  setUp(() {
    repository = MockGeolocationRepository();
    sut = FetchPositionUseCaseImpl(repository);
  });

  group('Success', () {
    test('should return position when permission is already granted', () async {
      // arrange
      final position = PositionFixture.entity();
      repository
        ..stubCheckPermission(LocationAccessPermission.permitted)
        ..stubGetCurrentPosition(position);

      // act
      final result = await sut();

      // assert
      expect(result.isRight, isTrue);
      expect(result.rightOrNull, equals(position));
      verifyInOrder([
        () => repository.checkPermission(),
        () => repository.getCurrentPosition(),
      ]);
      verifyNoMoreInteractions(repository);
    });

    test(
      'should return position when permission is granted after request',
      () async {
        // arrange
        final position = PositionFixture.entity();
        repository
          ..stubCheckPermission(LocationAccessPermission.denied)
          ..stubRequestPermission(LocationAccessPermission.permitted)
          ..stubGetCurrentPosition(position);

        // act
        final result = await sut();

        // assert
        expect(result.isRight, isTrue);
        expect(result.rightOrNull, equals(position));
        verifyInOrder([
          () => repository.checkPermission(),
          () => repository.requestPermission(),
          () => repository.getCurrentPosition(),
        ]);
        verifyNoMoreInteractions(repository);
      },
    );
  });

  group('Failure Cases', () {
    test('should return error when permission check fails', () async {
      // arrange
      repository.stubCheckPermissionException('error');

      // act
      final result = await sut();

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<UnknownFetchPositionException>());
      verifyInOrder([
        () => repository.checkPermission(),
      ]);
      verifyNoMoreInteractions(repository);
    });

    test('should return error when request permission fails', () async {
      // arrange
      repository
        ..stubCheckPermission(LocationAccessPermission.denied)
        ..stubRequestPermissionException('error');

      // act
      final result = await sut();

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<UnknownFetchPositionException>());
      verifyInOrder([
        () => repository.checkPermission(),
        () => repository.requestPermission(),
      ]);
      verifyNoMoreInteractions(repository);
    });

    test('should return error when permission is denied forever from check',
        () async {
      // arrange
      repository.stubCheckPermission(LocationAccessPermission.deniedForever);

      // act
      final result = await sut();

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<DeniedForeverFetchPositionException>());
      verifyInOrder([
        () => repository.checkPermission(),
      ]);
      verifyNoMoreInteractions(repository);
    });

    test('should return error when permission is denied forever from request',
        () async {
      // arrange
      repository
        ..stubCheckPermission(LocationAccessPermission.denied)
        ..stubRequestPermission(LocationAccessPermission.deniedForever);

      // act
      final result = await sut();

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<DeniedForeverFetchPositionException>());
      verifyInOrder([
        () => repository.checkPermission(),
        () => repository.requestPermission(),
      ]);
      verifyNoMoreInteractions(repository);
    });

    test('should return error when getting position fails', () async {
      // arrange
      repository
        ..stubCheckPermission(LocationAccessPermission.permitted)
        ..stubGetCurrentPositionException('error');

      // act
      final result = await sut();

      // assert
      expect(result.isLeft, isTrue);
      expect(result.leftOrNull, isA<UnknownFetchPositionException>());
      verifyInOrder([
        () => repository.checkPermission(),
        () => repository.getCurrentPosition(),
      ]);
      verifyNoMoreInteractions(repository);
    });
  });
}
