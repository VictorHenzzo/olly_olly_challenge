import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppNavigator {
  const AppNavigator();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();

  NavigatorState get _state => _navigatorKey.currentState!;

  Future<T?> pushNamed<T>(
    final String route, {
    final Object? arguments,
  }) {
    return _state.pushNamed(
      route,
      arguments: arguments,
    );
  }

  void pop<T>({
    final Object? result,
  }) {
    return _state.pop(result);
  }

  Future<T?> popAndPushNamed<T>(
    final String route, {
    final Object? arguments,
    final Object? result,
  }) {
    return _state.popAndPushNamed(
      route,
      arguments: arguments,
      result: result,
    );
  }

  void popUntil<T>({
    required final bool Function(Route<dynamic>) predicate,
  }) {
    return _state.popUntil(predicate);
  }

  Future<T?> pushNamedAndRemoveUntil<T>(
    final String newRouteName, {
    required final bool Function(Route<dynamic>) predicate,
    final Object? arguments,
  }) {
    return _state.pushNamedAndRemoveUntil(
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  Future<T?> pushNamedReplacement<T>(
    final String route, {
    final Object? arguments,
  }) {
    return _state.pushReplacementNamed(
      route,
      arguments: arguments,
    );
  }

  Future<T?>? pushNamedAndRemoveAll<T>(
    final String newRouteName, {
    final Object? arguments,
  }) async {
    return _state.pushNamedAndRemoveUntil(
      newRouteName,
      (final _) => false,
      arguments: arguments,
    );
  }
}
