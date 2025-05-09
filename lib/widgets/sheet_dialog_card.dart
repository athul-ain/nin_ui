import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nin_ui/utils/color.dart';

class SheetDialogCard extends StatelessWidget {
  const SheetDialogCard({
    super.key,
    this.child,
    this.borderRadius = 30,
  });
  final Widget? child;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final devicePadding = MediaQuery.paddingOf(context);
    final cardColor = getContentColor(Theme.of(context).colorScheme);
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
            color: cardColor.withAlpha(118),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: child,
        ),
      ),
    );
  }
}
