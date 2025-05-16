import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class AppRoute {
  const AppRoute();

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

  Widget build(final BuildContext context);
  String get routePath;
}
