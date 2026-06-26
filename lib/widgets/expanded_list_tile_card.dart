import 'package:flutter/material.dart';
import 'content_card.dart';
import 'list_tile_card.dart';
import 'dart:developer';

class ExpandedListTileCard extends StatefulWidget {
  const ExpandedListTileCard({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.children,
    this.contentPadding,
    this.topContentPadding,
    this.automaticallyImplyTrailing,
    this.topHorizontalTitleGap,
    this.color,
    this.isExpanded,
    this.position = TileListPosition.single,
    this.borderRadius,
    this.margin,
  });
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final List<Widget>? children;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? topContentPadding;
  final double? topHorizontalTitleGap;
  final bool? automaticallyImplyTrailing;
  final Color? color;
  final bool? isExpanded;
  final TileListPosition? position;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;

  @override
  State<ExpandedListTileCard> createState() => _ExpandedListTileCardState();
}

class _ExpandedListTileCardState extends State<ExpandedListTileCard> {
  late bool isInsightsWidgetExpanded;

  @override
  void initState() {
    super.initState();
    isInsightsWidgetExpanded = widget.isExpanded ?? false;
  }

  @override
  void didUpdateWidget(covariant ExpandedListTileCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded && widget.isExpanded != null) {
      setState(() {
        isInsightsWidgetExpanded = widget.isExpanded!;
      });
    }
  }

  BorderRadiusGeometry? _getBorderRadius() {
    if (isInsightsWidgetExpanded) {
      return widget.borderRadius;
    } else {
      return (widget.position ?? TileListPosition.single)
          .getBorderRadius(customBorderRadius: widget.borderRadius);
    }
  }

  EdgeInsetsGeometry _getMargin() {
    if (isInsightsWidgetExpanded) {
      return widget.margin ??
          const EdgeInsets.only(left: 0.5, right: 0.5, top: 0, bottom: 5);
    } else {
      return (widget.position ?? TileListPosition.single)
          .getMargin(customMargin: widget.margin);
    }
  }

  @override
  Widget build(BuildContext context) {
    log(isInsightsWidgetExpanded.toString());
    return ContentCard(
      color: widget.color,
      borderRadius: _getBorderRadius(),
      margin: _getMargin(),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 188),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            // Title Widget
            ListTile(
              onTap: () {
                setState(
                    () => isInsightsWidgetExpanded = !isInsightsWidgetExpanded);
              },
              leading: widget.leading,
              title: widget.title,
              subtitle: widget.subtitle,
              trailing: widget.automaticallyImplyTrailing == false
                  ? null
                  : widget.trailing ??
                      AnimatedRotation(
                        duration: const Duration(milliseconds: 188),
                        turns: isInsightsWidgetExpanded ? 0.5 : 0,
                        child: const Icon(Icons.expand_more_rounded),
                      ),
              contentPadding: widget.topContentPadding ??
                  const EdgeInsets.only(right: 8, left: 15),
              horizontalTitleGap: widget.topHorizontalTitleGap ?? 15,
            ),

            // Content Widget
            if (isInsightsWidgetExpanded)
              Padding(
                padding: widget.contentPadding ?? const EdgeInsets.all(3),
                child: Column(
                  children: widget.children ?? [],
                ),
              )
          ],
        ),
      ),
    );
  }
}
