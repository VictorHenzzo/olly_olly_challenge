import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/infra/either/either.dart';

void main() {
  late Either<Exception, String> sut;
  late Exception failure;
  late String success;

  late _CallbackMock<Exception, String> callbackSpy;

  setUp(() {
    failure = Exception();
    success = 'success';

    callbackSpy = _CallbackMock();

    when(
      () => callbackSpy.onRightAsync(success),
    ).thenAnswer((final _) => Future.value());
    when(
      () => callbackSpy.onLeftAsync(failure),
    ).thenAnswer((final _) => Future.value());
  });

  group('Right', () {
    setUp(() {
      sut = Right(success);
    });

    test('Should return true on isRight', () {
      // assert
      expect(sut.isRight, isTrue);
    });

    test('Should return false on isLeft', () {
      // assert
      expect(sut.isLeft, isFalse);
    });

    test('Should return value on rightOrNull', () {
      // assert
      expect(sut.rightOrNull, success);
    });

    test('Should return null on leftOrNull', () {
      // assert
      expect(sut.leftOrNull, isNull);
    });

    test('Should call onSuccess on fold', () {
      // act
      sut.fold(
        onLeft: callbackSpy.onLeft,
        onRight: callbackSpy.onRight,
      );

      // assert
      verify(() => callbackSpy.onRight(success)).called(1);
      verifyNoMoreInteractions(callbackSpy);
    });

    test('Should call onSuccess on map', () {
      // arrange
      String onSuccess(final String value) => 'success';
      String onError(final Exception error) => 'error';

      // act
      final result = sut.map(
        onRight: onSuccess,
        onLeft: onError,
      );

      // assert
      expect(result, 'success');
    });

    test('Should call onSuccess on asyncFold', () {
      // act
      sut.foldAsync(
        onLeft: callbackSpy.onLeftAsync,
        onRight: callbackSpy.onRightAsync,
      );

      // assert
      verify(() => callbackSpy.onRightAsync(success)).called(1);
      verifyNoMoreInteractions(callbackSpy);
    });
  });

  group('Left', () {
    setUp(() {
      sut = Left(failure);
    });

    test('Should return false on isRight', () {
      // assert
      expect(sut.isRight, isFalse);
    });

    test('Should return true on isLeft', () {
      // assert
      expect(sut.isLeft, isTrue);
    });

    test('Should return null on rightOrNull', () {
      // assert
      expect(sut.rightOrNull, isNull);
    });

    test('Should return failure on leftOrNull', () {
      // assert
      expect(sut.leftOrNull, failure);
    });

    test('Should call onFailure on fold', () {
      // act
      sut.fold(
        onLeft: callbackSpy.onLeft,
        onRight: callbackSpy.onRight,
      );

      // assert
      verify(() => callbackSpy.onLeft(failure)).called(1);
      verifyNoMoreInteractions(callbackSpy);
    });

    test('Should call onError on map', () {
      // arrange
      String onSuccess(final String value) => 'success';
      String onError(final Exception error) => 'error';

      // act
      final result = sut.map(
        onRight: onSuccess,
        onLeft: onError,
      );

      // assert
      expect(result, 'error');
      verifyNoMoreInteractions(callbackSpy);
    });

    test('Should call onFailure on asyncFold', () {
      // act
      sut.foldAsync(
        onLeft: callbackSpy.onLeftAsync,
        onRight: callbackSpy.onRightAsync,
      );

      // assert
      verify(() => callbackSpy.onLeftAsync(failure)).called(1);
      verifyNoMoreInteractions(callbackSpy);
    });
  });
}

class _CallbackMock<F, S> extends Mock {
  void onLeft(final F value);
  void onRight(final S value);
  Future<void> onLeftAsync(final F value);
  Future<void> onRightAsync(final S value);
}
