import 'package:flutter/material.dart';
import 'package:weather_app/main/shared/ui_context.dart';

class ScreenLoading extends StatelessWidget {
  const ScreenLoading({
    super.key,
    this.color,
    this.dimension,
  });

  final Color? color;
  final double? dimension;

  @override
  Widget build(final BuildContext context) {
    final uiContext = UiContext.of(context);
    final dimension = this.dimension ?? uiContext.shp(10);
    final width = uiContext.shp(1.5);

    return Center(
      child: SizedBox.square(
        dimension: dimension,
        child: CircularProgressIndicator(
          strokeCap: StrokeCap.round,
          strokeWidth: width,
          color: color ?? uiContext.colorScheme.primary,
        ),
      ),
    );
  }
}
