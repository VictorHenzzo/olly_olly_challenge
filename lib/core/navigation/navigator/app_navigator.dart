import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

/// A centralized navigation service that provides methods
/// for managing app navigation.
/// This class wraps Flutter's navigation functionality and
/// provides a consistent API for navigating between screens
/// throughout the application.
@injectable
class AppNavigator {
  const AppNavigator();

  /// The global key used to access the navigator state.
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();

  NavigatorState get _state => _navigatorKey.currentState!;

  /// Pushes a named route onto the navigation stack.
  Future<T?> pushNamed<T>(
    final String route, {
    final Object? arguments,
  }) {
    return _state.pushNamed(
      route,
      arguments: arguments,
    );
  }

  /// Pops the current route off the navigation stack.
  void pop<T>({
    final Object? result,
  }) {
    return _state.pop(result);
  }

  /// Pops the current route and pushes a new named route.
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

  /// Pops routes until the given predicate returns true.
  void popUntil<T>({
    required final bool Function(Route<dynamic>) predicate,
  }) {
    return _state.popUntil(predicate);
  }

  /// Pushes a named route and removes all previous routes that match the predicate.
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

  /// Replaces the current route with a new named route.
  Future<T?> pushNamedReplacement<T>(
    final String route, {
    final Object? arguments,
  }) {
    return _state.pushReplacementNamed(
      route,
      arguments: arguments,
    );
  }

  /// Pushes a named route and removes all previous routes from the stack.
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
