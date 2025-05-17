part of '../auth_screen.dart';

class _FormBackgroundCard extends StatelessWidget {
  const _FormBackgroundCard({
    required this.child,
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
