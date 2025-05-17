part of '../../home_screen.dart';

class _PermissionDeniedError extends StatelessWidget {
  const _PermissionDeniedError({
    required this.state,
    required this.tryAgain,
    required this.openAppSettings,
  });

  final HomeLocationPermissionDenied state;
  final VoidCallback tryAgain;
  final VoidCallback openAppSettings;

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
              Icons.block,
              color: uiContext.colorScheme.error,
              size: 80,
            ),
            const SizedBox(height: 24),
            Text(
              'Location permission required',
              style: uiContext.textTheme.headlineSmall?.copyWith(
                color: uiContext.colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "This app doesn't have the required permissions to access your location. Please allow location access to continue.",
              style: uiContext.textTheme.bodyLarge?.copyWith(
                color: uiContext.colorScheme.onSurface.withValues(alpha: 0.8),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: tryAgain,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
                if (state.canOpenAppSettings) ...[
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: openAppSettings,
                    icon: const Icon(Icons.settings),
                    label: const Text('Open App Settings'),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
