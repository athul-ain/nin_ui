import 'package:flutter/material.dart';

import 'content_card.dart';

class ExpandedListTileCard extends StatefulWidget {
  const ExpandedListTileCard({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.children,
    this.contentPadding,
    this.automaticallyImplyTrailing,
  });
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final List<Widget>? children;
  final EdgeInsetsGeometry? contentPadding;
  final bool? automaticallyImplyTrailing;

  @override
  State<ExpandedListTileCard> createState() => _ExpandedListTileCardState();
}

class _ExpandedListTileCardState extends State<ExpandedListTileCard> {
  bool isInsightsWidgetExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ContentCard(
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
