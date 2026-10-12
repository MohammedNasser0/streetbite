import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite_app/data/models/order_model.dart';
import 'package:streetbite_app/l10n/app_localizations.dart';
import 'package:streetbite_app/presentation/widgets/order_history_tile.dart';

void main() {
  test('Historical orders without thumbnails still decode', () {
    final order = OrderModel.fromJson({
      'id': 'old',
      'items': [
        {'name': 'Flan', 'quantity': 2},
      ],
      'totalInPiastres': 21000,
    });
    expect(order.image, isEmpty);
    expect(order.mealNames, ['Flan']);
    expect(order.createdAt, isNull);
  });
  test('Order thumbnail and timestamp survive model round trip', () {
    final order = OrderModel.fromJson({
      'id': 'new',
      'createdAt': '2026-10-12T09:00:00Z',
      'items': [
        {'name': 'Flan', 'image': 'https://example.com/flan.png'},
      ],
    });
    final decoded = OrderModel.fromJson(order.toJson());
    expect(decoded.image, order.image);
    expect(decoded.createdAt, order.createdAt);
  });
  for (final language in ['en', 'ar']) {
    testWidgets('Compact $language order remains readable and tappable', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(375, 568);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      var opened = false;
      final order = OrderModel.fromJson({
        'items': [
          {
            'name': 'A very long meal name repeated for a narrow order history card',
          },
        ],
        'createdAt': '2026-10-12T09:00:00Z',
        'totalInPiastres': 21000,
      });
      await tester.pumpWidget(
        MaterialApp(
          locale: Locale(language),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: ListView(
              children: [
                OrderHistoryTile(order: order, onTap: () => opened = true),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.byIcon(Icons.receipt_long), findsOneWidget);
      await tester.tap(find.byType(OrderHistoryTile));
      expect(opened, isTrue);
    });
  }
}
