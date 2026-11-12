import 'dart:ui';
import 'package:material_ui/material_ui.dart';
import 'package:nin_ui/utils/color.dart';
import 'm3_predictive_back.dart';

class SheetDialogCard extends StatelessWidget {
  const SheetDialogCard({
    super.key,
    this.child,
    this.borderRadius = 30,
    this.backgroundColor,
  });
  final Widget? child;
  final double borderRadius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final devicePadding = MediaQuery.paddingOf(context);
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final genColor = getCupertinoSheetBackgroundColor(context);

    return M3PredictiveBackDialog(
      child: Container(
        margin: EdgeInsets.only(
          bottom: devicePadding.bottom + 16 + viewInsets.bottom,
          left: 16,
          right: 16,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor ?? genColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
