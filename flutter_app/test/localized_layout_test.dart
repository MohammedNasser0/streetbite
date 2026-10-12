import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite_app/l10n/app_localizations.dart';
import 'package:streetbite_app/presentation/screens/delivery_address_screen.dart';
import 'package:streetbite_app/presentation/screens/demo_card_screen.dart';

void main() {
  for (final locale in ['en', 'ar']) {
    for (final width in [375.0, 412.0]) {
      testWidgets('Demo card is read-only and fits $locale at width $width', (
        tester,
      ) async {
        tester.view.physicalSize = Size(width, 568);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await tester.pumpWidget(
          MaterialApp(
            locale: Locale(locale),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            home: Builder(
              builder: (context) {
                return Scaffold(
                  body: FilledButton(
                    onPressed: () async {
                      final selected = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DemoCardScreen(),
                        ),
                      );
                      if (context.mounted && selected == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('selected')),
                        );
                      }
                    },
                    child: const Text('open'),
                  ),
                );
              },
            ),
          ),
        );
        await tester.tap(find.text('open'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(find.byType(EditableText), findsNothing);
        expect(find.text('•••• •••• •••• 4242'), findsOneWidget);
        expect(
          Directionality.of(tester.element(find.byType(ListView))),
          locale == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        );
        await tester.tap(find.byType(FilledButton).last);
        await tester.pumpAndSettle();
        expect(find.text('selected'), findsOneWidget);
      });
      testWidgets('Delivery form fits $locale at width $width', (tester) async {
        tester.view.physicalSize = Size(width, 812);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await tester.pumpWidget(
          MaterialApp(
            locale: Locale(locale),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            home: const DeliveryAddressScreen(),
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(
          Directionality.of(tester.element(find.byType(Form))),
          locale == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        );
        await tester.ensureVisible(find.byType(FilledButton));
        await tester.tap(find.byType(FilledButton));
        await tester.pumpAndSettle();
        expect(find.byType(DeliveryAddressScreen), findsOneWidget);
        expect(
          find.text(
            locale == 'ar'
                ? 'أدخل عنوان توصيل كاملًا'
                : 'Enter a complete delivery address',
          ),
          findsOneWidget,
        );
      });
    }
  }
}
