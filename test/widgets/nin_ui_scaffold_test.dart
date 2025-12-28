import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nin_ui/widgets/nin_ui_scaffold.dart';
import 'package:nin_ui/widgets/page_loading_indicator.dart';

void main() {
  group('NinUiScaffold', () {
    testWidgets('shows NavigationBar on small screens',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: NinUiScaffold(
            body: const Text('Body Content'),
            navigationBar: NavigationBar(
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byType(NavigationRail), findsNothing);
      expect(find.text('Body Content'), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('shows NavigationRail on large screens',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: NinUiScaffold(
            body: const Text('Body Content'),
            navigationBar: NavigationBar(
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(NavigationBar), findsNothing);
      expect(find.byType(NavigationRail), findsOneWidget);
      expect(find.text('Body Content'), findsOneWidget);

      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('shows loading indicator when isPageLoading is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NinUiScaffold(
            body: Text('Body Content'),
            isPageLoading: true,
          ),
        ),
      );

      expect(find.byType(PageLoadingIndicator), findsOneWidget);
      expect(find.text('Body Content'), findsNothing);
    });

    testWidgets('shows custom loading body when provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NinUiScaffold(
            body: Text('Body Content'),
            isPageLoading: true,
            loadingBody: Text('Custom Loading'),
          ),
        ),
      );

      expect(find.text('Custom Loading'), findsOneWidget);
      expect(find.byType(PageLoadingIndicator), findsNothing);
      expect(find.text('Body Content'), findsNothing);
    });
  });
}
