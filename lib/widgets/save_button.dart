import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SaveButton extends StatefulWidget {
  const SaveButton({
    super.key,
    this.onTap,
    this.tooltipMessage = 'Done',
    this.backgroundColor,
    this.foregroundColor,
  });
  final GestureTapCallback? onTap;
  final String tooltipMessage;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Tooltip(
      message: widget.tooltipMessage,
      child: GestureDetector(
        onTap: widget.onTap == null
            ? null
            : () {
                if (_isTapped == false) {
                  HapticFeedback.lightImpact();
                  if (mounted) setState(() => _isTapped = true);
                  widget.onTap!.call();

                  Future.delayed(Durations.medium1, () {
                    if (_isTapped && mounted) setState(() => _isTapped = false);
                  });
                }
              },
        child: AnimatedContainer(
          duration: Durations.short3,
          margin: EdgeInsets.symmetric(horizontal: 8),
          height: _isTapped ? 40 : 38,
          width: 55,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? colorScheme.primary,
            borderRadius: BorderRadius.circular(_isTapped ? 8 : 19),
          ),
          child: Icon(
            Icons.check_rounded,
            color: widget.foregroundColor ?? colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
