import 'package:flutter/material.dart';
import 'package:weather_app/main/shared/ui_context.dart';

class BackgroundDecorationCard extends StatelessWidget {
  const BackgroundDecorationCard({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(final BuildContext context) {
    final uiContext = UiContext.of(context);
    return Container(
      decoration: BoxDecoration(
        color: uiContext.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: child,
    );
  }
}
