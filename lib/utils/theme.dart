import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nin_ui/utils/brand.dart';
import 'color.dart';

class NinUiTheme {
  static ThemeData create({
    required Color primaryColor,
    required Brightness brightness,
    ColorScheme? colorScheme,
    bool? isOneUi,
  }) {
    final isOneUiDetected = isOneUi ?? BrandDetector().isOneUi;
    final bool isOledBlack = isOneUiDetected && brightness == Brightness.dark;

    final ColorScheme colorSchemeGen = (colorScheme ??
            ColorScheme.fromSeed(
                seedColor: primaryColor, brightness: brightness))
        .copyWith(surface: isOledBlack ? Colors.black : null);

    final Color contentColor = getContentColor(colorSchemeGen);
    final Color backgroundColor = getBackgroundColor(colorSchemeGen);

    return ThemeData(
      visualDensity: VisualDensity.standard,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      colorScheme: colorSchemeGen,
      useMaterial3: true,
      searchBarTheme: _searchBarTheme(contentColor),
      cardTheme: _cardTheme(),
      appBarTheme: _appBarTheme(
        isOneUi: isOneUiDetected,
        backgroundColor: backgroundColor,
        colorScheme: colorSchemeGen,
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
      actionIconTheme: _actionIconTheme(isOneUiDetected),
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

  static SearchBarThemeData _searchBarTheme(Color contentColor) {
    return SearchBarThemeData(
      backgroundColor: WidgetStatePropertyAll(contentColor),
      elevation: const WidgetStatePropertyAll(0),
      constraints: const BoxConstraints(
        maxHeight: 53,
        minHeight: 53,
      ),
    );
  }

  static CardThemeData _cardTheme() {
    return CardThemeData(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }

  static AppBarTheme _appBarTheme({
    required bool isOneUi,
    required Color backgroundColor,
    required ColorScheme colorScheme,
  }) {
    return AppBarTheme(
      titleSpacing: isOneUi ? 0 : null,
      backgroundColor: backgroundColor,
      surfaceTintColor: backgroundColor,
      foregroundColor: colorScheme.onSurface,
      titleTextStyle: isOneUi
          ? TextStyle(
              color: colorScheme.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            )
          : (!kIsWeb && Platform.isAndroid)
              ? TextStyle(
                  fontSize: 20,
                  color: colorScheme.onSurface,
                )
              : null,
      actionsPadding: const EdgeInsets.only(right: 5),
    );
  }

  static ActionIconThemeData _actionIconTheme(bool isOneUi) {
    return ActionIconThemeData(
      backButtonIconBuilder: (context) {
        if (kIsWeb || Platform.isWindows) {
          return const Icon(FluentIcons.arrow_left_48_regular);
        }
        if (isOneUi) {
          return const Icon(
            FluentIcons.chevron_left_16_regular,
            size: 27,
          );
        }
        if (Platform.isMacOS || Platform.isIOS) {
          return const Icon(Icons.arrow_back_ios_new_rounded);
        }
        return const Icon(Icons.arrow_back);
      },
    );
  }
}
