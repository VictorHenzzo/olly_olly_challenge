import 'package:flutter/material.dart';

/// A convenience wrapper around [BuildContext] that extracts and
/// provides quick access to common UI-related data such as [ThemeData]
/// and screen dimensions.
///
/// Use [UiContext.of(context)] to initialize.
class UiContext {
  /// Creates an instance of [UiContext] with the provided [theme] and [screenSize].
  UiContext({
    required this.theme,
    required this.screenSize,
  });

  /// Instantiates [UiContext] by extracting [ThemeData] and screen size from [BuildContext].
  factory UiContext.of(final BuildContext context) {
    return UiContext(
      theme: Theme.of(context),
      screenSize: MediaQuery.sizeOf(context),
    );
  }

  /// The current [ThemeData], including colors, text styles, etc.
  final ThemeData theme;

  /// The logical size of the screen (width & height in logical pixels).
  final Size screenSize;

  /// A shortcut to the current [TextTheme], from [theme].
  TextTheme get textTheme => theme.textTheme;

  /// A shortcut to the current [ColorScheme], from [theme].
  ColorScheme get colorScheme => theme.colorScheme;

  /// Returns a width value that is [value]% of the screen width.
  ///
  /// Example: `swp(50)` returns half the screen width.
  double swp(final double value) {
    final percentage = value.clamp(0, 100);
    return screenSize.width * (percentage * 0.01);
  }

  /// Returns a height value that is [value]% of the screen height.
  ///
  /// Example: `shp(25)` returns one-quarter of the screen height.
  double shp(final double value) {
    final percentage = value.clamp(0, 100);
    return screenSize.height * (percentage * 0.01);
  }
}
