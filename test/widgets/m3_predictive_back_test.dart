import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nin_ui/widgets/m3_predictive_back.dart';

void main() {
  group('M3PredictiveBack Widgets', () {
    testWidgets('M3PredictiveBackPage renders child at rest',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: M3PredictiveBackPage(
            child: Scaffold(
              body: Text('Page Content'),
            ),
          ),
        ),
      );

      expect(find.text('Page Content'), findsOneWidget);
    });

    testWidgets('M3PredictiveBackDialog renders child at rest',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: M3PredictiveBackDialog(
              child: Text('Dialog Content'),
            ),
          ),
        ),
      );

      expect(find.text('Dialog Content'), findsOneWidget);
    });

    testWidgets('M3PredictiveBackSheet renders child at rest',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: M3PredictiveBackSheet(
              child: Text('Sheet Content'),
            ),
          ),
        ),
      );

      expect(find.text('Sheet Content'), findsOneWidget);
    });
  });
}
