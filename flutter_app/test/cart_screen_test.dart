import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite_app/domain/entities/meal.dart';
import 'package:streetbite_app/l10n/app_localizations.dart';
import 'package:streetbite_app/presentation/blocs/cart_bloc.dart';
import 'package:streetbite_app/presentation/blocs/cart_event.dart';
import 'package:streetbite_app/presentation/screens/cart_screen.dart';

const meal = Meal(
  id: '2',
  name: 'A long meal name that should wrap instead of hiding quantity actions',
  category: 'Dinner',
  area: 'Egypt',
  image: '',
  instructions: '',
);

void main() {
  test('Decrement updates the total and removes the last unit only', () async {
    final cart = CartBloc();
    addTearDown(cart.close);
    cart.add(AddMeal(meal));
    await cart.stream.firstWhere((s) => s.count == 1);
    cart.add(AddMeal(meal));
    await cart.stream.firstWhere((s) => s.count == 2);
    cart.add(DecreaseMeal(meal.id));
    await cart.stream.firstWhere((s) => s.count == 1);
    expect(cart.state.totalInPiastres, 10500);
    cart.add(DecreaseMeal(meal.id));
    await cart.stream.firstWhere((s) => s.count == 0);
    expect(cart.state.items, isEmpty);
    expect(cart.state.totalInPiastres, 0);
  });

  for (final language in ['en', 'ar']) {
    for (final width in [375.0, 412.0]) {
      testWidgets('Cart quantity controls fit $language at $width', (
        tester,
      ) async {
        tester.view.physicalSize = Size(width, 568);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final cart = CartBloc();
        addTearDown(cart.close);
        cart.add(AddMeal(meal));
        await cart.stream.firstWhere((s) => s.count == 1);
        await tester.pumpWidget(
          BlocProvider.value(
            value: cart,
            child: MaterialApp(
              locale: Locale(language),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              home: const CartScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        final l = AppLocalizations.of(tester.element(find.byType(CartScreen)))!;
        await tester.tap(find.byTooltip(l.increaseQuantity));
        await tester.pumpAndSettle();
        expect(cart.state.count, 2);
        expect(find.text('2'), findsOneWidget);
        expect(cart.state.totalInPiastres, 21000);
        await tester.tap(find.byTooltip(l.decreaseQuantity));
        await tester.pumpAndSettle();
        expect(cart.state.count, 1);
        await tester.tap(find.byTooltip(l.remove));
        await tester.pumpAndSettle();
        expect(cart.state.items, isEmpty);
        expect(find.byType(SnackBar), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    }
  }
}
