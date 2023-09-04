import 'package:flutter/material.dart';
import 'package:nin_ui/nin_ui.dart';

class ListTileCard extends StatelessWidget {
  final Widget? title;
  final Widget? leading;
  final Widget? subtitle;
  final Widget? trailing;
  final Color? color;

  /// Called when the user taps this list tile.
  ///
  /// Inoperative if [enabled] is false.
  final GestureTapCallback? onTap;

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

  const ListTileCard({
    super.key,
    this.title,
    this.leading,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.contentPadding,
    this.horizontalTitleGap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ContentCard(
      color: color,
      child: ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        onTap: onTap,
        onLongPress: onLongPress,
        contentPadding:
            contentPadding ?? const EdgeInsets.only(right: 8, left: 15),
        horizontalTitleGap: horizontalTitleGap ?? 15,
      ),
    );
  }
}
