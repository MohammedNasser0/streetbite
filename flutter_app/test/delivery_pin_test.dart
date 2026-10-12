import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite_app/l10n/app_localizations.dart';
import 'package:streetbite_app/presentation/screens/delivery_address_screen.dart';
import 'package:streetbite_app/presentation/widgets/delivery_pin_map.dart';

void main() {
  test(
    'Invalid or incomplete persisted coordinates do not create a map pin',
    () {
      for (final address in [
        <String, String>{},
        {'latitude': '30'},
        {'latitude': 'NaN', 'longitude': '31'},
        {'latitude': '91', 'longitude': '31'},
        {'latitude': '30', 'longitude': '181'},
      ]) {
        expect(DeliveryPinMap.fromAddress(address), isNull);
      }
    },
  );
  testWidgets('Editing an existing address preserves its selected pin', (
    tester,
  ) async {
    Map<String, String>? result;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async {
                result = await Navigator.push<Map<String, String>>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DeliveryAddressScreen(
                      initial: {
                        'address': 'QA Test Street',
                        'latitude': '30.04',
                        'longitude': '31.23',
                      },
                    ),
                  ),
                );
              },
              child: const Text('edit'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('edit'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextFormField).first,
      'QA Updated Street',
    );
    tester.testTextInput.hide();
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.byType(FilledButton),
      180,
      scrollable: find
          .descendant(
            of: find.byType(ListView),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();
    expect(result?['address'], 'QA Updated Street');
    expect(result?['latitude'], '30.04');
    expect(result?['longitude'], '31.23');
    expect(tester.takeException(), isNull);
  });
}
