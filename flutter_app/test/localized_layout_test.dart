import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite_app/l10n/app_localizations.dart';
import 'package:streetbite_app/presentation/screens/delivery_address_screen.dart';

void main() {
  for (final locale in ['en', 'ar']) {
    for (final width in [375.0, 412.0]) {
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
