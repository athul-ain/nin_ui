import 'package:flutter/material.dart';
import 'package:nin_ui/nin_ui.dart';

enum TileListPosition {
  /// To be used as ColumnTiles
  top,
  middle,
  bottom,
  single,

  /// To be used as GridTiles
  topLeft,
  topRight,
  topMiddle,
  bottomLeft,
  bottomRight,
  bottomMiddle,
  middleLeft,
  middleRight,
  middleCenter,

  /// Tobe used as a rowTiles
  singleLeft,
  singleRight,
  singleCenter,
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
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final EdgeInsetsGeometry? contentPadding;
  final double? horizontalTitleGap;
  final bool dense;
  final BorderRadiusGeometry? borderRadius;
  final double? minTileHeight;
  final EdgeInsetsGeometry? margin;

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
    this.minTileHeight,
    this.margin,
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

  BorderRadiusGeometry _getBorderRadius() {
    if (widget.borderRadius != null) return widget.borderRadius!;
    switch (widget.position) {
      case TileListPosition.single:
        return const BorderRadius.all(Radius.circular(13));
      case TileListPosition.middle:
        return const BorderRadius.all(Radius.circular(3));
      case TileListPosition.top:
        return const BorderRadius.only(
          topLeft: Radius.circular(13),
          topRight: Radius.circular(13),
          bottomLeft: Radius.circular(3),
          bottomRight: Radius.circular(3),
        );
      case TileListPosition.bottom:
        return const BorderRadius.only(
          bottomLeft: Radius.circular(13),
          bottomRight: Radius.circular(13),
          topLeft: Radius.circular(3),
          topRight: Radius.circular(3),
        );
      case TileListPosition.topLeft:
        return const BorderRadius.only(
          topLeft: Radius.circular(13),
          topRight: Radius.circular(3),
          bottomLeft: Radius.circular(3),
          bottomRight: Radius.circular(3),
        );
      case TileListPosition.topRight:
        return const BorderRadius.only(
          topRight: Radius.circular(13),
          topLeft: Radius.circular(3),
          bottomLeft: Radius.circular(3),
          bottomRight: Radius.circular(3),
        );
      case TileListPosition.topMiddle:
        return const BorderRadius.only(
          topLeft: Radius.circular(3),
          topRight: Radius.circular(3),
          bottomLeft: Radius.circular(3),
          bottomRight: Radius.circular(3),
        );
      case TileListPosition.bottomLeft:
        return const BorderRadius.only(
          bottomLeft: Radius.circular(13),
          bottomRight: Radius.circular(3),
          topLeft: Radius.circular(3),
          topRight: Radius.circular(3),
        );
      case TileListPosition.bottomRight:
        return const BorderRadius.only(
          bottomRight: Radius.circular(13),
          bottomLeft: Radius.circular(3),
          topLeft: Radius.circular(3),
          topRight: Radius.circular(3),
        );
      case TileListPosition.bottomMiddle:
        return const BorderRadius.only(
          bottomLeft: Radius.circular(3),
          bottomRight: Radius.circular(3),
          topLeft: Radius.circular(3),
          topRight: Radius.circular(3),
        );
      case TileListPosition.middleLeft:
        return const BorderRadius.only(
          topLeft: Radius.circular(3),
          bottomLeft: Radius.circular(3),
          topRight: Radius.circular(3),
          bottomRight: Radius.circular(3),
        );
      case TileListPosition.middleRight:
        return const BorderRadius.only(
          topRight: Radius.circular(3),
          bottomRight: Radius.circular(3),
          topLeft: Radius.circular(3),
          bottomLeft: Radius.circular(3),
        );
      case TileListPosition.middleCenter:
        return const BorderRadius.only(
          topLeft: Radius.circular(3),
          topRight: Radius.circular(3),
          bottomLeft: Radius.circular(3),
          bottomRight: Radius.circular(3),
        );
      case TileListPosition.singleLeft:
        return const BorderRadius.only(
          topLeft: Radius.circular(13),
          bottomLeft: Radius.circular(13),
          topRight: Radius.circular(3),
          bottomRight: Radius.circular(3),
        );
      case TileListPosition.singleRight:
        return const BorderRadius.only(
          topRight: Radius.circular(13),
          bottomRight: Radius.circular(13),
          topLeft: Radius.circular(3),
          bottomLeft: Radius.circular(3),
        );
      case TileListPosition.singleCenter:
        return const BorderRadius.only(
          topLeft: Radius.circular(3),
          topRight: Radius.circular(3),
          bottomLeft: Radius.circular(3),
          bottomRight: Radius.circular(3),
        );
      default:
        return BorderRadius.circular(13);
    }
  }

