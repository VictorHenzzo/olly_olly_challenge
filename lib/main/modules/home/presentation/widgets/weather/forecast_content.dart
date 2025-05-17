part of '../../home_screen.dart';

class _ForecastContent extends StatefulWidget {
  const _ForecastContent({
    required this.state,
    required this.isDesktop,
  });

  final HomeLoaded state;
  final bool isDesktop;

  @override
  State<_ForecastContent> createState() => _ForecastContentState();
}

class _ForecastContentState extends State<_ForecastContent> {
  int selectedIndex = 0;

  List<ForecastEntryEntity> get entries => widget.state.forecastReport.entries;
  ForecastEntryEntity get selected => entries[selectedIndex];

  @override
  Widget build(final BuildContext context) {
    final uiContext = UiContext.of(context);

    return widget.isDesktop
        ? _buildDesktop(uiContext)
        : _buildMobile(uiContext);
  }

  Widget _buildDesktop(final UiContext uiContext) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 64,
        right: 64,
        top: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '5-Day Forecast',
            style: uiContext.textTheme.headlineLarge?.copyWith(
              color: uiContext.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tap a day to see details',
            style: uiContext.textTheme.bodyLarge?.copyWith(
              color: uiContext.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          Text(
            'Selected Forecast',
            style: uiContext.textTheme.titleMedium?.copyWith(
              color: uiContext.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          _SelectedForecastDisplay(entry: selected, uiContext: uiContext),
          const SizedBox(height: 8),
          const Divider(),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: entries.length,
              padding: const EdgeInsets.only(top: 8, bottom: 32),
              itemBuilder: (final context, final index) {
                final entry = entries[index];
                return _ForecastDayCard(
                  entry: entry,
                  selected: index == selectedIndex,
                  uiContext: uiContext,
                  onTap: () {
                    setState(() => selectedIndex = index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobile(final UiContext uiContext) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SelectedForecastDisplay(entry: selected, uiContext: uiContext),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          Text(
            'Tap a day to see details',
            style: uiContext.textTheme.bodyLarge?.copyWith(
              color: uiContext.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: entries.length,
              padding: const EdgeInsets.only(top: 8, bottom: 32),
              itemBuilder: (final context, final index) {
                final entry = entries[index];
                return _ForecastDayCard(
                  entry: entry,
                  selected: index == selectedIndex,
                  uiContext: uiContext,
                  onTap: () {
                    setState(() => selectedIndex = index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ForecastDayCard extends StatelessWidget {
  const _ForecastDayCard({
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
            Text(
              '$day - ${temp}F°',
              style: uiContext.textTheme.titleSmall?.copyWith(
                color: color,
              ),
            ),
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

class _SelectedForecastDisplay extends StatelessWidget {
  const _SelectedForecastDisplay({
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
