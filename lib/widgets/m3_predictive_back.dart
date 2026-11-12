import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import '../utils/motion.dart';

/// Wraps bottom sheet content with interactive Material 3 Predictive Back gesture support.
///
/// On Android 14+ devices, as the user drags a back gesture from the edge of the screen,
/// both the sheet's surface container and the modal barrier scrim interactively respond:
/// - The sheet surface container translates down, scales slightly, and rounds its bottom corners.
/// - The dimmed screen backdrop (scrim) fades in real-time with the gesture progress.
/// - If cancelled, both spring back smoothly. If committed, the route pops cleanly.
class M3PredictiveBackSheet extends StatefulWidget {
  final Widget child;
  final VoidCallback? onDismissed;
  final bool enabled;
  final Color? backgroundColor;
  final double topRadius;
  final double elevation;

  const M3PredictiveBackSheet({
    super.key,
    required this.child,
    this.onDismissed,
    this.enabled = true,
    this.backgroundColor,
    this.topRadius = 24.0,
    this.elevation = 1.0,
  });

  @override
  State<M3PredictiveBackSheet> createState() => _M3PredictiveBackSheetState();
}

class _M3PredictiveBackSheetState extends State<M3PredictiveBackSheet>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late final AnimationController _resetController;
  late Animation<double> _progressAnimation;

  double _progress = 0.0;
  SwipeEdge _swipeEdge = SwipeEdge.left;
  bool _isGestureActive = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _resetController = AnimationController(
      vsync: this,
      duration: M3Motion.short3,
    )..addListener(() {
        setState(() {
          _progress = _progressAnimation.value;
        });
      });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _resetController.dispose();
    super.dispose();
  }

  ModalRoute<dynamic>? get _currentRoute {
    final ModalRoute<dynamic>? route = ModalRoute.of(context);
    return (route != null && route.isCurrent) ? route : null;
  }

  @override
  bool handleStartBackGesture(PredictiveBackEvent backEvent) {
    final route = _currentRoute;
    if (!widget.enabled || route == null || backEvent.isButtonEvent) {
      return false;
    }
    _resetController.stop();
    setState(() {
      _isGestureActive = true;
      _swipeEdge = backEvent.swipeEdge;
      _progress = backEvent.progress;
    });
    route.handleStartBackGesture(progress: 1.0);
    return true;
  }

  @override
  void handleUpdateBackGestureProgress(PredictiveBackEvent backEvent) {
    if (!_isGestureActive) return;
    final route = _currentRoute;
    setState(() {
      _progress = backEvent.progress;
    });
    if (route != null) {
      // Fade the scrim backdrop in proportion to gesture progress
      final double routeProgress =
          (1.0 - (backEvent.progress * 0.35)).clamp(0.0, 1.0);
      route.handleUpdateBackGestureProgress(progress: routeProgress);
    }
  }

  @override
  void handleCancelBackGesture() {
    if (!_isGestureActive) return;
    _isGestureActive = false;
    final route = _currentRoute;
    if (route != null) {
      route.handleCancelBackGesture();
    }
    _progressAnimation = Tween<double>(
      begin: _progress,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _resetController,
      curve: M3Motion.emphasizedDecelerate,
    ));
    _resetController.forward(from: 0.0);
  }

  @override
  void handleCommitBackGesture() {
    if (!_isGestureActive) return;
    _isGestureActive = false;
    _progress = 0.0;
    final route = _currentRoute;
    if (widget.onDismissed != null) {
      widget.onDismissed!();
    } else if (route != null) {
      route.handleCommitBackGesture();
    } else {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sheetColor = widget.backgroundColor ??
        theme.bottomSheetTheme.backgroundColor ??
        theme.colorScheme.surfaceContainer;

    return AnimatedBuilder(
      animation: _resetController,
      builder: (context, child) {
        // Material 3 Predictive Back for Bottom Sheets:
        // 1. Vertical translation downward (up to 80dp)
        final double yOffset = _progress * 80.0;
        // 2. Interactive subtle scale down (1.0 -> 0.94)
        final double scale = 1.0 - (_progress * 0.06);
        // 3. Dynamically round bottom corners as sheet lifts/detaches
        final double bottomRadius = _progress * 24.0;
        // 4. Subtle horizontal shift towards swipe direction
        final double xOffset =
            (_swipeEdge == SwipeEdge.right ? 1 : -1) * (_progress * 14.0);

        final Widget surface = Material(
          color: sheetColor,
          elevation: widget.elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(widget.topRadius),
              bottom: Radius.circular(bottomRadius),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: widget.child,
        );

        if (_progress <= 0.001) {
          return surface;
        }

        return Transform.translate(
          offset: Offset(xOffset, yOffset),
          child: Transform.scale(
            scale: scale,
            alignment: Alignment.bottomCenter,
            child: surface,
          ),
        );
      },
    );
  }
}

