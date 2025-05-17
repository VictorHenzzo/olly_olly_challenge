part of '../../../home_screen.dart';

class _CurrentWeatherCardEntry extends StatelessWidget {
  const _CurrentWeatherCardEntry({
    required this.label,
    required this.value,
    required this.uiContext,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;
  final UiContext uiContext;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: uiContext.colorScheme.onPrimary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: uiContext.textTheme.bodyMedium?.copyWith(
              color: color,
            ),
          ),
          Text(
            value,
            style: uiContext.textTheme.bodyMedium?.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
