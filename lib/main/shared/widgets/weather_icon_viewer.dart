import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/infra/env/environment.dart';
import 'package:weather_app/main/shared/ui_context.dart';
import 'package:weather_app/main/shared/widgets/screen_loading.dart';

class WeatherIconViewer extends StatelessWidget {
  const WeatherIconViewer(
    this.weatherIconId, {
    super.key,
  });

  final String weatherIconId;

  @override
  Widget build(final BuildContext context) {
    final uiContext = UiContext.of(context);
    return CachedNetworkImage(
      imageUrl: _getWeatherIconUrl(),
      placeholder: (final _, final __) => _placeholder(uiContext),
      errorWidget: (final _, final __, final ___) => _errorWidget(uiContext),
    );
  }

  Widget _placeholder(final UiContext uiContext) {
    return ScreenLoading(
      dimension: uiContext.shp(5),
    );
  }

  Widget _errorWidget(final UiContext uiContext) {
    return Icon(Icons.error, color: uiContext.colorScheme.error);
  }

  String _getWeatherIconUrl() {
    const environment = Environment();
    final baseUrl = environment.weatherApiIconUrl;
    return '$baseUrl/$weatherIconId@2x.png';
  }
}
