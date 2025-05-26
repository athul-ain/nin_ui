import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color getBackgroundColor(ColorScheme colorScheme) {
  final bgColor = colorScheme.surface == Colors.black
      ? Colors.black
      : ElevationOverlay.colorWithOverlay(
          colorScheme.surfaceContainerLowest,
          colorScheme.onSurface,
          1,
        );

  return bgColor;
}

Color getContentColor(ColorScheme colorScheme) {
  final oledBgColor = ElevationOverlay.colorWithOverlay(
    colorScheme.surface,
    colorScheme.onSurface,
    3.8,
  );

  final contentColor = colorScheme.surface == Colors.black
      ? oledBgColor
      : colorScheme.surfaceContainerLowest;

  return contentColor;
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
