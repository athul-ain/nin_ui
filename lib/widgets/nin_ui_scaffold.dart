import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nin_ui/nin_ui.dart';
import 'package:nin_ui/widgets/page_loading_indicator.dart';

class NinUiScaffold extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;
  final Drawer? drawer;
  final Widget? floatingActionButton;
  final NavigationBar? navigationBar;
  final bool? isPageLoading;
  final Widget? banner;

  /// Responsible for determining where the [floatingActionButton] should go.
  ///
  /// If null, the [ScaffoldState] will use the default location, [FloatingActionButtonLocation.endFloat].
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const NinUiScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.drawer,
    this.floatingActionButton,
    this.navigationBar,
    this.isPageLoading,
    this.floatingActionButtonLocation,
    this.banner,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = ElevationOverlay.colorWithOverlay(
      theme.colorScheme.surface,
      theme.colorScheme.onSurface,
      1,
    );
    final iconBrightness = theme.brightness == Brightness.dark
        ? Brightness.light
        : Brightness.dark;
    final bool isSmallScreen = MediaQuery.of(context).size.width < 500;
    final bool isLargeScreen = MediaQuery.of(context).size.width > 880;

    final safePadding = MediaQuery.of(context).padding;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: iconBrightness,
        systemNavigationBarColor: bgColor,
        systemNavigationBarIconBrightness: iconBrightness,
      ),
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: appBar != null && isSmallScreen
            ? AppBar(
                key: appBar!.key,
                leading: appBar!.leading,
                automaticallyImplyLeading: appBar!.automaticallyImplyLeading,
                title: appBar!.title,
                actions: appBar!.actions,
                flexibleSpace: appBar!.flexibleSpace,
                bottom: appBar!.bottom,
                elevation: appBar!.elevation,
                scrolledUnderElevation: appBar!.scrolledUnderElevation,
                notificationPredicate: appBar!.notificationPredicate,
                shadowColor: appBar!.shadowColor,
                surfaceTintColor: appBar!.surfaceTintColor ?? bgColor,
                shape: appBar!.shape,
                backgroundColor: appBar!.backgroundColor ?? bgColor,
                foregroundColor: appBar!.foregroundColor,
                iconTheme: appBar!.iconTheme,
                actionsIconTheme: appBar!.actionsIconTheme,
                primary: appBar!.primary,
                centerTitle: appBar!.centerTitle,
                excludeHeaderSemantics: appBar!.excludeHeaderSemantics,
                titleSpacing: appBar!.titleSpacing,
                toolbarOpacity: appBar!.toolbarOpacity,
                bottomOpacity: appBar!.bottomOpacity,
                toolbarHeight: appBar!.toolbarHeight,
                leadingWidth: appBar!.leadingWidth,
                toolbarTextStyle: appBar!.toolbarTextStyle,
                titleTextStyle: appBar!.titleTextStyle,
                systemOverlayStyle: appBar!.systemOverlayStyle,
                forceMaterialTransparency: appBar!.forceMaterialTransparency,
                clipBehavior: appBar!.clipBehavior,
              )
            : null,
        drawer: drawer != null && !isLargeScreen ? drawer : null,
        body: Row(
          children: [
            if (!isSmallScreen && navigationBar != null)
              NavigationRail(
                useIndicator: true,
                extended: (isLargeScreen && drawer == null) ? true : false,
                minExtendedWidth: 158,
                backgroundColor: bgColor,
                leading: drawer != null && !isLargeScreen
                    ? const DrawerButton()
                    : appBar?.leading != null
                        ? appBar!.leading
                        : const SizedBox(
                            height: 38,
                          ),
                destinations: navigationBar!.destinations.map(
                  (e) {
                    NavigationDestination thisDestination =
                        e as NavigationDestination;
                    return NavigationRailDestination(
                      icon: thisDestination.icon,
                      selectedIcon: thisDestination.selectedIcon,
                      label: Text(thisDestination.label),
                    );
                  },
                ).toList(),
                selectedIndex: navigationBar!.selectedIndex,
                onDestinationSelected: navigationBar!.onDestinationSelected,
                labelType: (isLargeScreen && drawer == null) ||
                        navigationBar!.labelBehavior ==
                            NavigationDestinationLabelBehavior.alwaysHide
                    ? NavigationRailLabelType.none
                    : navigationBar!.labelBehavior ==
                            NavigationDestinationLabelBehavior.alwaysShow
                        ? NavigationRailLabelType.all
                        : navigationBar!.labelBehavior ==
                                NavigationDestinationLabelBehavior
                                    .onlyShowSelected
                            ? NavigationRailLabelType.selected
                            : null,
              ),
            Expanded(
                child: Column(
              children: [
                if (!isSmallScreen && appBar != null)
                  AppBar(
                    key: appBar!.key,
                    leading: !isLargeScreen
                        ? drawer != null
                            ? const SizedBox()
                            : appBar!.leading
                        : null,
                    automaticallyImplyLeading:
                        appBar!.automaticallyImplyLeading,
                    title: appBar!.title,
                    actions: appBar!.actions,
                    flexibleSpace: appBar!.flexibleSpace,
                    bottom: appBar!.bottom,
                    elevation: appBar!.elevation,
                    scrolledUnderElevation: appBar!.scrolledUnderElevation,
                    notificationPredicate: appBar!.notificationPredicate,
                    shadowColor: appBar!.shadowColor,
                    surfaceTintColor: appBar!.surfaceTintColor ?? bgColor,
                    shape: appBar!.shape,
                    backgroundColor: appBar!.backgroundColor ?? bgColor,
                    foregroundColor: appBar!.foregroundColor,
                    iconTheme: appBar!.iconTheme,
                    actionsIconTheme: appBar!.actionsIconTheme,
                    primary: appBar!.primary,
                    centerTitle: appBar!.centerTitle,
                    excludeHeaderSemantics: appBar!.excludeHeaderSemantics,
                    titleSpacing: appBar!.titleSpacing,
                    toolbarOpacity: appBar!.toolbarOpacity,
                    bottomOpacity: appBar!.bottomOpacity,
                    toolbarHeight: appBar!.toolbarHeight,
                    leadingWidth: appBar!.leadingWidth,
                    toolbarTextStyle: appBar!.toolbarTextStyle,
                    titleTextStyle: appBar!.titleTextStyle,
                    systemOverlayStyle: appBar!.systemOverlayStyle,
                    forceMaterialTransparency:
                        appBar!.forceMaterialTransparency,
                    clipBehavior: appBar!.clipBehavior,
                  ),
                Expanded(
                  child: Column(
                    children: [
                      if (banner != null) banner!,
                      Expanded(
                        child: BodyCard(
                          padding: isSmallScreen
                              ? EdgeInsets.only(
                                  bottom: safePadding.bottom > 3
                                      ? safePadding.bottom
                                      : 3,
                                  left: safePadding.left > 5
                                      ? safePadding.left
                                      : 5,
                                  right: safePadding.right > 5
                                      ? safePadding.right
                                      : 5,
                                )
                              : EdgeInsets.only(
                                  bottom: safePadding.bottom > 8
                                      ? safePadding.bottom
                                      : 8,
                                  left: navigationBar != null
                                      ? 0
                                      : safePadding.left > 18
                                          ? safePadding.left + 3
                                          : 18,
                                  right: drawer != null
                                      ? 0
                                      : safePadding.right > 18
                                          ? safePadding.right + 3
                                          : 18,
                                ),
                          child: isPageLoading == true
                              ? const PageLoadingIndicator()
                              : body,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
            if (isLargeScreen && drawer != null)
              Drawer(
                key: drawer!.key,
                backgroundColor: drawer!.backgroundColor ?? bgColor,
                elevation: drawer!.elevation ?? 0,
                shadowColor: drawer!.shadowColor,
                surfaceTintColor:
                    drawer!.surfaceTintColor ?? Colors.transparent,
                shape: drawer!.shape,
                width: drawer!.width ?? 238,
                semanticLabel: drawer!.semanticLabel,
                clipBehavior: drawer!.clipBehavior,
                child: drawer!.child,
              ),
          ],
        ),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        bottomNavigationBar: navigationBar != null && isSmallScreen
            ? NavigationBar(
                key: navigationBar!.key,
                destinations: navigationBar!.destinations,
                selectedIndex: navigationBar!.selectedIndex,
                onDestinationSelected: navigationBar!.onDestinationSelected,
                backgroundColor: navigationBar!.backgroundColor ?? bgColor,
                elevation: navigationBar!.elevation ?? 0,
                labelBehavior: navigationBar!.labelBehavior,
                height: navigationBar!.height,
              )
            : null,
      ),
    );
  }
}
