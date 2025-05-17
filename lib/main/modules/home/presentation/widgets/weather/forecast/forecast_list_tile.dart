part of '../../../home_screen.dart';

class _ForecastListTile extends StatelessWidget {
  const _ForecastListTile({
    required this.entry,
    required this.selected,
    required this.uiContext,
    required this.onTap,
  });

  final ForecastEntryEntity entry;
  final bool selected;
  final UiContext uiContext;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    final day = entry.dateTime.weekdayName();
    final temp = entry.conditions.temp.round();
    final icon = entry.weather.isNotEmpty ? entry.weather.first.icon : null;
    final color = uiContext.colorScheme.primary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: selected
              ? color.withValues(alpha: 0.15)
              : color.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(32),
          border: selected ? Border.all(color: color, width: 2) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              '$day - ${temp}F°',
              style: uiContext.textTheme.titleSmall?.copyWith(
                color: color,
              ),
            ),
            const Spacer(),
            if (icon != null) ...[
              const Spacer(),
              SizedBox.square(
                dimension: 45,
                child: Container(
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: WeatherIconViewer(icon),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
