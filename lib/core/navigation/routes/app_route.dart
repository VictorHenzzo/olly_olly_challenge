import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Base class for defining application routes.
/// Provides common functionality for route building and transitions.
abstract class AppRoute {
  const AppRoute();

  /// Builds a [PageRouteBuilder] with custom transitions based on platform.
  /// Uses fade transition for web and slide transition for mobile platforms.
  Route<dynamic> buildRoute() {
    return PageRouteBuilder(
      settings: RouteSettings(
        name: routePath,
      ),
      pageBuilder: (final context, final _, final __) {
        return build(context);
      },
      transitionsBuilder: (final _, final animation, final __, final child) {
        if (kIsWeb) {
          return FadeTransition(
            opacity: animation.drive(CurveTween(curve: Curves.easeInOut)),
            child: child,
          );
        } else {
          return SlideTransition(
            position: animation.drive(
              Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeInOut)),
            ),
            child: child,
          );
        }
      },
    );
  }

  /// Builds the widget to be displayed for this route.
  Widget build(final BuildContext context);

  /// The path identifier for this route.
  String get routePath;
}
