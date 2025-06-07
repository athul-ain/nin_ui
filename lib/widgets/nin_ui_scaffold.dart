import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nin_ui/nin_ui.dart';
import 'package:nin_ui/utils/color.dart';
import 'package:nin_ui/utils/size.dart';
import 'package:nin_ui/widgets/page_loading_indicator.dart';

class NinUiScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final NavigationBar? navigationBar;

  /// If null will auto generated with navigationbar items
  final Widget? navigationRail;
  final bool? isPageLoading;
  final Widget? loadingBody;
  final Widget? banner;
  final Color? backgroundColor;
  final Key? scaffoldKey;
  final String? desktopTitle;
  final bool extendBodyBehindAppBar;

  /// Responsible for determining where the [floatingActionButton] should go.
  ///
  /// If null, the [ScaffoldState] will use the default location, [FloatingActionButtonLocation.endFloat].
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// The alignment of the [persistentFooterButtons] inside the [OverflowBar].
  ///
  /// Defaults to [AlignmentDirectional.centerEnd].
  final AlignmentDirectional persistentFooterAlignment;

  /// A set of buttons that are displayed at the bottom of the scaffold.
  ///
  /// Typically this is a list of [TextButton] widgets. These buttons are
  /// persistently visible, even if the [body] of the scaffold scrolls.
  ///
  /// These widgets will be wrapped in an [OverflowBar].
  ///
  /// The [persistentFooterButtons] are rendered above the
  /// [bottomNavigationBar] but below the [body].
  final List<Widget>? persistentFooterButtons;

  /// The persistent bottom sheet to display.
  ///
  /// A persistent bottom sheet shows information that supplements the primary
  /// content of the app. A persistent bottom sheet remains visible even when
  /// the user interacts with other parts of the app.
  ///
  /// A closely related widget is a modal bottom sheet, which is an alternative
  /// to a menu or a dialog and prevents the user from interacting with the rest
  /// of the app. Modal bottom sheets can be created and displayed with the
  /// [showModalBottomSheet] function.
  ///
  /// Unlike the persistent bottom sheet displayed by [showBottomSheet]
  /// this bottom sheet is not a [LocalHistoryEntry] and cannot be dismissed
  /// with the scaffold appbar's back button.
  ///
  /// If a persistent bottom sheet created with [showBottomSheet] is already
  /// visible, it must be closed before building the Scaffold with a new
  /// [bottomSheet].
  ///
  /// The value of [bottomSheet] can be any widget at all. It's unlikely to
  /// actually be a [BottomSheet], which is used by the implementations of
  /// [showBottomSheet] and [showModalBottomSheet]. Typically it's a widget
  /// that includes [Material].
  ///
  /// See also:
  ///
  ///  * [showBottomSheet], which displays a bottom sheet as a route that can
  ///    be dismissed with the scaffold's back button.
  ///  * [showModalBottomSheet], which displays a modal bottom sheet.
  ///  * [BottomSheetThemeData], which can be used to customize the default
  ///    bottom sheet property values when using a [BottomSheet].
  final Widget? bottomSheet;

  const NinUiScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.drawer,
    this.floatingActionButton,
    this.navigationBar,
    this.navigationRail,
    this.isPageLoading,
    this.loadingBody,
    this.floatingActionButtonLocation,
    this.banner,
    this.backgroundColor,
    this.scaffoldKey,
    this.desktopTitle,
    this.extendBodyBehindAppBar = false,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.persistentFooterButtons,
    this.bottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = getBackgroundColor(theme.colorScheme);

    final iconBrightness = theme.brightness == Brightness.dark
        ? Brightness.light
        : Brightness.dark;
    final bool smallScreen = isSmallScreen(context);
    final bool largeScreen = isLargeScreen(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: iconBrightness,
        systemNavigationBarColor: backgroundColor ?? bgColor,
        systemNavigationBarIconBrightness: iconBrightness,
      ),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: backgroundColor ?? bgColor,
        persistentFooterAlignment: persistentFooterAlignment,
        persistentFooterButtons: persistentFooterButtons,
        bottomSheet: bottomSheet,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        appBar: appBar != null && smallScreen ? appBar! : null,
        drawer: drawer != null && !largeScreen ? drawer : null,
        body: Row(
          children: [
            if (!smallScreen) ...[
              if (navigationRail != null)
                navigationRail!
              else if (drawer != null && largeScreen)
                drawer!
              else if (navigationBar != null)
                getGeneratedNavRail(bgColor, largeScreen)
            ],
            Expanded(
              child: Column(
                children: [
                  if (!smallScreen && appBar != null) appBar!,
                  Expanded(
                    child: SafeArea(
                      bottom: false,
                      top: appBar == null && !extendBodyBehindAppBar,
                      left: navigationRail == null || smallScreen,
                      minimum: getBodyMinimumPadding(smallScreen),
                      child: Column(
                        children: [
                          if (banner != null) banner!,
                          Expanded(
                            child: BodyCard(
                              margin: EdgeInsets.zero,
                              child: isPageLoading == true
                                  ? loadingBody ?? const PageLoadingIndicator()
                                  : body,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: (navigationBar != null && !smallScreen)
            ? null
            : floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        bottomNavigationBar: navigationBar != null && smallScreen
            ? NavigationBar(
                key: navigationBar!.key,
                destinations: navigationBar!.destinations,
                selectedIndex: navigationBar!.selectedIndex,
                onDestinationSelected: navigationBar!.onDestinationSelected,
                backgroundColor: navigationBar!.backgroundColor ??
                    backgroundColor ??
                    bgColor,
                elevation: navigationBar!.elevation ?? 0,
                labelBehavior: navigationBar!.labelBehavior,
                height: navigationBar!.height,
              )
            : null,
      ),
    );
  }

  EdgeInsets getBodyMinimumPadding(bool isSmallScreen) {
    return EdgeInsets.only(
      top: extendBodyBehindAppBar ? 0 : 3,
      left: navigationRail == null ? (isSmallScreen ? 5 : 18) : 3,
      right: isSmallScreen ? 5 : 18,
    );
  }

  NavigationRail getGeneratedNavRail(Color bgColor, bool largeScreen) {
    return NavigationRail(
      useIndicator: true,
      extended: false,
      minExtendedWidth: 158,
      backgroundColor: backgroundColor ?? bgColor,
      groupAlignment: -0.95,
      leading: floatingActionButton ??
          (drawer != null && !largeScreen
              ? const DrawerButton()
              : const SizedBox(height: 38)),
      destinations: navigationBar!.destinations.map(
        (e) {
          NavigationDestination thisDestination = e as NavigationDestination;
          return NavigationRailDestination(
            icon: thisDestination.icon,
            selectedIcon: thisDestination.selectedIcon,
            label: Text(thisDestination.label),
          );
        },
      ).toList(),
      selectedIndex: navigationBar!.selectedIndex,
      onDestinationSelected: navigationBar!.onDestinationSelected,
      labelType: (largeScreen && drawer == null) ||
              navigationBar!.labelBehavior ==
                  NavigationDestinationLabelBehavior.alwaysHide
          ? NavigationRailLabelType.none
          : navigationBar!.labelBehavior ==
                  NavigationDestinationLabelBehavior.alwaysShow
              ? NavigationRailLabelType.all
              : navigationBar!.labelBehavior ==
                      NavigationDestinationLabelBehavior.onlyShowSelected
                  ? NavigationRailLabelType.selected
                  : null,
    );
  }
}
