import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nin_ui/utils/brand.dart';

Color getBackgroundColor(ColorScheme colorScheme) {
  final isOneUi = BrandDetector.isOneUi;
  if (isOneUi) {
    if (colorScheme.brightness == Brightness.dark) {
      return OneUiColors.bgDark;
    } else {
      return OneUiColors.bgLight;
    }
  } else {
    return ElevationOverlay.colorWithOverlay(
      colorScheme.surfaceContainerLowest,
      colorScheme.onSurface,
      1,
    );
  }
}

Color getContentColor(ColorScheme colorScheme) {
  final isOneUi = BrandDetector.isOneUi;
  if (isOneUi) {
    if (colorScheme.brightness == Brightness.dark) {
      return OneUiColors.cardDark;
    } else {
      return OneUiColors.cardLight;
    }
  } else {
    return colorScheme.surfaceContainerLowest;
  }
}

Color getCupertinoSheetBackgroundColor(BuildContext context) {
  final bgColor = CupertinoDynamicColor.resolve(
    CupertinoDynamicColor.withBrightness(
      color: Color(0xCCF2F2F2),
      darkColor: Color(0xCC2D2D2D),
    ),
    context,
  );
  return bgColor;
}

Color getCupertinoBarrierColor(BuildContext context) {
  final barrierColor =
      CupertinoDynamicColor.resolve(kCupertinoModalBarrierColor, context);
  return barrierColor;
}

class OneUiColors {
  static const Color bgDark = Color(0xFF000000);
  static const Color bgLight = Color(0xFFF1F1F3);

  static const Color dialogBgLight = Color.fromARGB(255, 253, 253, 253);
  static const Color dialogBgDark = Color.fromARGB(255, 38, 38, 38);

  static const Color cardDark = Color(0xFF171719);
  static const Color cardLight = Color(0xFFFCFCFE);
}