/// Custom Material 3 Modal Bottom Sheet Route that sets the outer container to transparent
/// so that [M3PredictiveBackSheet] can animate the surface background and scrim together.
class M3ModalBottomSheetRoute<T> extends ModalBottomSheetRoute<T> {
  M3ModalBottomSheetRoute({
    required super.builder,
    super.capturedThemes,
    super.barrierLabel,
    super.barrierOnTapHint,
    super.backgroundColor = Colors.transparent,
    super.elevation = 0,
    super.shape,
    super.clipBehavior,
    super.constraints,
    super.modalBarrierColor,
    super.isDismissible = true,
    super.enableDrag = true,
    super.showDragHandle = false,
    required super.isScrollControlled,
    super.scrollControlDisabledMaxHeightRatio,
    super.settings,
    super.requestFocus,
    super.transitionAnimationController,
    super.anchorPoint,
    super.useSafeArea = false,
    super.sheetAnimationStyle,
  });
}

/// Displays a Material 3 Modal Bottom Sheet with synchronized predictive back gesture
/// support (both sheet surface container and modal scrim backdrop animate together).
Future<T?> showM3BottomSheet<T>({
  required BuildContext context,
  required Widget child,
  String? title,
  bool isDismissible = true,
  bool enableDrag = true,
  Color? backgroundColor,
  Color? barrierColor,
  bool isScrollControlled = true,
  bool useSafeArea = true,
  bool useRootNavigator = false,
  RouteSettings? routeSettings,
  AnimationStyle? sheetAnimationStyle,
}) {
  final NavigatorState navigator =
      Navigator.of(context, rootNavigator: useRootNavigator);

  return navigator.push<T>(
    M3ModalBottomSheetRoute<T>(
      builder: (context) => M3PredictiveBackSheet(
        backgroundColor: backgroundColor,
        child: child,
      ),
      capturedThemes:
          InheritedTheme.capture(from: context, to: navigator.context),
      isScrollControlled: isScrollControlled,
      barrierLabel: title ??
          MaterialLocalizations.of(context).modalBarrierDismissLabel,
      backgroundColor: Colors.transparent,
      elevation: 0,
      isDismissible: isDismissible,
      modalBarrierColor: barrierColor ??
          Theme.of(context).bottomSheetTheme.modalBarrierColor ??
          Colors.black54,
      enableDrag: enableDrag,
      settings: routeSettings,
      useSafeArea: useSafeArea,
      sheetAnimationStyle:
          sheetAnimationStyle ?? M3Motion.sheetAnimationStyle,
    ),
  );
}

/// Wraps dialog and sheet-dialog content with interactive Material 3 Predictive Back gesture support.
///
/// On Android 14+ devices, as the user drags a back gesture from the edge of the screen,
/// the dialog interactively scales down, shifts towards the swipe edge, and dims slightly.
/// If the gesture is cancelled, it springs back to full scale. If committed, it pops cleanly.
class M3PredictiveBackDialog extends StatefulWidget {
  final Widget child;
  final VoidCallback? onDismissed;
  final bool enabled;

  const M3PredictiveBackDialog({
    super.key,
    required this.child,
    this.onDismissed,
    this.enabled = true,
  });

  @override
  State<M3PredictiveBackDialog> createState() => _M3PredictiveBackDialogState();
}