  EdgeInsetsGeometry _getMargin() {
    if (widget.margin != null) return widget.margin!;

    switch (widget.position) {
      case TileListPosition.single:
        return const EdgeInsets.fromLTRB(0.5, 0, 0.5, 5);
      case TileListPosition.middle:
        return const EdgeInsets.fromLTRB(0.5, 3, 0.5, 3);
      case TileListPosition.top:
        return const EdgeInsets.fromLTRB(0.5, 0, 0.5, 3);
      case TileListPosition.bottom:
        return const EdgeInsets.fromLTRB(0.5, 3, 0.5, 5);

      case TileListPosition.topLeft:
        return const EdgeInsets.fromLTRB(0.5, 0, 3, 3);
      case TileListPosition.topRight:
        return const EdgeInsets.fromLTRB(3, 0, 0.5, 3);
      case TileListPosition.topMiddle:
        return const EdgeInsets.fromLTRB(3, 0, 3, 3);
      case TileListPosition.middleLeft:
        return const EdgeInsets.fromLTRB(0.5, 0, 3, 3);
      case TileListPosition.middleRight:
        return const EdgeInsets.fromLTRB(3, 0, 0.5, 3);
      case TileListPosition.middleCenter:
        return const EdgeInsets.fromLTRB(3, 0, 3, 3);
      case TileListPosition.bottomLeft:
        return const EdgeInsets.fromLTRB(0.5, 3, 3, 5);
      case TileListPosition.bottomRight:
        return const EdgeInsets.fromLTRB(3, 3, 0.5, 5);
      case TileListPosition.bottomMiddle:
        return const EdgeInsets.fromLTRB(3, 3, 3, 5);

      case TileListPosition.singleLeft:
        return const EdgeInsets.fromLTRB(0.5, 0, 3, 5);
      case TileListPosition.singleRight:
        return const EdgeInsets.fromLTRB(3, 0, 0.5, 5);
      case TileListPosition.singleCenter:
        return const EdgeInsets.fromLTRB(3, 0, 3, 5);

      default:
        return const EdgeInsets.fromLTRB(0.5, 0, 0.5, 5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ContentCard(
      color: widget.color,
      onTap: widget.onTap == null ? null : () {},
      borderRadius: _getBorderRadius(),
      margin: _getMargin(),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _scale,
          duration: Durations.short3,
          child: ListTile(
            minTileHeight: widget.minTileHeight,
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

extension ListTileCardExtension on ListTileCard {
  Widget form(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.onSurfaceVariant,
            width: 1.0,
          ),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 0.5),
      child: ListTileCard(
        title: title,
        leading: leading,
        subtitle: subtitle,
        trailing: trailing,
        onTap: onTap,
        onLongPress: onLongPress,
        contentPadding: contentPadding,
        horizontalTitleGap: horizontalTitleGap,
        color: colorScheme.surfaceContainerHighest,
        iconColor: iconColor,
        textColor: textColor,
        dense: dense,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
        margin: EdgeInsets.zero,
        position: position,
        minTileHeight: minTileHeight ?? 55,
      ),
    );
  }
}
