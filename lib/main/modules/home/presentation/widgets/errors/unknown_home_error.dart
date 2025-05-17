part of '../../home_screen.dart';

class _UnknownHomeError extends StatelessWidget {
  const _UnknownHomeError({
    required this.tryAgain,
  });

  final VoidCallback tryAgain;

  @override
  Widget build(final BuildContext context) {
    final uiContext = UiContext.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: uiContext.colorScheme.error,
              size: 80,
            ),
            const SizedBox(height: 24),
            Text(
              'Something went wrong',
              style: uiContext.textTheme.headlineSmall?.copyWith(
                color: uiContext.colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'An unexpected error occurred. Please try again.',
              style: uiContext.textTheme.bodyLarge?.copyWith(
                color: uiContext.colorScheme.onSurface.withValues(alpha: 0.8),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: tryAgain,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
