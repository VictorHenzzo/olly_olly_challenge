import 'package:flutter/material.dart';

/// A responsive widget that builds different UIs based on screen width,
/// and overlays a colored banner indicating the current layout type.
class AdaptativeWidgetBuilder extends StatelessWidget {
  const AdaptativeWidgetBuilder({
    required this.mobile,
    required this.desktop,
    super.key,
  });

  static const bool showDebugBanner = false;

  final Widget Function(BuildContext context, BoxConstraints constraints)
      mobile;
  final Widget Function(BuildContext context, BoxConstraints constraints)
      desktop;

  @override
  Widget build(final BuildContext context) {
    return LayoutBuilder(
      builder: (final context, final constraints) {
        final width = constraints.maxWidth;

        late final Widget child;
        late final String label;
        late final Color color;

        if (width < 700) {
          child = mobile(context, constraints);
          label = 'MOBILE';
          color = Colors.blue;
        } else {
          child = desktop(context, constraints);
          label = 'DESKTOP';
          color = Colors.green;
        }

        if (!showDebugBanner) {
          return child;
        }

        return Banner(
          message: label,
          location: BannerLocation.topEnd,
          color: color,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 1.5,
          ),
          child: child,
        );
      },
    );
  }
}
