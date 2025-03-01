import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nin_ui/nin_ui.dart';
import 'package:nin_ui/utils/color.dart';
import 'package:nin_ui/utils/size.dart';
import 'package:nin_ui/widgets/page_loading_indicator.dart';

class NinUiScaffold extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final NavigationBar? navigationBar;
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

  const NinUiScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.drawer,
    this.floatingActionButton,
    this.navigationBar,
    this.isPageLoading,
    this.loadingBody,
    this.floatingActionButtonLocation,
    this.banner,
    this.backgroundColor,
    this.scaffoldKey,
    this.desktopTitle,
    this.extendBodyBehindAppBar = false,
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

    final safePadding = MediaQuery.paddingOf(context);

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
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        appBar: appBar != null && smallScreen
            ? AppBar(
                key: appBar!.key,
                leading: appBar!.leading,
                automaticallyImplyLeading: appBar!.automaticallyImplyLeading,
                title: appBar!.title,
                actions: appBar!.actions == null
                    ? null
                    : [
                        ...appBar!.actions!,
                        SizedBox(
                          width: safePadding.right > 5 ? safePadding.right : 5,
                        )
                      ],
                flexibleSpace: appBar!.flexibleSpace,
                bottom: appBar!.bottom,
                elevation: appBar!.elevation,
                scrolledUnderElevation: appBar!.scrolledUnderElevation,
                notificationPredicate: appBar!.notificationPredicate,
                shadowColor: appBar!.shadowColor,
                surfaceTintColor:
                    appBar!.surfaceTintColor ?? backgroundColor ?? bgColor,
                shape: appBar!.shape,
                backgroundColor:
                    appBar!.backgroundColor ?? backgroundColor ?? bgColor,
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
        drawer: drawer != null && !largeScreen ? drawer : null,
        body: Row(
          children: [
            if (!smallScreen &&
                (!largeScreen || drawer == null) &&
                navigationBar != null)
              NavigationRail(
                useIndicator: true,
                extended:
                    //  (largeScreen && drawer == null) ? true :
                    false,
                minExtendedWidth: 158,
                backgroundColor: backgroundColor ?? bgColor,
                groupAlignment: -0.95,
                leading: floatingActionButton ??
                    (drawer != null && !largeScreen
                        ? const DrawerButton()
                        : appBar?.leading != null
                            ? appBar!.leading
                            : const SizedBox(
                                height: 38,
                              )),
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
                labelType: (largeScreen && drawer == null) ||
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
              )
            else if (!smallScreen && drawer != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: drawer!,
              ),
            Expanded(
              child: Column(
                children: [
                  if (!smallScreen && appBar != null)
                    AppBar(
                      key: appBar!.key,
                      leading: !largeScreen
                          ? drawer != null
                              ? null
                              : appBar!.leading
                          : null,
                      automaticallyImplyLeading:
                          appBar!.automaticallyImplyLeading,
                      title: appBar!.title,
                      actions: appBar!.actions == null
                          ? null
                          : [
                              ...appBar!.actions!,
                              SizedBox(
                                width: safePadding.right > 18
                                    ? safePadding.right + 3
                                    : 18,
                              )
                            ],
                      flexibleSpace: appBar!.flexibleSpace,
                      bottom: appBar!.bottom,
                      elevation: appBar!.elevation,
                      scrolledUnderElevation: appBar!.scrolledUnderElevation,
                      notificationPredicate: appBar!.notificationPredicate,
                      shadowColor: appBar!.shadowColor,
                      surfaceTintColor: appBar!.surfaceTintColor ??
                          backgroundColor ??
                          bgColor,
                      shape: appBar!.shape,
                      backgroundColor:
                          appBar!.backgroundColor ?? backgroundColor ?? bgColor,
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
                            margin: smallScreen
                                ? EdgeInsets.only(
                                    top: extendBodyBehindAppBar
                                        ? safePadding.top > 3
                                            ? safePadding.top
                                            : 3
                                        : 0,
                                    // bottom: navigationBar != null
                                    //     ? 0
                                    //     : safePadding.bottom > 3
                                    //         ? safePadding.bottom
                                    //         : 3,
                                    left: safePadding.left > 5
                                        ? safePadding.left
                                        : 5,
                                    right: safePadding.right > 5
                                        ? safePadding.right
                                        : 5,
                                  )
                                : EdgeInsets.only(
                                    top: extendBodyBehindAppBar
                                        ? safePadding.top > 8
                                            ? safePadding.top
                                            : 8
                                        : 0,
                                    // bottom: safePadding.bottom > 8
                                    //     ? safePadding.bottom
                                    //     : 8,
                                    left: safePadding.left > 18
                                        ? safePadding.left + 3
                                        : 18,
                                    right: safePadding.right > 18
                                        ? safePadding.right + 3
                                        : 18,
                                  ),
                            child: isPageLoading == true
                                ? loadingBody ?? const PageLoadingIndicator()
                                : body,
                          ),
                        ),
                      ],
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
}
