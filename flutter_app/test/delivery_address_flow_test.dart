import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite_app/injection.dart';
import 'package:streetbite_app/l10n/app_localizations.dart';
import 'package:streetbite_app/presentation/blocs/cart_bloc.dart';
import 'package:streetbite_app/presentation/blocs/delivery_address_cubit.dart';
import 'package:streetbite_app/presentation/screens/checkout_screen.dart';
import 'package:streetbite_app/presentation/widgets/delivery_address_header.dart';

void main() {
  for (final language in ['en', 'ar']) {
    testWidgets(
      'Address $language shares an edited draft and clears active Checkout',
      (tester) async {
        tester.view.physicalSize = const Size(375, 568);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final draft = DeliveryAddressCubit();
        services.registerSingleton<DeliveryAddressCubit>(draft);
        addTearDown(services.reset);
        addTearDown(draft.close);
        final cart = CartBloc();
        addTearDown(cart.close);
        await tester.pumpWidget(
          BlocProvider.value(
            value: cart,
            child: MaterialApp(
              locale: Locale(language),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              home: Builder(
                builder: (context) => Scaffold(
                  body: Column(
                    children: [
                      const DeliveryAddressHeader(),
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CheckoutScreen(),
                          ),
                        ),
                        child: const Text('Open Checkout'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byType(ListTile));
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byType(TextFormField).first,
          'QA Street 13',
        );
        tester.testTextInput.hide();
        await tester.scrollUntilVisible(
          find.byType(FilledButton),
          180,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.tap(find.byType(FilledButton));
        await tester.pumpAndSettle();
        expect(find.text('QA Street 13'), findsOneWidget);
        await tester.tap(find.text('Open Checkout'));
        await tester.pumpAndSettle();
        expect(find.text('QA Street 13'), findsOneWidget);
        await tester.tap(find.text('QA Street 13'));
        await tester.pumpAndSettle();
        expect(
          tester
              .widget<TextFormField>(find.byType(TextFormField).first)
              .controller!
              .text,
          'QA Street 13',
        );
        await tester.binding.handlePopRoute();
        await tester.pumpAndSettle();
        expect(draft.state?['address'], 'QA Street 13');
        draft.clear();
        await tester.pumpAndSettle();
        expect(find.text('QA Street 13'), findsNothing);
        expect(tester.takeException(), isNull);
      },
    );
  }
}
