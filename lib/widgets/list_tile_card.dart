import 'package:flutter/material.dart';
import 'package:nin_ui/nin_ui.dart';

enum TileListPosition {
  top,
  middle,
  bottom,
  single,
}

class ListTileCard extends StatefulWidget {
  final Widget? title;
  final Widget? leading;
  final Widget? subtitle;
  final Widget? trailing;
  final Color? color;
  final Color? iconColor;
  final Color? textColor;
  final TileListPosition? position;

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
  final bool dense;
  final BorderRadiusGeometry? borderRadius;

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
    this.iconColor,
    this.textColor,
    this.dense = false,
    this.borderRadius,
    this.position = TileListPosition.single,
  });

  @override
  State<ListTileCard> createState() => _ListTileCardState();
}

class _ListTileCardState extends State<ListTileCard> {
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
    return ContentCard(
      color: widget.color,
      onTap: widget.onTap == null ? null : () {},
      borderRadius: widget.borderRadius ??
          (widget.position == TileListPosition.single
              ? BorderRadius.circular(13)
              : widget.position == TileListPosition.top
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(13),
                      topRight: Radius.circular(13),
                      bottomLeft: Radius.circular(3),
                      bottomRight: Radius.circular(3),
                    )
                  : widget.position == TileListPosition.bottom
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(13),
                          bottomRight: Radius.circular(13),
                          topLeft: Radius.circular(3),
                          topRight: Radius.circular(3),
                        )
                      : const BorderRadius.only(
                          bottomLeft: Radius.circular(3),
                          bottomRight: Radius.circular(3),
                          topLeft: Radius.circular(3),
                          topRight: Radius.circular(3),
                        )),
      margin: EdgeInsets.only(
          left: 0.5,
          right: 0.5,
          top: 0,
          bottom: [TileListPosition.middle, TileListPosition.top]
                  .contains(widget.position)
              ? 3
              : 5),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _scale,
          duration: Durations.short3,
          child: ListTile(
            dense: widget.dense,
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
  }
}
