import 'package:equatable/equatable.dart';

/// A generic `Either` type representing a value of one of two possible types.
///
/// Typically used for operations that can succeed or fail.
/// - `Left<E>` represents failure, carrying an error of type `E`.
/// - `Right<V>` represents success, carrying a value of type `V`.
///
/// Inspired by functional programming patterns.
abstract class Either<E, V> extends Equatable {
  const Either();

  /// Returns `true` if this is a [Left] instance.
  bool get isLeft;

  /// Returns `true` if this is a [Right] instance.
  bool get isRight;

  /// Returns the right value if available, or `null` otherwise.
  V? get rightOrNull;

  /// Returns the left value if available, or `null` otherwise.
  E? get leftOrNull;

  /// Executes either [onLeft] or [onRight] depending on the actual type.
  void fold({
    required final void Function(E left) onLeft,
    required final void Function(V right) onRight,
  });

  /// Same as [fold], but supports asynchronous handlers.
  Future<void> foldAsync({
    required final Future<void> Function(E left) onLeft,
    required final Future<void> Function(V right) onRight,
  });

  /// Maps the contained value to a new value using either [onLeft]
  /// or [onRight].
  T map<T>({
    required final T Function(E left) onLeft,
    required final T Function(V right) onRight,
  });
}

/// A right-sided `Either` indicating a successful computation with value [V].
class Right<E, V> extends Either<E, V> {
  /// Creates a [Right] containing a success value.
  const Right(this.value);

  /// The wrapped success value.
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
    required final T Function(E left) onLeft,
    required final T Function(V right) onRight,
  }) =>
      onRight(value);

  @override
  List<Object?> get props => [value];
}

/// A left-sided `Either` indicating a failed computation with error [E].
class Left<E, V> extends Either<E, V> {
  /// Creates a [Left] containing an error or failure value.
  const Left(this.value);

  /// The wrapped failure/error value.
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
    required final T Function(E left) onLeft,
    required final T Function(V right) onRight,
  }) =>
      onLeft(value);

  @override
  List<Object?> get props => [value];
}
