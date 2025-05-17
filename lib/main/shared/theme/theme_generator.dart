// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:weather_app/core/infra/logger/logger.dart';
import 'package:weather_app/core/infra/service_locator/service_locator.dart';

class ThemeGenerator {
  const ThemeGenerator();
  Future<ThemeData> generateTheme() async {
    try {
      final themeStr = await rootBundle.loadString('assets/theme.json');
      final themeJson = jsonDecode(themeStr);
      return ThemeDecoder.decodeThemeData(themeJson)!;
    } catch (e) {
      _logError(e);
      return ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFec6e4c)),
        useMaterial3: true,
      );
    }
  }

  void _logError(final Object error) {
    final loger = ServiceLocator().get<Logger>();
    const message = 'Error generating theme';
    loger.error(message, error: error);
  }
}
