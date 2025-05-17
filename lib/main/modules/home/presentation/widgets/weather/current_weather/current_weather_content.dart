part of '../../../home_screen.dart';

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
    final children = _getInfoCards(uiContext);

    return Padding(
      padding: isDesktop
          ? const EdgeInsets.all(32)
          : const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Column(
        children: [
          const SizedBox(height: 16),
          _CurrentWeatherHeader(
            state: state,
            uiContext: uiContext,
            accentColor: _getAccentColor(uiContext),
            isDesktop: isDesktop,
          ),
          const SizedBox(height: 24),
          _divider(uiContext),
          Expanded(
            child: Padding(
              padding: isDesktop
                  ? const EdgeInsets.symmetric(vertical: 16)
                  : EdgeInsets.zero,
              child: ListView.separated(
                itemCount: children.length,
                padding: const EdgeInsets.symmetric(vertical: 12),
                separatorBuilder: (final _, final __) =>
                    const SizedBox(height: 4),
                itemBuilder: (final _, final index) {
                  return children[index];
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getInfoCards(final UiContext uiContext) {
    final conditions = state.currentWeather.conditions;
    final wind = state.currentWeather.wind;
    final color = _getAccentColor(uiContext);
    return [
      _CurrentWeatherCardEntry(
        label: 'Temperature',
        value: '${conditions.temp}°F',
        uiContext: uiContext,
        color: color,
      ),
      _CurrentWeatherCardEntry(
        label: 'Feels Like',
        value: '${conditions.feelsLike}°F',
        uiContext: uiContext,
        color: color,
      ),
      _CurrentWeatherCardEntry(
        label: 'Min Temp',
        value: '${conditions.tempMin}°F',
        uiContext: uiContext,
        color: color,
      ),
      _CurrentWeatherCardEntry(
        label: 'Max Temp',
        value: '${conditions.tempMax}°F',
        uiContext: uiContext,
        color: color,
      ),
      _CurrentWeatherCardEntry(
        label: 'Pressure',
        value: '${conditions.pressure} hPa',
        uiContext: uiContext,
        color: color,
      ),
      _CurrentWeatherCardEntry(
        label: 'Sea Level',
        value: '${conditions.seaLevel} hPa',
        uiContext: uiContext,
        color: color,
      ),
      _CurrentWeatherCardEntry(
        label: 'Ground Level',
        value: '${conditions.grndLevel} hPa',
        uiContext: uiContext,
        color: color,
      ),
      _CurrentWeatherCardEntry(
        label: 'Humidity',
        value: '${conditions.humidity}%',
        uiContext: uiContext,
        color: color,
      ),
      _CurrentWeatherCardEntry(
        label: 'Wind speed',
        value: '${wind.speed} m/s',
        uiContext: uiContext,
        color: color,
      ),
      _CurrentWeatherCardEntry(
        label: 'Wind direction',
        value: '${wind.deg} °',
        uiContext: uiContext,
        color: color,
      ),
      _CurrentWeatherCardEntry(
        label: 'Wind gust',
        value: '${wind.gust} m/s',
        uiContext: uiContext,
        color: color,
      ),
      _CurrentWeatherCardEntry(
        label: 'Visibility',
        value: '${state.currentWeather.visibility} m',
        uiContext: uiContext,
        color: color,
      ),
    ];
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
