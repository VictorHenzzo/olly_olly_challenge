import 'package:flutter/material.dart';

/// A responsive widget that builds different UIs based on screen width.
///
/// - small: width < 600
/// - medium: 600 <= width < 1024
/// - large: width >= 1024
class AdaptativeWidgetBuilder extends StatelessWidget {
  const AdaptativeWidgetBuilder({
    required this.small,
    required this.medium,
    required this.large,
    super.key,
  });

  final Widget Function(BuildContext context, BoxConstraints constraints) small;
  final Widget Function(BuildContext context, BoxConstraints constraints)
      medium;
  final Widget Function(BuildContext context, BoxConstraints constraints) large;

  @override
  Widget build(final BuildContext context) {
    return LayoutBuilder(
      builder: (final context, final constraints) {
        final width = constraints.maxWidth;

        if (width < 600) {
          return small(context, constraints);
        } else if (width < 1024) {
          return medium(context, constraints);
        } else {
          return large(context, constraints);
        }
      },
    );
  }
}
