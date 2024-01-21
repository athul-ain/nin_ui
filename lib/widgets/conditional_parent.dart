import 'package:flutter/material.dart';

class ConditionalParentWidget extends StatelessWidget {
  final Widget child;

  /// builder is called only when enableParent is true.
  final Widget Function(Widget child) builder;
  final bool enableParent;

  const ConditionalParentWidget({
    super.key,
    required this.child,
    required this.builder,
    this.enableParent = false,
  });

  @override
  Widget build(BuildContext context) {
    return enableParent ? builder(child) : child;
  }
}
