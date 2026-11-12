import 'package:animations/animations.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import '../utils/motion.dart';

export 'package:animations/animations.dart'
    show
        CloseContainerActionCallback,
        CloseContainerBuilder,
        ClosedCallback,
        ContainerTransitionType,
        OpenContainerBuilder;

/// An enhanced OpenContainer widget designed for Material 3.
///
/// Combines the Container Transform pattern with Android 14+ Predictive Back gesture
/// integration. While the user is dragging the edge back gesture on supported Android
/// devices, the opened page interactively scales down and rounds its corners, giving
/// real-time physical feedback before collapsing seamlessly back to the source tile
/// upon gesture commit.
class M3OpenContainer<T> extends StatelessWidget {
  /// Background color of the container in its closed state.
  final Color closedColor;

  /// Elevation of the container in its closed state.
  final double closedElevation;

  /// Shape of the container in its closed state.
  final ShapeBorder closedShape;

  /// Background color of the container in its open state.
  final Color openColor;

  /// Elevation of the container in its open state.
  final double openElevation;

  /// Shape of the container in its open state.
  final ShapeBorder openShape;

  /// Middle color used during the transition.
  final Color? middleColor;

  /// Builder for the closed state.
  final CloseContainerBuilder closedBuilder;

  /// Builder for the open state.
  final OpenContainerBuilder<T> openBuilder;

  /// Called when the container is popped.
  final ClosedCallback<T?>? onClosed;

  /// Duration of the opening and closing transitions.
  final Duration transitionDuration;

  /// Type of container transform.
  final ContainerTransitionType transitionType;

  /// Whether to use the root navigator.
  final bool useRootNavigator;

  /// Route settings for the opened route.
  final RouteSettings? routeSettings;

  /// Whether the closed builder is tappable.
  final bool tappable;

  /// Clip behavior.
  final Clip clipBehavior;

  /// Custom shadows of the container while it is closed.
  final List<BoxShadow>? closedShadows;

  /// Custom shadows of the container while it is open.
  final List<BoxShadow>? openShadows;

  const M3OpenContainer({
    super.key,
    required this.closedBuilder,
    required this.openBuilder,
    this.closedColor = Colors.white,
    this.closedElevation = 1.0,
    this.closedShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    this.openColor = Colors.white,
    this.openElevation = 4.0,
    this.openShape = const RoundedRectangleBorder(),
    this.middleColor,
    this.onClosed,
    this.transitionDuration = M3Motion.pageTransition,
    this.transitionType = ContainerTransitionType.fadeThrough,
    this.useRootNavigator = true,
    this.routeSettings,
    this.tappable = true,
    this.clipBehavior = Clip.antiAlias,
    this.closedShadows,
    this.openShadows,
  });

  @override
  Widget build(BuildContext context) {
    return OpenContainer<T>(
      closedColor: closedColor,
      closedElevation: closedElevation,
      closedShape: closedShape,
      openColor: openColor,
      openElevation: openElevation,
      openShape: openShape,
      middleColor: middleColor,
      onClosed: onClosed,
      transitionDuration: transitionDuration,
      transitionType: transitionType,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      tappable: tappable,
      clipBehavior: clipBehavior,
      closedShadows: closedShadows,
      openShadows: openShadows,
      closedBuilder: closedBuilder,
      openBuilder: (context, closeContainer) {
        return _M3PredictiveBackScrubber<T>(
          closeContainer: closeContainer,
          child: openBuilder(context, closeContainer),
        );
      },
    );
  }
}

class _M3PredictiveBackScrubber<T> extends StatefulWidget {
  final Widget child;
  final VoidCallback closeContainer;

  const _M3PredictiveBackScrubber({
    required this.child,
    required this.closeContainer,
  });

  @override
  State<_M3PredictiveBackScrubber<T>> createState() =>
      _M3PredictiveBackScrubberState<T>();
}

class _M3PredictiveBackScrubberState<T> extends State<_M3PredictiveBackScrubber<T>>
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

  bool get _isCurrentRoute {
    final ModalRoute<dynamic>? route = ModalRoute.of(context);
    return route != null && route.isCurrent;
  }

  @override
  bool handleStartBackGesture(PredictiveBackEvent backEvent) {
    if (!_isCurrentRoute || backEvent.isButtonEvent) {
      return false;
    }
    _resetController.stop();
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
    // Gesture committed: smoothly trigger container transform reverse back to source card
    widget.closeContainer();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _resetController,
      builder: (context, child) {
        if (_progress <= 0.001) {
          return widget.child;
        }

        // M3 Predictive Back Transformation values:
        // Scales from 1.0 down to 0.90
        final double scale = 1.0 - (_progress * 0.10);
        // Corner radius curves from 0 up to 28dp
        final double cornerRadius = _progress * 28.0;
        // Shift towards target edge
        final double xOffset =
            (_swipeEdge == SwipeEdge.right ? 1 : -1) * (_progress * 20.0);

        return Transform.translate(
          offset: Offset(xOffset, 0),
          child: Transform.scale(
            scale: scale,
            alignment: _swipeEdge == SwipeEdge.right
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(cornerRadius),
              child: Material(
                elevation: _progress * 12.0,
                shadowColor: Colors.black.withValues(alpha: 0.25),
                child: widget.child,
              ),
            ),
          ),
        );
      },
    );
  }
}
