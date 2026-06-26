import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nin_ui/widgets/content_card.dart';
import 'package:nin_ui/widgets/expanded_list_tile_card.dart';
import 'package:nin_ui/widgets/list_tile_card.dart';

void main() {
  group('ExpandedListTileCard TileListPosition & BorderRadius Tests', () {
    testWidgets('BorderRadius in collapsed state matches position', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpandedListTileCard(
              position: TileListPosition.top,
              isExpanded: false,
              title: Text('Collapsed Top'),
              children: [
                Text('Child 1'),
              ],
            ),
          ),
        ),
      );

      final contentCardFinder = find.byType(ContentCard);
      expect(contentCardFinder, findsOneWidget);
      final contentCard = tester.widget<ContentCard>(contentCardFinder);

      // Collapsed top should have top-only rounded corners:
      // topLeft: 13, topRight: 13, bottomLeft: 3, bottomRight: 3
      expect(
        contentCard.borderRadius,
        const BorderRadius.only(
          topLeft: Radius.circular(13),
          topRight: Radius.circular(13),
          bottomLeft: Radius.circular(3),
          bottomRight: Radius.circular(3),
        ),
      );
    });

    testWidgets('BorderRadius in expanded state does not match position (is same as now)', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpandedListTileCard(
              position: TileListPosition.top,
              isExpanded: true,
              title: Text('Expanded Top'),
              children: [
                Text('Child 1'),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final contentCardFinder = find.byType(ContentCard);
      expect(contentCardFinder, findsOneWidget);
      final contentCard = tester.widget<ContentCard>(contentCardFinder);

      // When expanded, the border radius must be same as now (default/null passed to ContentCard).
      expect(contentCard.borderRadius, isNull);
    });

    testWidgets('Custom BorderRadius is preserved in both collapsed and expanded states', (WidgetTester tester) async {
      const customRadius = BorderRadius.all(Radius.circular(25));

      // Collapsed state with custom radius
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpandedListTileCard(
              position: TileListPosition.top,
              borderRadius: customRadius,
              isExpanded: false,
              title: Text('Collapsed Custom'),
              children: [
                Text('Child 1'),
              ],
            ),
          ),
        ),
      );

      var contentCardFinder = find.byType(ContentCard);
      var contentCard = tester.widget<ContentCard>(contentCardFinder);
      expect(contentCard.borderRadius, customRadius);

      // Expanded state with custom radius
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpandedListTileCard(
              position: TileListPosition.top,
              borderRadius: customRadius,
              isExpanded: true,
              title: Text('Expanded Custom'),
              children: [
                Text('Child 1'),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      contentCardFinder = find.byType(ContentCard);
      contentCard = tester.widget<ContentCard>(contentCardFinder);
      expect(contentCard.borderRadius, customRadius);
    });
  });
}
