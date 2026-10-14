import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite_app/domain/entities/meal.dart';
import 'package:streetbite_app/l10n/app_localizations.dart';
import 'package:streetbite_app/presentation/blocs/cart_bloc.dart';
import 'package:streetbite_app/presentation/screens/cart_screen.dart';
import 'package:streetbite_app/presentation/screens/grouped_menu_screen.dart';

void main() {
  for (final language in ['en', 'ar']) {
    testWidgets('Menu $language filters live groups and opens the same cart', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(375, 568);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final cart = CartBloc();
      addTearDown(cart.close);
      const meals = [
        Meal(
          id: '1',
          name: 'QA Chicken',
          category: 'Chicken',
          area: '',
          image: '',
          instructions: '',
        ),
        Meal(
          id: '2',
          name: 'QA Dessert',
          category: 'Dessert',
          area: '',
          image: '',
          instructions: '',
        ),
      ];
      await tester.pumpWidget(
        BlocProvider.value(
          value: cart,
          child: MaterialApp(
            locale: Locale(language),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            home: const GroupedMenuScreen(meals: meals),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final chip = find.widgetWithText(ChoiceChip, 'Chicken');
      await tester.scrollUntilVisible(
        chip,
        120,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(chip);
      await tester.pumpAndSettle();
      final l = AppLocalizations.of(
        tester.element(find.byType(GroupedMenuScreen)),
      )!;
      await tester.scrollUntilVisible(
        find.text('QA Chicken'),
        120,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('QA Dessert'), findsNothing);
      await tester.tap(find.byTooltip(l.add));
      await tester.pumpAndSettle();
      expect(cart.state.items.single.meal.id, '1');
      expect(find.text(l.added), findsOneWidget);
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();
      expect(find.byType(CartScreen), findsOneWidget);
      expect(cart.state.count, 1);
      expect(tester.takeException(), isNull);
    });
  }
}
