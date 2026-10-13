import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite_app/domain/entities/meal.dart';
import 'package:streetbite_app/l10n/app_localizations.dart';
import 'package:streetbite_app/presentation/blocs/cart_bloc.dart';
import 'package:streetbite_app/presentation/blocs/cart_event.dart';
import 'package:streetbite_app/presentation/screens/checkout_screen.dart';
import 'package:streetbite_app/presentation/screens/demo_card_screen.dart';

void main() {
  for (final language in ['en', 'ar']) {
    testWidgets(
      'Checkout $language keeps action visible and cancels card safely',
      (tester) async {
        tester.view.physicalSize = const Size(375, 568);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final cart = CartBloc();
        addTearDown(cart.close);
        await tester.pumpWidget(
          BlocProvider.value(
            value: cart,
            child: MaterialApp(
              locale: Locale(language),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              home: const CheckoutScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(
          tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
          isNull,
        );
        cart.add(
          AddMeal(
            const Meal(
              id: '2',
              name: 'Flan',
              category: 'Dessert',
              area: 'Egypt',
              image: '',
              instructions: '',
            ),
          ),
        );
        await tester.pumpAndSettle();
        final action = find.byType(FilledButton);
        expect(tester.widget<FilledButton>(action).onPressed, isNotNull);
        expect(tester.getRect(action).bottom, lessThanOrEqualTo(568));
        final dropdown = find.byType(DropdownButton<String>);
        await tester.scrollUntilVisible(
          dropdown,
          120,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.pumpAndSettle();
        await tester.tap(dropdown);
        await tester.pumpAndSettle();
        await tester.tap(
          find
              .text(
                language == 'ar' ? 'دفع تجريبي بالبطاقة' : 'Demo card payment',
              )
              .last,
        );
        await tester.pumpAndSettle();
        expect(find.byType(DemoCardScreen), findsOneWidget);
        await tester.binding.handlePopRoute();
        await tester.pumpAndSettle();
        expect(tester.widget<DropdownButton<String>>(dropdown).value, 'cash');
        expect(tester.takeException(), isNull);
      },
    );
  }
}
