import 'package:flutter/widgets.dart';

bool isSmallScreen(BuildContext context) {
  return MediaQuery.of(context).size.width < 500;
}

bool isLargeScreen(BuildContext context) {
  return MediaQuery.of(context).size.width > 938;
}
