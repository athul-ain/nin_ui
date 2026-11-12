import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:nin_ui/utils/brand.dart';
import 'color.dart';
import 'motion.dart';

class NinUiTheme {
  static ThemeData create({
    required Color primaryColor,
    required Brightness brightness,
    ColorScheme? colorScheme,
  }) {
    final ColorScheme colorSchemeGen = (colorScheme ??
            ColorScheme.fromSeed(
                seedColor: primaryColor, brightness: brightness))
        .copyWith(
            surface: BrandDetector.isOneUi
                ? brightness == Brightness.dark
                    ? OneUiColors.bgDark
                    : OneUiColors.bgLight
                : null);

    final Color contentColor = getContentColor(colorSchemeGen);
    final Color backgroundColor = getBackgroundColor(colorSchemeGen);

    return ThemeData(
      visualDensity: VisualDensity.standard,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      colorScheme: colorSchemeGen,
      useMaterial3: true,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          TargetPlatform.iOS: M3SharedAxisPageTransitionsBuilder(),
          TargetPlatform.windows: M3SharedAxisPageTransitionsBuilder(),
          TargetPlatform.macOS: M3SharedAxisPageTransitionsBuilder(),
          TargetPlatform.linux: M3SharedAxisPageTransitionsBuilder(),
        },
      ),
      searchBarTheme: _searchBarTheme(contentColor),
      cardTheme: _cardTheme(),
      appBarTheme: _appBarTheme(
        backgroundColor: backgroundColor,
        colorScheme: colorSchemeGen,
      ),
      navigationDrawerTheme: NavigationDrawerThemeData(
        backgroundColor: BrandDetector.isOneUi
            ? brightness == Brightness.dark
                ? OneUiColors.bgDark
                : OneUiColors.bgLight
            : null,
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
      actionIconTheme: _actionIconTheme(),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorSchemeGen.surfaceContainer,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        showDragHandle: false,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: BrandDetector.isOneUi
            ? brightness == Brightness.dark
                ? OneUiColors.dialogBgDark
                : OneUiColors.dialogBgLight
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BrandDetector.isOneUi ? 15 : 28),
        ),
        elevation: 6,
      ),
      popupMenuTheme: BrandDetector.isOneUi
          ? PopupMenuThemeData(
              elevation: .8,
              shadowColor: colorSchemeGen.surface,
              color: brightness == Brightness.dark
                  ? OneUiColors.dialogBgDark
                  : OneUiColors.dialogBgLight,
              menuPadding:
                  const EdgeInsets.only(left: 13, right: 5, bottom: 5, top: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              labelTextStyle: WidgetStatePropertyAll(
                TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: colorSchemeGen.onSurface,
                ),
              ),
            )
          : null,
      tooltipTheme: BrandDetector.isOneUi
          ? TooltipThemeData(
              textStyle: TextStyle(
                color: colorSchemeGen.onSurface,
                fontSize: 16,
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: brightness == Brightness.dark
                    ? OneUiColors.dialogBgDark
                    : OneUiColors.dialogBgLight,
              ),
            )
          : null,
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
    required Color backgroundColor,
    required ColorScheme colorScheme,
  }) {
    final isOneUi = BrandDetector.isOneUi;
    return AppBarTheme(
      titleSpacing: isOneUi ? 0 : null,
      backgroundColor: backgroundColor,
      surfaceTintColor: backgroundColor,
      foregroundColor: colorScheme.onSurface,
      titleTextStyle: (isOneUi || (!kIsWeb && Platform.isAndroid))
          ? TextStyle(
              color: colorScheme.onSurface,
              fontSize: 20,
              fontWeight: isOneUi ? FontWeight.w600 : null,
            )
          : null,
      actionsPadding: const EdgeInsets.only(right: 5),
    );
  }

  static ActionIconThemeData _actionIconTheme() {
    return ActionIconThemeData(
      backButtonIconBuilder: (context) {
        if (kIsWeb || Platform.isWindows) {
          return const Icon(Icons.arrow_back);
        }
        if (BrandDetector.isOneUi) {
          return const Icon(
            Icons.chevron_left_rounded,
            size: 28,
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
