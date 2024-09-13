import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:nin_ui/nin_ui.dart';

import '../utils/color.dart';

class OpenListTileCard extends StatelessWidget {
  final Widget? title;
  final Widget? leading;
  final Widget? subtitle;
  final Widget? trailing;
  final Color? color;
  final Color? iconColor;
  final Color? textColor;

  /// Called when the user long-presses on this list tile.
  ///
  /// Inoperative if [enabled] is false.
  final GestureLongPressCallback? onLongPress;

  /// The tile's internal padding.
  ///
  /// Insets a [ListTile]'s contents: its [leading], [title], [subtitle],
  /// and [trailing] widgets.
  ///
  /// If null, `const EdgeInsets.only(right: 8, left: 15)` is used.
  final EdgeInsetsGeometry? contentPadding;

  final double? horizontalTitleGap;

  final Widget openPage;
  final double closedBorderRadius;
  final EdgeInsetsGeometry margin;

  const OpenListTileCard({
    super.key,
    this.title,
    this.leading,
    this.subtitle,
    this.trailing,
    this.onLongPress,
    this.contentPadding,
    this.horizontalTitleGap,
    this.color,
    this.iconColor,
    this.textColor,
    required this.openPage,
    this.closedBorderRadius = 13,
    this.margin =
        const EdgeInsets.only(left: 0.5, right: 0.5, top: 0, bottom: 5),
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cardColor = color ?? getContentColor(colorScheme);
    final bgColor = getBackgroundColor(colorScheme);

    return Padding(
      padding: margin,
      child: OpenContainer(
        closedColor: cardColor,
        closedElevation: 0,
        openColor: bgColor,
        openElevation: 0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(closedBorderRadius),
        ),
        clipBehavior: Clip.antiAlias,
        closedBuilder: (context, openContainer) {
          return ContentCard(
            color: cardColor,
            margin: EdgeInsets.zero,
            child: ListTile(
              iconColor: iconColor,
              textColor: textColor,
              leading: leading,
              title: title,
              subtitle: subtitle,
              trailing: trailing,
              onTap: openContainer,
              onLongPress: onLongPress,
              contentPadding:
                  contentPadding ?? const EdgeInsets.only(right: 8, left: 15),
              horizontalTitleGap: horizontalTitleGap ?? 15,
            ),
          );
        },
        openBuilder: (context, closeContainer) {
          return openPage;
        },
      ),
    );
  }
}
