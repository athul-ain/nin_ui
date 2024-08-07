import 'package:flutter/material.dart';

import 'color.dart';

ThemeData ninUiThemeData({
  required Color primaryColor,
  required Brightness brightness,
  ColorScheme? colorScheme,
}) {
  final ColorScheme colorSchemeGen = colorScheme ??
      ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: brightness,
      );

  return ThemeData(
    visualDensity: VisualDensity.standard,
    colorScheme: colorSchemeGen,
    useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      },
    ),
    searchBarTheme: SearchBarThemeData(
      backgroundColor: WidgetStatePropertyAll(getContentColor(colorSchemeGen)),
      constraints: const BoxConstraints(
        maxHeight: 53,
        minHeight: 53,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: getBackgroundColor(colorSchemeGen),
      foregroundColor: colorSchemeGen.onSurface,
    ),
  );
}

extension ThemeDataExtension on ThemeData {
  ThemeData fromNinUi({
    required Color primaryColor,
    required Brightness brightness,
    ColorScheme? colorScheme,
  }) {
    return ninUiThemeData(
      primaryColor: primaryColor,
      brightness: brightness,
      colorScheme: colorScheme,
    );
  }
}
