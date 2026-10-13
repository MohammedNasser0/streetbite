import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite_app/domain/entities/meal.dart';
import 'package:streetbite_app/l10n/app_localizations.dart';
import 'package:streetbite_app/presentation/blocs/cart_bloc.dart';
import 'package:streetbite_app/presentation/screens/cart_screen.dart';
import 'package:streetbite_app/presentation/screens/meal_details_screen.dart';

void main() {
  for (final language in ['en', 'ar']) {
    testWidgets('Details $language updates count and opens the same cart', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(375, 568);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final cart = CartBloc();
      addTearDown(cart.close);
      const meal = Meal(
        id: '2',
        name: 'Flan',
        category: 'Dessert',
        area: 'Egypt',
        image: '',
        instructions: 'Demo instructions',
      );
      await tester.pumpWidget(
        BlocProvider.value(
          value: cart,
          child: MaterialApp(
            locale: Locale(language),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            home: const MealDetailsScreen(meal),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final l = AppLocalizations.of(
        tester.element(find.byType(MealDetailsScreen)),
      )!;
      expect(find.text('0'), findsOneWidget);
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();
      expect(cart.state.count, 1);
      expect(find.text('1'), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text(l.added), findsOneWidget);
      await tester.tap(find.byTooltip(l.cart));
      await tester.pumpAndSettle();
      expect(find.byType(CartScreen), findsOneWidget);
      expect(cart.state.items.single.meal.id, meal.id);
      expect(tester.takeException(), isNull);
    });
  }
}
