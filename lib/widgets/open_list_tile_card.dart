import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:nin_ui/nin_ui.dart';

import '../utils/color.dart';

class OpenListTileCard extends StatefulWidget {
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
  State<OpenListTileCard> createState() => _OpenListTileCardState();
}

class _OpenListTileCardState extends State<OpenListTileCard> {
  double _scale = 1.0;
  void _onTapDown(TapDownDetails details) {
    setState(() => _scale = 0.988);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _scale = 1.0);
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final cardColor = widget.color ?? getContentColor(colorScheme);
    final bgColor = getBackgroundColor(colorScheme);

    return Padding(
      padding: widget.margin,
      child: OpenContainer(
        closedColor: cardColor,
        closedElevation: 0,
        openColor: bgColor,
        openElevation: 0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.closedBorderRadius),
        ),
        clipBehavior: Clip.antiAlias,
        closedBuilder: (context, openContainer) {
          return ContentCard(
            color: cardColor,
            margin: EdgeInsets.zero,
            onTap: () {},
            child: GestureDetector(
              onTapDown: _onTapDown,
              onTapUp: _onTapUp,
              onTapCancel: _onTapCancel,
              onTap: openContainer,
              child: AnimatedScale(
                scale: _scale,
                duration: Durations.short3,
                child: ListTile(
                  iconColor: widget.iconColor,
                  textColor: widget.textColor,
                  leading: widget.leading,
                  title: widget.title,
                  subtitle: widget.subtitle,
                  trailing: widget.trailing,
                  onLongPress: widget.onLongPress,
                  contentPadding: widget.contentPadding ??
                      const EdgeInsets.only(right: 8, left: 15),
                  horizontalTitleGap: widget.horizontalTitleGap ?? 15,
                ),
              ),
            ),
          );
        },
        openBuilder: (context, closeContainer) {
          return widget.openPage;
        },
      ),
    );
  }
}
