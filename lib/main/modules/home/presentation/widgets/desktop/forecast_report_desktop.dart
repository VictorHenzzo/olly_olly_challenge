part of '../../home_screen.dart';

class _ForecastReportDesktop extends StatelessWidget {
  const _ForecastReportDesktop({
    required this.fetchData,
    required this.openAppSettings,
  });

  final VoidCallback fetchData;
  final VoidCallback openAppSettings;

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (final _, final state) {
        return switch (state) {
          HomeInitial() => _loading(),
          HomeLoading() => _loading(),
          HomeLoaded() => _ForecastLoadedBody(state: state),
          HomeLocationPermissionDenied() => _PermissionDeniedError(
              state: state,
              tryAgain: fetchData,
              openAppSettings: openAppSettings,
            ),
          HomeError() => _UnknownHomeError(tryAgain: fetchData),
        };
      },
    );
  }

  Widget _loading() {
    return const ScreenLoading();
  }
}

class _ForecastLoadedBody extends StatefulWidget {
  const _ForecastLoadedBody({
    required this.state,
  });

  final HomeLoaded state;

  @override
  State<_ForecastLoadedBody> createState() => _ForecastLoadedBodyState();
}

class _ForecastLoadedBodyState extends State<_ForecastLoadedBody> {
  int selectedIndex = 0;

  @override
  Widget build(final BuildContext context) {
    final uiContext = UiContext.of(context);
    final entries = widget.state.forecastReport.entries;
    final selected = entries[selectedIndex];

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
            const SizedBox(height: 8),
            if (icon != null)
              SizedBox.square(
                dimension: 60,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: WeatherIconViewer(icon),
                ),
              ),
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
