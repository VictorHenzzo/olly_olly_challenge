part of '../../../home_screen.dart';

class _SelectedForecastDetails extends StatelessWidget {
  const _SelectedForecastDetails({
    required this.entry,
    required this.uiContext,
  });

  final ForecastEntryEntity entry;
  final UiContext uiContext;

  @override
  Widget build(final BuildContext context) {
    final day = entry.dateTime.weekdayName();
    final date =
        "${entry.dateTime.day.toString().padLeft(2, '0')} ${entry.dateTime.monthName()}";
    final temp = entry.conditions.temp.round();
    final feelsLike = entry.conditions.feelsLike.round();
    final tempMin = entry.conditions.tempMin.round();
    final tempMax = entry.conditions.tempMax.round();
    final pressure = entry.conditions.pressure;
    final seaLevel = entry.conditions.seaLevel;
    final grndLevel = entry.conditions.grndLevel;
    final humidity = entry.conditions.humidity;
    final icon = entry.weather.isNotEmpty ? entry.weather.first.icon : null;
    final color = uiContext.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          if (icon != null)
            SizedBox(
              height: 64,
              width: 64,
              child: WeatherIconViewer(icon),
            ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$day, $date',
                  style: uiContext.textTheme.titleLarge?.copyWith(
                    color: color,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${temp}F°',
                  style: uiContext.textTheme.displaySmall?.copyWith(
                    color: color,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 32,
                  runSpacing: 8,
                  children: [
                    _buildPair('Feels Like', '${feelsLike}F°'),
                    _buildPair('Min Temp', '${tempMin}F°'),
                    _buildPair('Max Temp', '${tempMax}F°'),
                    _buildPair('Pressure', '$pressure hPa'),
                    _buildPair('Sea Level', '$seaLevel hPa'),
                    _buildPair('Ground Level', '$grndLevel hPa'),
                    _buildPair('Humidity', '$humidity%'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPair(final String label, final String value) {
    final color = uiContext.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: uiContext.textTheme.bodySmall?.copyWith(
            color: color.withValues(alpha: 0.7),
          ),
        ),
        Text(
          value,
          style: uiContext.textTheme.bodyMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
