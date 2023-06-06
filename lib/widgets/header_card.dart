import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget {
  final Widget child;
  final Color? color;

  /// Applies radius to top left and top right corners, default is 8
  final double? radius;

  /// Default margin is `EdgeInsets.only(left: 0.5, right: 0.5, top: 0, bottom: 3,)`
  final EdgeInsetsGeometry? margin;

  const HeaderCard({
    super.key,
    required this.child,
    this.color,
    this.radius,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
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
      color: color,
      child: SizedBox(
        width: double.infinity,
        child: child,
      ),
    );
  }
}
