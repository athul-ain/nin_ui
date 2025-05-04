import 'package:flutter/material.dart';
import '../utils/color.dart';

class BodyCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? margin;
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

    final isLargeScreen = size.width > 700;
    final double bottomPadding = disableBottomMargin == true
        ? 0
        : (safePadding.bottom + (isLargeScreen ? 8 : 3));
    final horizontalPadding = isLargeScreen ? 18 : 5;

    return AnimatedPadding(
      padding: margin ??
          EdgeInsets.only(
            bottom: bottomPadding,
            left: safePadding.left + horizontalPadding,
            right: safePadding.right + horizontalPadding,
          ),
      duration: Durations.medium1,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        margin: EdgeInsets.zero,
        color: color ?? bgColor,
        child: child,
      ),
    );
  }
}
