part of '../../home_screen.dart';

class _CurrentWeatherContent extends StatelessWidget {
  const _CurrentWeatherContent({
    required this.state,
    required this.isDesktop,
  });

  final HomeLoaded state;
  final bool isDesktop;

  @override
  Widget build(final BuildContext context) {
    final uiContext = UiContext.of(context);

    return isDesktop ? _buildDesktop(uiContext) : _buildMobile(uiContext);
  }

  Widget _buildMobile(final UiContext uiContext) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Column(
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
          Expanded(child: _buildCurrentWeatherInfo(uiContext)),
        ],
      ),
    );
  }

  Widget _buildDesktop(final UiContext uiContext) {
    return Padding(
      padding: const EdgeInsets.all(32),
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
    final color = _getAccentColor(uiContext);
    return Row(
      mainAxisAlignment:
          isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        Icon(Icons.location_on, color: color),
        const SizedBox(width: 8),
        Text(
          '${city.name}, ${city.country}',
          style: uiContext.textTheme.titleLarge?.copyWith(
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _todayInfo(final UiContext uiContext) {
    final now = DateTime.now();
    final dateStr =
        "${now.day.toString().padLeft(2, '0')} ${now.monthName()} ${now.year}";

    final text = isDesktop ? 'Current weather now, $dateStr' : dateStr;

    return Text(
      text,
      style: uiContext.textTheme.bodyLarge?.copyWith(
        color: _getAccentColor(uiContext),
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
          color: _getAccentColor(uiContext).withValues(alpha: 0.1),
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
        color: _getAccentColor(uiContext),
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildCurrentWeatherInfo(final UiContext uiContext) {
    final conditions = state.currentWeather.conditions;
    final wind = state.currentWeather.wind;
    final color = _getAccentColor(uiContext);
    final children = [
      _CardEntry(
        label: 'Temperature',
        value: '${conditions.temp}°F',
        uiContext: uiContext,
        color: color,
      ),
      _CardEntry(
        label: 'Feels Like',
        value: '${conditions.feelsLike}°F',
        uiContext: uiContext,
        color: color,
      ),
      _CardEntry(
        label: 'Min Temp',
        value: '${conditions.tempMin}°F',
        uiContext: uiContext,
        color: color,
      ),
      _CardEntry(
        label: 'Max Temp',
        value: '${conditions.tempMax}°F',
        uiContext: uiContext,
        color: color,
      ),
      _CardEntry(
        label: 'Pressure',
        value: '${conditions.pressure} hPa',
        uiContext: uiContext,
        color: color,
      ),
      _CardEntry(
        label: 'Sea Level',
        value: '${conditions.seaLevel} hPa',
        uiContext: uiContext,
        color: color,
      ),
      _CardEntry(
        label: 'Ground Level',
        value: '${conditions.grndLevel} hPa',
        uiContext: uiContext,
        color: color,
      ),
      _CardEntry(
        label: 'Humidity',
        value: '${conditions.humidity}%',
        uiContext: uiContext,
        color: color,
      ),
      _CardEntry(
        label: 'Wind speed',
        value: '${wind.speed} m/s',
        uiContext: uiContext,
        color: color,
      ),
      _CardEntry(
        label: 'Wind direction',
        value: '${wind.deg} °',
        uiContext: uiContext,
        color: color,
      ),
      _CardEntry(
        label: 'Wind gust',
        value: '${wind.gust} m/s',
        uiContext: uiContext,
        color: color,
      ),
      _CardEntry(
        label: 'Visibility',
        value: '${state.currentWeather.visibility} m',
        uiContext: uiContext,
        color: color,
      ),
    ];

    return ListView.separated(
      itemCount: children.length,
      padding: const EdgeInsets.symmetric(vertical: 12),
      separatorBuilder: (final _, final __) => const SizedBox(height: 4),
      itemBuilder: (final _, final index) {
        return children[index];
      },
    );
  }

  Widget _divider(final UiContext uiContext) {
    return Divider(
      color: _getAccentColor(uiContext).withValues(alpha: 0.2),
    );
  }

  Color _getAccentColor(final UiContext uiContext) {
    return isDesktop
        ? uiContext.colorScheme.onPrimary
        : uiContext.colorScheme.primary;
  }
}

class _CardEntry extends StatelessWidget {
  const _CardEntry({
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
