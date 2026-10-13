import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite_app/domain/entities/meal.dart';
import 'package:streetbite_app/domain/repositories/meal_repository.dart';
import 'package:streetbite_app/domain/usecases/search_meals.dart';
import 'package:streetbite_app/injection.dart';
import 'package:streetbite_app/l10n/app_localizations.dart';
import 'package:streetbite_app/presentation/screens/browse_screen.dart';

class FlakyMeals implements MealRepository {
  final queries = <String>[];
  bool failed = false;
  @override
  Future<List<Meal>> search(String query) async {
    queries.add(query);
    if (query.isEmpty) return [];
    if (!failed) {
      failed = true;
      throw Exception('simulated connection loss');
    }
    return [
      const Meal(
        id: '1',
        name: 'Chicken',
        category: 'Chicken',
        area: 'Egypt',
        image: '',
        instructions: '',
      ),
    ];
  }
}

void main() {
  for (final language in ['en', 'ar']) {
    testWidgets(
      'Browse $language retries the failed query and keeps the input',
      (tester) async {
        final repo = FlakyMeals();
        services.registerSingleton<SearchMeals>(SearchMeals(repo));
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
        await tester.enterText(find.byType(TextField), 'chicken');
        await tester.testTextInput.receiveAction(TextInputAction.search);
        await tester.pumpAndSettle();
        expect(find.byType(FilledButton), findsOneWidget);
        await tester.tap(find.byType(FilledButton));
        await tester.pumpAndSettle();
        expect(repo.queries, ['', 'chicken', 'chicken']);
        expect(find.text('chicken'), findsOneWidget);
        expect(find.text('Chicken'), findsWidgets);
        expect(find.byType(FilledButton), findsNothing);
        expect(tester.takeException(), isNull);
      },
    );
  }
}
