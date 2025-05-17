part of '../../home_screen.dart';

class _DrawerCurrentWeatherContent extends StatelessWidget {
  const _DrawerCurrentWeatherContent({
    required this.state,
  });

  final HomeLoaded state;

  @override
  Widget build(final BuildContext context) {
    final uiContext = UiContext.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        left: 32,
        right: 32,
        top: 32,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: uiContext.colorScheme.primary,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _cityInfo(uiContext),
            const SizedBox(height: 4),
            _todayInfo(uiContext),
            const SizedBox(height: 16),
            Align(child: _weatherIcon(uiContext)),
            const SizedBox(height: 16),
            Align(child: _temperature(uiContext)),
            const SizedBox(height: 24),
            _divider(uiContext),
            const SizedBox(height: 16),
            Expanded(child: _buildCurrentWeatherInfo(uiContext)),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _cityInfo(final UiContext uiContext) {
    final city = state.forecastReport.city;
    return Row(
      children: [
        Icon(Icons.location_on, color: uiContext.colorScheme.onPrimary),
        const SizedBox(width: 8),
        Text(
          '${city.name}, ${city.country}',
          style: uiContext.textTheme.titleLarge?.copyWith(
            color: uiContext.colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }

  Widget _todayInfo(final UiContext uiContext) {
    final now = DateTime.now();
    final dateStr =
        "${now.day.toString().padLeft(2, '0')} ${now.monthName()} ${now.year}";

    return Text(
      'Current weather now, $dateStr',
      style: uiContext.textTheme.bodyLarge?.copyWith(
        color: uiContext.colorScheme.onPrimary,
      ),
      textAlign: TextAlign.start,
    );
  }

  Widget _weatherIcon(final UiContext uiContext) {
    final weather = state.currentWeather.weather;

    if (weather.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox.square(
      dimension: uiContext.shp(15),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: uiContext.colorScheme.onPrimary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(35),
        ),
        child: WeatherIconViewer(
          weather.first.icon,
        ),
      ),
    );
  }

  Widget _temperature(final UiContext uiContext) {
    final temp = state.currentWeather.conditions.temp.round();

    return Text(
      '$temp°F',
      style: uiContext.textTheme.displayMedium?.copyWith(
        color: uiContext.colorScheme.onPrimary,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildCurrentWeatherInfo(final UiContext uiContext) {
    final conditions = state.currentWeather.conditions;
    final wind = state.currentWeather.wind;

    final children = [
      _CardEntry(
        label: 'Temperature',
        value: '${conditions.temp}°F',
        uiContext: uiContext,
      ),
      _CardEntry(
        label: 'Feels Like',
        value: '${conditions.feelsLike}°F',
        uiContext: uiContext,
      ),
      _CardEntry(
        label: 'Min Temp',
        value: '${conditions.tempMin}°F',
        uiContext: uiContext,
      ),
      _CardEntry(
        label: 'Max Temp',
        value: '${conditions.tempMax}°F',
        uiContext: uiContext,
      ),
      _CardEntry(
        label: 'Pressure',
        value: '${conditions.pressure} hPa',
        uiContext: uiContext,
      ),
      _CardEntry(
        label: 'Sea Level',
        value: '${conditions.seaLevel} hPa',
        uiContext: uiContext,
      ),
      _CardEntry(
        label: 'Ground Level',
        value: '${conditions.grndLevel} hPa',
        uiContext: uiContext,
      ),
      _CardEntry(
        label: 'Humidity',
        value: '${conditions.humidity}%',
        uiContext: uiContext,
      ),
      _CardEntry(
        label: 'Wind speed',
        value: '${wind.speed} m/s',
        uiContext: uiContext,
      ),
      _CardEntry(
        label: 'Wind direction',
        value: '${wind.deg} °',
        uiContext: uiContext,
      ),
      _CardEntry(
        label: 'Wind gust',
        value: '${wind.gust} m/s',
        uiContext: uiContext,
      ),
      _CardEntry(
        label: 'Visibility',
        value: '${state.currentWeather.visibility} m',
        uiContext: uiContext,
      ),
    ];

    return ListView.separated(
      itemCount: children.length,
      separatorBuilder: (final _, final __) => const SizedBox(height: 4),
      itemBuilder: (final _, final index) {
        return children[index];
      },
    );
  }

  Widget _divider(final UiContext uiContext) {
    return Divider(
      color: uiContext.colorScheme.onPrimary.withValues(alpha: 0.2),
    );
  }
}

class _CardEntry extends StatelessWidget {
  const _CardEntry({
    required this.label,
    required this.value,
    required this.uiContext,
  });

  final String label;
  final String value;
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
              color: uiContext.colorScheme.onPrimary,
            ),
          ),
          Text(
            value,
            style: uiContext.textTheme.bodyMedium?.copyWith(
              color: uiContext.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
