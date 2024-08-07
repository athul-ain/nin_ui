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
    final mediaQuery = MediaQuery.of(context);

    bool isLargeScreen = mediaQuery.size.width > 700;

    return AnimatedPadding(
      padding: margin ??
          (isLargeScreen
              ? EdgeInsets.only(
                  bottom: disableBottomMargin == true
                      ? 0
                      : (mediaQuery.padding.bottom + 8),
                  left: mediaQuery.padding.left + 18,
                  right: mediaQuery.padding.right + 18,
                )
              : EdgeInsets.only(
                  bottom: disableBottomMargin == true
                      ? 0
                      : (mediaQuery.padding.bottom + 3),
                  left: mediaQuery.padding.left + 5,
                  right: mediaQuery.padding.right + 5,
                )),
      duration: const Duration(milliseconds: 333),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        margin: const EdgeInsets.all(0),
        color: color ?? bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: child,
      ),
    );
  }
}
