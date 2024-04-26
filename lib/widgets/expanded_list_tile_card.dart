import 'package:flutter/material.dart';
import 'content_card.dart';
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

  @override
  State<ExpandedListTileCard> createState() => _ExpandedListTileCardState();
}

class _ExpandedListTileCardState extends State<ExpandedListTileCard> {
  bool isInsightsWidgetExpanded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isInsightsWidgetExpanded = widget.isExpanded ?? false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    log(isInsightsWidgetExpanded.toString());
    return ContentCard(
      color: widget.color,
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
