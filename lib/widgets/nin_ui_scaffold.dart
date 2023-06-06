import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nin_ui/nin_ui.dart';

class NinUiScaffold extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final NavigationBar? navigationBar;
  const NinUiScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.drawer,
    this.floatingActionButton,
    this.navigationBar,
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

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: iconBrightness,
        systemNavigationBarColor: bgColor,
        systemNavigationBarIconBrightness: iconBrightness,
      ),
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: appBar == null
            ? null
            : AppBar(
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
              ),
        drawer: drawer,
        body: Row(
          children: [
            if (!isSmallScreen && navigationBar != null)
              NavigationRail(
                useIndicator: true,
                extended: false,
                backgroundColor: bgColor,
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
                labelType: navigationBar!.labelBehavior ==
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
            Expanded(child: ContentCard(child: body)),
          ],
        ),
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: navigationBar != null && isSmallScreen
            ? NavigationBar(
                key: navigationBar!.key,
                destinations: navigationBar!.destinations,
                selectedIndex: navigationBar!.selectedIndex,
                onDestinationSelected: navigationBar!.onDestinationSelected,
                backgroundColor: navigationBar!.backgroundColor ?? bgColor,
                elevation: navigationBar!.elevation ?? 0,
                labelBehavior: navigationBar!.labelBehavior,
              )
            : null,
      ),
    );
  }
}
