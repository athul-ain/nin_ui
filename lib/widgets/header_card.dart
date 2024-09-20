import 'package:flutter/material.dart';
import 'package:nin_ui/utils/color.dart';

class HeaderCard extends StatelessWidget {
  final Widget child;
  final Color? color;

  /// Applies radius to top left and top right corners, default is 8
  final double? radius;

  /// Default margin is `EdgeInsets.only(left: 0.5, right: 0.5, top: 0, bottom: 3,)`
  final EdgeInsetsGeometry? margin;

  /// Default padding is `EdgeInsets.zero`
  final EdgeInsetsGeometry padding;

  const HeaderCard({
    super.key,
    required this.child,
    this.color,
    this.radius,
    this.margin,
    this.padding = const EdgeInsets.only(),
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? getContentColor(Theme.of(context).colorScheme);
    return Card(
      margin: margin ??
          const EdgeInsets.only(
            left: 0.5,
            right: 0.5,
            top: 0,
            bottom: 3,
          ),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius ?? 13),
          topRight: Radius.circular(radius ?? 13),
          bottomLeft: const Radius.circular(3),
          bottomRight: const Radius.circular(3),
        ),
      ),
      color: cardColor,
      child: Padding(
        padding: padding,
        child: SizedBox(width: double.infinity, child: child),
      ),
    );
  }
}
