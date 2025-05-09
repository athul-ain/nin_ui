import 'dart:ui';
import 'package:flutter/material.dart';

class SheetDialogCard extends StatelessWidget {
  const SheetDialogCard({
    super.key,
    this.child,
    this.borderRadius = 30,
    this.backgroundColor,
  });
  final Widget? child;
  final double borderRadius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final devicePadding = MediaQuery.paddingOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final genColor = colorScheme.brightness == Brightness.dark
        ? colorScheme.surfaceContainer.withAlpha(233)
        : colorScheme.surfaceContainer.withAlpha(218);
   
    return Container(
      margin: EdgeInsets.only(
        bottom: devicePadding.bottom + 16,
        left: 16,
        right: 16,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? genColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: child,
        ),
      ),
    );
  }
}
