import 'package:flutter/material.dart';
import 'package:nin_ui/utils/color.dart';

class ContentCard extends StatelessWidget {
  final Widget child;
  final Color? color;

  /// Default margin is `EdgeInsets.only(left: 0.5, right: 0.5, top: 0, bottom: 3,)`
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final void Function()? onTap;
  final BorderRadiusGeometry? borderRadius;
  final bool animated;

  const ContentCard({
    super.key,
    required this.child,
    this.color,
    this.margin =
        const EdgeInsets.only(left: 0.5, right: 0.5, top: 0, bottom: 5),
    this.padding = const EdgeInsets.all(0),
    this.onTap,
    this.borderRadius,
    this.animated = false,
  });

  const ContentCard.animated({
    super.key,
    required this.child,
    this.color,
    this.margin =
        const EdgeInsets.only(left: 0.5, right: 0.5, top: 0, bottom: 5),
    this.padding = const EdgeInsets.all(0),
    this.onTap,
    this.borderRadius,
  }) : animated = true;

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? getContentColor(Theme.of(context).colorScheme);
    final cardTheme = Theme.of(context).cardTheme;

    if (animated) {
      return AnimatedContainer(
        duration: Durations.medium3,
        margin: margin,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: borderRadius ??
              (cardTheme.shape is RoundedRectangleBorder
                  ? (cardTheme.shape as RoundedRectangleBorder).borderRadius
                  : BorderRadius.circular(13)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      );
    }

    return Card(
      margin: margin,
      shape: borderRadius == null
          ? cardTheme.shape
          : RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(13),
            ),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: cardColor,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
