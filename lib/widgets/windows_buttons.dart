import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        MinimizeWindowButton(
          colors: WindowButtonColors(
            iconNormal: colorScheme.onSurface,
            mouseOver: colorScheme.surfaceContainer,
            mouseDown: colorScheme.surfaceBright,
            iconMouseOver: colorScheme.onSurface,
            iconMouseDown: colorScheme.onPrimaryContainer,
          ),
        ),
        MaximizeWindowButton(
          colors: WindowButtonColors(
            iconNormal: colorScheme.onSurface,
            mouseOver: colorScheme.surfaceContainer,
            mouseDown: colorScheme.surfaceBright,
            iconMouseOver: colorScheme.onSurface,
            iconMouseDown: colorScheme.onPrimaryContainer,
          ),
        ),
        CloseWindowButton(
          colors: WindowButtonColors(
            mouseOver: const Color(0xFFD32F2F),
            mouseDown: const Color(0xFFB71C1C),
            iconNormal: colorScheme.onSurface,
            iconMouseOver: Colors.white,
          ),
        ),
      ],
    );
  }
}
