import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  final Widget child;
  final Color? color;

  /// Default margin is `EdgeInsets.only(left: 0.5, right: 0.5, top: 0, bottom: 3,)`
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;

  const ContentCard(
      {super.key,
      required this.child,
      this.color,
      this.margin,
      this.padding,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final oledBgColor = ElevationOverlay.colorWithOverlay(
      theme.colorScheme.surface,
      theme.colorScheme.onSurface,
      3.8,
    );
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
      color: color ??
          (theme.colorScheme.surface == Colors.black ? oledBgColor : null),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(0),
          child: child,
        ),
      ),
    );
  }
}
