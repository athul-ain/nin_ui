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
