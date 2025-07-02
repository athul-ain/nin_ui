import 'package:flutter/material.dart';

import 'bottomsheet_appbar.dart';

class BottomsheetWrapper extends StatelessWidget {
  const BottomsheetWrapper({
    super.key,
    this.onChanged,
    this.clearIconButton,
    required this.title,
    this.searchController,
    required this.children,
    this.hideSearchBar = false,
    this.actions,
    this.hintText = 'Search',
    this.autoFocus = false,
  });

  /// Invoked upon user input.
  final ValueChanged<String>? onChanged;

  /// clear icon button
  final IconButton? clearIconButton;

  /// title
  final String title;

  /// search controller
  final TextEditingController? searchController;

  /// children
  final List<Widget> children;

  /// hide search bar
  final bool hideSearchBar;

  final List<Widget>? actions;

  final String hintText;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    final bottomSheetTheme = Theme.of(context).bottomSheetTheme;

    final viewInsets = MediaQuery.viewInsetsOf(context);
    final safePadding = MediaQuery.paddingOf(context);
    final bottomPadding = safePadding.bottom + viewInsets.bottom;

    var listPadding = EdgeInsets.only(
      top: 73,
      left: 8,
      right: 8,
      bottom: bottomPadding + (hideSearchBar ? 8 : 70),
    );
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        if (children.length < 30)
          SingleChildScrollView(
            padding: listPadding,
            child: Column(children: children),
          )
        else
          ListView.builder(
            padding: listPadding,
            itemCount: children.length,
            itemBuilder: (_, index) {
              return children[index];
            },
          ),
        BottomSheetAppBar(title: title, actions: actions),
        if (!hideSearchBar)
          Container(
            width: double.infinity,
            height: bottomPadding + 34,
            decoration: BoxDecoration(
              color: bottomSheetTheme.backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: bottomSheetTheme.backgroundColor ??
                      Colors.black.withAlpha(180),
                  blurRadius: 18,
                  offset: const Offset(0, -18),
                ),
              ],
            ),
          ),
        if (!hideSearchBar)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8).copyWith(
              top: 0,
              bottom: bottomPadding + 8,
            ),
            child: SearchBar(
              autoFocus: children.length > 20 || autoFocus,
              controller: searchController,
              shadowColor:
                  WidgetStatePropertyAll(bottomSheetTheme.backgroundColor),
              elevation: WidgetStatePropertyAll(1.8),
              leading: const Icon(Icons.search_rounded),
              hintText: hintText,
              onChanged: onChanged,
              trailing: [
                if (clearIconButton != null) clearIconButton!,
              ],
            ),
          ),
      ],
    );
  }
}
