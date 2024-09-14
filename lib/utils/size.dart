import 'package:flutter/widgets.dart';

bool isSmallScreen(BuildContext context) {
  return MediaQuery.sizeOf(context).width < 500;
}

bool isLargeScreen(BuildContext context) {
  return MediaQuery.sizeOf(context).width > 938;
}