class _M3PredictiveBackDialogState extends State<M3PredictiveBackDialog>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late final AnimationController _resetController;
  late Animation<double> _progressAnimation;

  late final AnimationController _exitController;
  late Animation<double> _exitProgressAnimation;
  late Animation<double> _exitOpacityAnimation;
  bool _isExiting = false;

  double _progress = 0.0;
  SwipeEdge _swipeEdge = SwipeEdge.left;
  bool _isGestureActive = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _resetController = AnimationController(
      vsync: this,
      duration: M3Motion.short3,
    )..addListener(() {
        setState(() {
          _progress = _progressAnimation.value;
        });
      });
    _exitController = AnimationController(
      vsync: this,
      duration: M3Motion.short3,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _resetController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  bool get _isCurrentRoute {
    final ModalRoute<dynamic>? route = ModalRoute.of(context);
    return route != null && route.isCurrent;
  }

  @override
  bool handleStartBackGesture(PredictiveBackEvent backEvent) {
    if (!widget.enabled || !_isCurrentRoute || backEvent.isButtonEvent) {
      return false;
    }
    _resetController.stop();
    _exitController.stop();
    _isExiting = false;
    setState(() {
      _isGestureActive = true;
      _swipeEdge = backEvent.swipeEdge;
      _progress = backEvent.progress;
    });
    return true;
  }

  @override
  void handleUpdateBackGestureProgress(PredictiveBackEvent backEvent) {
    if (!_isGestureActive) return;
    setState(() {
      _progress = backEvent.progress;
    });
  }

  @override
  void handleCancelBackGesture() {
    if (!_isGestureActive) return;
    _isGestureActive = false;
    _isExiting = false;
    _progressAnimation = Tween<double>(
      begin: _progress,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _resetController,
      curve: M3Motion.emphasizedDecelerate,
    ));
    _resetController.forward(from: 0.0);
  }

  @override
  void handleCommitBackGesture() {
    if (!_isGestureActive && !_isExiting) return;
    _isGestureActive = false;
    _isExiting = true;
    final double startProgress = _progress;
    _exitProgressAnimation = Tween<double>(
      begin: startProgress,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _exitController,
      curve: M3Motion.emphasizedAccelerate,
    ));
    _exitOpacityAnimation = Tween<double>(
      begin: (1.0 - (startProgress * 0.18)).clamp(0.0, 1.0),
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _exitController,
      curve: M3Motion.standardAccelerate,
    ));
    _exitController.forward(from: 0.0).then((_) {
      if (mounted) {
        if (widget.onDismissed != null) {
          widget.onDismissed!();
        } else {
          Navigator.of(context).maybePop();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_resetController, _exitController]),
      builder: (context, child) {
        final double effectiveProgress =
            _isExiting ? _exitProgressAnimation.value : _progress;
        if (effectiveProgress <= 0.001 && !_isExiting) {
          return widget.child;
        }

        // Material 3 Predictive Back for Dialogs:
        // 1. Scale down from 1.0 down to 0.88
        final double scale = 1.0 - (effectiveProgress * 0.12);
        // 2. Horizontal translation towards target edge:
        // Swiping right-to-left -> moves RIGHT (+x)
        // Swiping left-to-right -> moves LEFT (-x)
        final int direction = _swipeEdge == SwipeEdge.right ? 1 : -1;
        final double xOffset = _isExiting
            ? direction * (24.0 + (effectiveProgress * 16.0))
            : direction * (effectiveProgress * 24.0);
        // 3. Subtle opacity reduction
        final double opacity = _isExiting
            ? _exitOpacityAnimation.value.clamp(0.0, 1.0)
            : (1.0 - (effectiveProgress * 0.18)).clamp(0.0, 1.0);

        return Transform.translate(
          offset: Offset(xOffset, 0),
          child: Transform.scale(
            scale: scale,
            alignment: _swipeEdge == SwipeEdge.right
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Opacity(
              opacity: opacity,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}

/// Wraps a full page (such as [NinUiScaffold]) with Material 3 Predictive Back gesture support.
///
/// As the user drags a back gesture from either screen edge on Android 14+, the page:
/// 1. Interactively scales down (1.0 -> 0.92)
/// 2. Dynamically rounds its corners (0.0 -> 24.0 dp)
/// 3. Shifts horizontally towards the gesture direction (0 -> 36.0 dp)
/// 4. Dims slightly (opacity 1.0 -> 0.92)
///
/// If cancelled, it springs back smoothly via [M3Motion.emphasizedDecelerate].
/// If committed, it pops the route cleanly.
class M3PredictiveBackPage extends StatefulWidget {
  final Widget child;
  final VoidCallback? onDismissed;
  final bool enabled;

  const M3PredictiveBackPage({
    super.key,
    required this.child,
    this.onDismissed,
    this.enabled = true,
  });

  @override
  State<M3PredictiveBackPage> createState() => _M3PredictiveBackPageState();
}

class _M3PredictiveBackPageState extends State<M3PredictiveBackPage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late final AnimationController _resetController;
  late Animation<double> _progressAnimation;

  late final AnimationController _exitController;
  late Animation<double> _exitProgressAnimation;
  late Animation<double> _exitOpacityAnimation;
  bool _isExiting = false;

  double _progress = 0.0;
  SwipeEdge _swipeEdge = SwipeEdge.left;
  bool _isGestureActive = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _resetController = AnimationController(
      vsync: this,
      duration: M3Motion.short3,
    )..addListener(() {
        setState(() {
          _progress = _progressAnimation.value;
        });
      });
    _exitController = AnimationController(
      vsync: this,
      duration: M3Motion.short3,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _resetController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  ModalRoute<dynamic>? get _currentRoute {
    final ModalRoute<dynamic>? route = ModalRoute.of(context);
    return (route != null && route.isCurrent) ? route : null;
  }

  bool get _canPopRoute {
    final ModalRoute<dynamic>? route = ModalRoute.of(context);
    return route != null && route.isCurrent && route.canPop;
  }

  @override
  bool handleStartBackGesture(PredictiveBackEvent backEvent) {
    final route = _currentRoute;
    if (!widget.enabled || !_canPopRoute || backEvent.isButtonEvent) {
      return false;
    }
    _resetController.stop();
    _exitController.stop();
    _isExiting = false;
    setState(() {
      _isGestureActive = true;
      _swipeEdge = backEvent.swipeEdge;
      _progress = backEvent.progress;
    });
    route?.handleStartBackGesture(progress: 1.0);
    return true;
  }

  @override
  void handleUpdateBackGestureProgress(PredictiveBackEvent backEvent) {
    if (!_isGestureActive) return;
    final route = _currentRoute;
    setState(() {
      _progress = backEvent.progress;
    });
    if (route != null) {
      final double routeProgress =
          (1.0 - (backEvent.progress * 0.40)).clamp(0.0, 1.0);
      route.handleUpdateBackGestureProgress(progress: routeProgress);
    }
  }

  @override
  void handleCancelBackGesture() {
    if (!_isGestureActive) return;
    _isGestureActive = false;
    _isExiting = false;
    final route = _currentRoute;
    if (route != null) {
      route.handleCancelBackGesture();
    }
    _progressAnimation = Tween<double>(
      begin: _progress,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _resetController,
      curve: M3Motion.emphasizedDecelerate,
    ));
    _resetController.forward(from: 0.0);
  }

  @override
  void handleCommitBackGesture() {
    if (!_isGestureActive && !_isExiting) return;
    _isGestureActive = false;
    _isExiting = true;
    final route = _currentRoute;
    final double startProgress = _progress;
    _exitProgressAnimation = Tween<double>(
      begin: startProgress,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _exitController,
      curve: M3Motion.emphasizedAccelerate,
    ));
    _exitOpacityAnimation = Tween<double>(
      begin: (1.0 - (startProgress * 0.10)).clamp(0.0, 1.0),
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _exitController,
      curve: M3Motion.standardAccelerate,
    ));
    _exitController.forward(from: 0.0).then((_) {
      if (mounted) {
        if (widget.onDismissed != null) {
          widget.onDismissed!();
        } else if (route != null) {
          route.handleCommitBackGesture();
        } else {
          Navigator.of(context).maybePop();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_resetController, _exitController]),
      builder: (context, child) {
        final double effectiveProgress =
            _isExiting ? _exitProgressAnimation.value : _progress;
        if (effectiveProgress <= 0.001 && !_isExiting) {
          return widget.child;
        }

        // Material 3 Predictive Back for Pages:
        // 1. Interactive subtle scale down (1.0 -> 0.92)
        final double scale = 1.0 - (effectiveProgress * 0.08);
        // 2. Interactive corner radius (0 -> 28dp)
        final double radius = effectiveProgress * 28.0;
        // 3. Floating elevation drop-shadow casting onto previous page
        final double elevation = _isExiting
            ? (1.0 - _exitProgressAnimation.value) * 12.0
            : effectiveProgress * 12.0;
        // 4. Horizontal translation towards target edge:
        // Swiping right-to-left -> moves RIGHT (+x)
        // Swiping left-to-right -> moves LEFT (-x)
        final int direction = _swipeEdge == SwipeEdge.right ? 1 : -1;
        final double xOffset = _isExiting
            ? direction * (48.0 + (effectiveProgress * 32.0))
            : direction * (effectiveProgress * 48.0);
        // 5. Subtle opacity reduction (fading completely to 0 on exit)
        final double opacity = _isExiting
            ? _exitOpacityAnimation.value.clamp(0.0, 1.0)
            : (1.0 - (effectiveProgress * 0.10)).clamp(0.0, 1.0);

        return Transform.translate(
          offset: Offset(xOffset, 0),
          child: Transform.scale(
            scale: scale,
            alignment: _swipeEdge == SwipeEdge.right
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Material(
              color: Colors.transparent,
              elevation: elevation,
              shadowColor: Colors.black.withValues(alpha: 0.28),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
              clipBehavior: Clip.antiAlias,
              child: Opacity(
                opacity: opacity,
                child: widget.child,
              ),
            ),
          ),
        );
      },
    );
  }
}
