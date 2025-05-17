part of '../../../home_screen.dart';

class _CurrentWeatherHeader extends StatelessWidget {
  const _CurrentWeatherHeader({
    required this.state,
    required this.uiContext,
    required this.accentColor,
    required this.isDesktop,
  });

  final HomeLoaded state;
  final UiContext uiContext;
  final Color accentColor;
  final bool isDesktop;

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _cityInfo(uiContext),
        const SizedBox(height: 4),
        _todayInfo(uiContext),
        const SizedBox(height: 16),
        Align(child: _weatherIcon(uiContext)),
        const SizedBox(height: 16),
        Align(child: _temperature(uiContext)),
      ],
    );
  }

  Widget _cityInfo(final UiContext uiContext) {
    final city = state.forecastReport.city;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.location_on, color: accentColor),
        const SizedBox(width: 8),
        Text(
          '${city.name}, ${city.country}',
          style: uiContext.textTheme.titleLarge?.copyWith(
            color: accentColor,
          ),
        ),
      ],
    );
  }

  Widget _todayInfo(final UiContext uiContext) {
    final now = DateTime.now();
    final date =
        "${now.day.toString().padLeft(2, '0')} ${now.monthName()} ${now.year}";

    final text = isDesktop ? 'Current weather now: $date' : date;

    return Text(
      text,
      style: uiContext.textTheme.bodyLarge?.copyWith(
        color: accentColor,
      ),
      textAlign: TextAlign.center,
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
          color: accentColor.withValues(alpha: 0.1),
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
        color: accentColor,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
