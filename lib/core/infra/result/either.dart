import 'package:equatable/equatable.dart';

abstract class Either<E, V> extends Equatable {
  const Either();

  bool get isLeft;
  bool get isRight;

  V? get rightOrNull;
  E? get leftOrNull;

  void fold({
    required final void Function(E left) onLeft,
    required final void Function(V right) onRight,
  });

  Future<void> foldAsync({
    required final Future<void> Function(E left) onLeft,
    required final Future<void> Function(V right) onRight,
  });

  T map<T>({
    required final T Function(E left) onLeft,
    required final T Function(V right) onRight,
  });
}

class Right<E, V> extends Either<E, V> {
  const Right(this.value);
  final V value;

  @override
  E? get leftOrNull => null;

  @override
  V? get rightOrNull => value;

  @override
  bool get isRight => true;

  @override
  bool get isLeft => false;

  @override
  void fold({
    required final void Function(E left) onLeft,
    required final void Function(V right) onRight,
  }) =>
      onRight(value);

  @override
  Future<void> foldAsync({
    required final Future<void> Function(E left) onLeft,
    required final Future<void> Function(V right) onRight,
  }) async {
    await onRight(value);
  }

  @override
  T map<T>({
    required T Function(E left) onLeft,
    required final T Function(V right) onRight,
  }) =>
      onRight(value);

  @override
  List<Object?> get props => [value];
}

class Left<E, V> extends Either<E, V> {
  const Left(this.value);
  final E value;

  @override
  bool get isRight => false;

  @override
  bool get isLeft => true;

  @override
  E? get leftOrNull => value;

  @override
  V? get rightOrNull => null;

  @override
  void fold({
    required final void Function(E left) onLeft,
    required final void Function(V right) onRight,
  }) =>
      onLeft(value);

  @override
  Future<void> foldAsync({
    required final Future<void> Function(E left) onLeft,
    required final Future<void> Function(V right) onRight,
  }) async {
    await onLeft(value);
  }

  @override
  T map<T>({
    required T Function(E left) onLeft,
    required final T Function(V right) onRight,
  }) =>
      onLeft(value);

  @override
  List<Object?> get props => [value];
}
