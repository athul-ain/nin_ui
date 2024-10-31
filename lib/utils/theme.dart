import 'package:flutter/material.dart';
import 'color.dart';

ThemeData ninUiThemeData({
  required Color primaryColor,
  required Brightness brightness,
  ColorScheme? colorScheme,
  bool isOneUi = false,
}) {
  final ColorScheme colorSchemeGen = colorScheme ??
      ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: brightness,
      );

  return ThemeData(
    visualDensity: VisualDensity.standard,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    colorScheme: colorSchemeGen,
    useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      },
    ),
    searchBarTheme: SearchBarThemeData(
      backgroundColor:
          WidgetStatePropertyAll(getBackgroundColor(colorSchemeGen)),
      elevation: const WidgetStatePropertyAll(0),
      constraints: const BoxConstraints(
        maxHeight: 53,
        minHeight: 53,
      ),
    ),
    appBarTheme: AppBarTheme(
      titleSpacing: isOneUi ? 0 : null,
      backgroundColor: getBackgroundColor(colorSchemeGen),
      foregroundColor: colorSchemeGen.onSurface,
    ),
    inputDecorationTheme: const InputDecorationTheme(filled: true),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    actionIconTheme: isOneUi
        ? ActionIconThemeData(
            backButtonIconBuilder: (context) {
              return const Icon(Icons.arrow_back_ios_new_rounded);
            },
          )
        : null,
  );
}

extension ThemeDataExtension on ThemeData {
  ThemeData fromNinUi({
    required Color primaryColor,
    required Brightness brightness,
    ColorScheme? colorScheme,
    bool isOneUi = false,
  }) {
    return ninUiThemeData(
      primaryColor: primaryColor,
      brightness: brightness,
      colorScheme: colorScheme,
      isOneUi: isOneUi,
    );
  }
}
