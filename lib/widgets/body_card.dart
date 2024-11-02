import 'package:flutter/material.dart';

import '../utils/color.dart';

class BodyCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? margin;

  /// disableBottomMargin is not considered when margin is set to provide.
  final bool? disableBottomMargin;
  const BodyCard({
    super.key,
    required this.child,
    this.color,
    this.disableBottomMargin,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bgColor = getBackgroundColor(colorScheme);
    final size = MediaQuery.sizeOf(context);
    final safePadding = MediaQuery.paddingOf(context);

    bool isLargeScreen = size.width > 700;

    return AnimatedPadding(
      padding: margin ??
          (isLargeScreen
              ? EdgeInsets.only(
                  bottom: disableBottomMargin == true
                      ? 0
                      : (safePadding.bottom + 8),
                  left: safePadding.left + 18,
                  right: safePadding.right + 18,
                )
              : EdgeInsets.only(
                  bottom: disableBottomMargin == true
                      ? 0
                      : (safePadding.bottom + 3),
                  left: safePadding.left + 5,
                  right: safePadding.right + 5,
                )),
      duration: const Duration(milliseconds: 333),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        margin: const EdgeInsets.all(0),
        color: color ?? bgColor,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(18),
        // ),
        child: child,
      ),
    );
  }
}
