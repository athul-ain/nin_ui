import 'package:animations/animations.dart';
import 'package:material_ui/material_ui.dart';

/// Material 3 Motion Durations and Easings Reference:
/// https://m3.material.io/styles/motion/transitions/transition-patterns
class M3Motion {
  // --- Durations ---
  static const Duration short1 = Duration(milliseconds: 50);
  static const Duration short2 = Duration(milliseconds: 100);
  static const Duration short3 = Duration(milliseconds: 150);
  static const Duration short4 = Duration(milliseconds: 200);

  static const Duration medium1 = Duration(milliseconds: 250);
  static const Duration medium2 = Duration(milliseconds: 300);
  static const Duration medium3 = Duration(milliseconds: 350);
  static const Duration medium4 = Duration(milliseconds: 400);

  static const Duration long1 = Duration(milliseconds: 450);
  static const Duration long2 = Duration(milliseconds: 500);

  /// Standard duration for page transitions in Material 3 (300ms)
  static const Duration pageTransition = Duration(milliseconds: 300);

  /// Standard duration for cross-fading loading skeletons into real content (250ms)
  static const Duration skeletonFade = Duration(milliseconds: 250);

  /// Material 3 Bottom Sheet Animation Style
  static AnimationStyle get sheetAnimationStyle => const AnimationStyle(
        duration: medium2, // 300ms
        reverseDuration: short3, // 150ms
        curve: emphasizedDecelerate,
        reverseCurve: emphasizedAccelerate,
      );

  /// Material 3 Dialog Animation Style
  static AnimationStyle get dialogAnimationStyle => const AnimationStyle(
        duration: short4, // 200ms
        reverseDuration: short2, // 100ms
        curve: emphasizedDecelerate,
        reverseCurve: emphasizedAccelerate,
      );

  // --- Easings ---
  static const Curve standard = Easing.standard;
  static const Curve standardDecelerate = Easing.standardDecelerate;
  static const Curve standardAccelerate = Easing.standardAccelerate;
  static const Curve emphasized = Curves.easeInOutCubicEmphasized;
  static const Curve emphasizedDecelerate = Easing.emphasizedDecelerate;
  static const Curve emphasizedAccelerate = Easing.emphasizedAccelerate;

  /// Helper transitions builder for Material 3 Dialog (Scale 0.85 -> 1.0 + Fade)
  static Widget dialogTransition({
    required BuildContext context,
    required Animation<double> animation,
    required Widget child,
  }) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: emphasizedDecelerate,
      reverseCurve: emphasizedAccelerate,
    );

    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: standardDecelerate,
        reverseCurve: standardAccelerate,
      ),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.85, end: 1.0).animate(curvedAnimation),
        child: child,
      ),
    );
  }

  /// Helper transitions builder for GoRouter or Navigator CustomTransitionPage using SharedAxis
  static Widget sharedAxisTransition({
    required BuildContext context,
    required Animation<double> animation,
    required Animation<double> secondaryAnimation,
    required Widget child,
    SharedAxisTransitionType transitionType = SharedAxisTransitionType.horizontal,
    Color? fillColor,
  }) {
    return SharedAxisTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      transitionType: transitionType,
      fillColor: fillColor ?? Colors.transparent,
      child: child,
    );
  }

  /// Helper transitions builder for GoRouter or Navigator CustomTransitionPage using FadeThrough
  static Widget fadeThroughTransition({
    required BuildContext context,
    required Animation<double> animation,
    required Animation<double> secondaryAnimation,
    required Widget child,
    Color? fillColor,
  }) {
    return FadeThroughTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      fillColor: fillColor ?? Colors.transparent,
      child: child,
    );
  }
}

/// Material 3 SharedAxis PageTransitionsBuilder for ThemeData.pageTransitionsTheme
class M3SharedAxisPageTransitionsBuilder extends PageTransitionsBuilder {
  final SharedAxisTransitionType transitionType;
  final Color? fillColor;

  const M3SharedAxisPageTransitionsBuilder({
    this.transitionType = SharedAxisTransitionType.horizontal,
    this.fillColor,
  });

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SharedAxisTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      transitionType: transitionType,
      fillColor: fillColor ?? Colors.transparent,
      child: child,
    );
  }
}

/// Material 3 FadeThrough PageTransitionsBuilder for ThemeData.pageTransitionsTheme
class M3FadeThroughPageTransitionsBuilder extends PageTransitionsBuilder {
  final Color? fillColor;

  const M3FadeThroughPageTransitionsBuilder({this.fillColor});

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeThroughTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      fillColor: fillColor ?? Colors.transparent,
      child: child,
    );
  }
}
