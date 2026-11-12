import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nin_ui/widgets/m3_open_container.dart';

void main() {
  group('M3OpenContainer', () {
    testWidgets('renders closed builder at rest', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: M3OpenContainer(
              closedBuilder: (context, openContainer) {
                return const Text('Closed Card');
              },
              openBuilder: (context, closeContainer) {
                return const Text('Opened Screen');
              },
            ),
          ),
        ),
      );

      expect(find.text('Closed Card'), findsOneWidget);
      expect(find.text('Opened Screen'), findsNothing);
    });

    testWidgets('tapping closed builder opens the container route',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: M3OpenContainer(
              closedBuilder: (context, openContainer) {
                return GestureDetector(
                  onTap: openContainer,
                  child: const Text('Open Me'),
                );
              },
              openBuilder: (context, closeContainer) {
                return Scaffold(
                  body: Center(
                    child: ElevatedButton(
                      onPressed: closeContainer,
                      child: const Text('Close Me'),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('Open Me'), findsOneWidget);
      expect(find.text('Close Me'), findsNothing);

      // Tap to open
      await tester.tap(find.text('Open Me'));
      await tester.pumpAndSettle();

      expect(find.text('Close Me'), findsOneWidget);

      // Tap to close
      await tester.tap(find.text('Close Me'));
      await tester.pumpAndSettle();

      expect(find.text('Open Me'), findsOneWidget);
      expect(find.text('Close Me'), findsNothing);
    });
  });
}
