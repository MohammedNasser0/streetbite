import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite_app/domain/entities/meal.dart';
import 'package:streetbite_app/domain/repositories/meal_repository.dart';
import 'package:streetbite_app/domain/usecases/search_meals.dart';
import 'package:streetbite_app/injection.dart';
import 'package:streetbite_app/l10n/app_localizations.dart';
import 'package:streetbite_app/presentation/screens/browse_screen.dart';
import 'package:streetbite_app/presentation/widgets/category_tiles.dart';

class CategoryMeals implements MealRepository {
  @override
  Future<List<Meal>> search(String query) async => const [
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
}

void main() {
  for (final language in ['en', 'ar']) {
    testWidgets(
      'Browse $language category tiles filter and return to categories',
      (tester) async {
        tester.view.physicalSize = Size(language == 'en' ? 375 : 412, 568);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        services.registerSingleton<SearchMeals>(SearchMeals(CategoryMeals()));
        addTearDown(services.reset);
        await tester.pumpWidget(
          MaterialApp(
            locale: Locale(language),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            home: const BrowseScreen(),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(CategoryTiles), findsOneWidget);
        await tester.tap(find.text('Chicken'));
        await tester.pumpAndSettle();
        expect(find.text('QA Chicken'), findsOneWidget);
        expect(find.text('QA Dessert'), findsNothing);
        final l = AppLocalizations.of(
          tester.element(find.byType(BrowseScreen)),
        )!;
        await tester.tap(find.widgetWithText(TextButton, l.categories));
        await tester.pumpAndSettle();
        expect(find.byType(CategoryTiles), findsOneWidget);
        expect(find.text('Dessert'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  }
}
