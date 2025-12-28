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
  final bool isOledBlack = isOneUi && Brightness.dark == brightness;

  final ColorScheme colorSchemeGen = (colorScheme ??
          ColorScheme.fromSeed(seedColor: primaryColor, brightness: brightness))
      .copyWith(surface: isOledBlack ? Colors.black : null);

  final Color contentColor = getContentColor(colorSchemeGen);
  final Color backgroundColor = getBackgroundColor(colorSchemeGen);

  return ThemeData(
    visualDensity: VisualDensity.standard,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    colorScheme: colorSchemeGen,
    useMaterial3: true,
    // pageTransitionsTheme: const PageTransitionsTheme(
    //   builders: {
    //     TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
    //   },
    // ),
    searchBarTheme: SearchBarThemeData(
      backgroundColor: WidgetStatePropertyAll(contentColor),
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
      backgroundColor: backgroundColor,
      surfaceTintColor: backgroundColor,
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
      actionsPadding: EdgeInsets.only(right: 5),
    ),
    navigationDrawerTheme: NavigationDrawerThemeData(
      backgroundColor: isOledBlack ? Colors.black : null,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: contentColor,
    ),
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
