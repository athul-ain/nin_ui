import 'package:flutter/material.dart';
import 'package:nin_ui/utils/color.dart';

class ContentCard extends StatelessWidget {
  final Widget child;
  final Color? color;

  /// Default margin is `EdgeInsets.only(left: 0.5, right: 0.5, top: 0, bottom: 3,)`
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final void Function()? onTap;
  final double? borderRadius;

  const ContentCard({
    super.key,
    required this.child,
    this.color,
    this.margin =
        const EdgeInsets.only(left: 0.5, right: 0.5, top: 0, bottom: 5),
    this.padding = const EdgeInsets.all(0),
    this.onTap,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? getContentColor(Theme.of(context).colorScheme);
    return Card(
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 13),
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
