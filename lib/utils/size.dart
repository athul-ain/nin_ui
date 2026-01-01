import 'package:flutter/widgets.dart';

bool isSmallScreen(BuildContext context) {
  return MediaQuery.sizeOf(context).width < 500;
}

bool isLargeScreen(BuildContext context) {
  return MediaQuery.sizeOf(context).width > 938;
}

extension BuildContextExtension on BuildContext {
  bool get isSmallWidth => MediaQuery.sizeOf(this).width < 500;
  bool get isLargeWidth => MediaQuery.sizeOf(this).width > 938;
}
