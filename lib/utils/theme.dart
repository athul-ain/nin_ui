import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
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

  final bool isOledBlack = isOneUi && Brightness.dark == brightness;

  return ThemeData(
    visualDensity: VisualDensity.standard,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    colorScheme: colorSchemeGen.copyWith(
      surface: isOledBlack ? Colors.black : null,
    ),
    useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      },
    ),
    searchBarTheme: SearchBarThemeData(
      backgroundColor: WidgetStatePropertyAll(getContentColor(colorSchemeGen)),
      elevation: const WidgetStatePropertyAll(0),
      constraints: const BoxConstraints(
        maxHeight: 53,
        minHeight: 53,
      ),
    ),
    cardTheme: CardThemeData(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    ),
    appBarTheme: AppBarTheme(
      titleSpacing: isOneUi ? 0 : null,
      backgroundColor: getBackgroundColor(colorSchemeGen),
      foregroundColor: colorSchemeGen.onSurface,
      titleTextStyle: isOneUi
          ? TextStyle(
              color: colorSchemeGen.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            )
          : (!kIsWeb && Platform.isAndroid)
              ? TextStyle(
                  fontSize: 20,
                  color: colorSchemeGen.onSurface,
                )
              : null,
    ),
    inputDecorationTheme: const InputDecorationTheme(filled: true),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (context) {
        if (kIsWeb) {
          return const Icon(FluentIcons.arrow_left_48_regular);
        }
        if (Platform.isWindows) {
          return const Icon(FluentIcons.arrow_left_48_regular);
        } else if (isOneUi) {
          return const Icon(
            FluentIcons.chevron_left_16_regular,
            size: 27,
          );
        } else if (Platform.isMacOS || Platform.isIOS) {
          return const Icon(Icons.arrow_back_ios_new_rounded);
        }
        return const Icon(Icons.arrow_back);
      },
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colorSchemeGen.surfaceContainer,
      clipBehavior: Clip.antiAlias,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: isOledBlack ? colorSchemeGen.surfaceContainer : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
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
