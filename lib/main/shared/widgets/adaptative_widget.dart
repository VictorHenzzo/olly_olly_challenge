import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A responsive widget that builds different UIs based on screen width,
/// and overlays a colored banner indicating the current layout type.
///
/// - small: width < 600  → BLUE banner
/// - medium: 600 <= width < 1024 → ORANGE banner
/// - large: width >= 1024 → GREEN banner
class AdaptativeWidgetBuilder extends StatelessWidget {
  const AdaptativeWidgetBuilder({
    required this.small,
    required this.medium,
    required this.large,
    super.key,
  });

  static const bool showDebugBanner = kDebugMode;

  final Widget Function(BuildContext context, BoxConstraints constraints) small;
  final Widget Function(BuildContext context, BoxConstraints constraints)
      medium;
  final Widget Function(BuildContext context, BoxConstraints constraints) large;

  @override
  Widget build(final BuildContext context) {
    return LayoutBuilder(
      builder: (final context, final constraints) {
        final width = constraints.maxWidth;

        late final Widget child;
        late final String label;
        late final Color color;

        if (width < 600) {
          child = small(context, constraints);
          label = 'SMALL';
          color = Colors.blue;
        } else if (width < 1024) {
          child = medium(context, constraints);
          label = 'MEDIUM';
          color = Colors.orange;
        } else {
          child = large(context, constraints);
          label = 'LARGE';
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
