import 'package:flutter/material.dart';

class BottomSheetAppBar extends StatelessWidget {
  const BottomSheetAppBar({
    super.key,
    required this.title,
    this.actions,
    this.backgroundColor,
    this.automaticallyImplyLeading = true,
  });

  final String title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final bottomSheetTheme = Theme.of(context).bottomSheetTheme;
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            color: backgroundColor ?? bottomSheetTheme.backgroundColor,
            padding: const EdgeInsets.only(top: 11),
            child: Center(
              child: Container(
                height: 3,
                width: 35,
                decoration: BoxDecoration(
                  color: bottomSheetTheme.dragHandleColor ??
                      colorScheme.onSurfaceVariant,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ),
          ),
          AppBar(
            toolbarHeight: 50,
            centerTitle: true,
            automaticallyImplyLeading: automaticallyImplyLeading,
            title: Text(
              title,
              style: textTheme.titleMedium,
            ),
            backgroundColor:
                backgroundColor ?? bottomSheetTheme.backgroundColor,
            actions: actions != null ? [...?actions, SizedBox(width: 5)] : null,
          ),
        ],
      ),
    );
  }
}
