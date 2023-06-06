import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  final Widget child;
  final Color? color;

  /// Default margin is `EdgeInsets.only(left: 0.5, right: 0.5, top: 0, bottom: 3,)`
  final EdgeInsetsGeometry? margin;

  const ContentCard({super.key, required this.child, this.color, this.margin});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ??
          const EdgeInsets.only(
            left: 0.5,
            right: 0.5,
            top: 0,
            bottom: 5,
          ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: color,
      child: child,
    );
  }
}
