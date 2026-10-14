import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite_app/core/project_info.dart';
import 'package:streetbite_app/domain/entities/meal.dart';
import 'package:streetbite_app/domain/repositories/meal_repository.dart';
import 'package:streetbite_app/domain/usecases/search_meals.dart';
import 'package:streetbite_app/injection.dart';
import 'package:streetbite_app/l10n/app_localizations.dart';
import 'package:streetbite_app/presentation/screens/browse_screen.dart';
import 'package:streetbite_app/presentation/screens/contact_screen.dart';
import 'package:streetbite_app/presentation/screens/help_center_screen.dart';
import 'package:streetbite_app/presentation/screens/orders_screen.dart';
import 'package:streetbite_app/presentation/widgets/app_navigation_bar.dart';
import 'package:streetbite_app/presentation/widgets/support_links.dart';

class EmptyMeals implements MealRepository {
  @override
  Future<List<Meal>> search(String query) async => [];
}

void main() {
  for (final language in ['en', 'ar']) {
    testWidgets(
      'Support $language opens help and copies only the public project link',
      (tester) async {
        tester.view.physicalSize = const Size(375, 568);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        String? copied;
        tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          (call) async {
            if (call.method == 'Clipboard.setData') {
              copied = (call.arguments as Map)['text'] as String;
            }
            return null;
          },
        );
        addTearDown(
          () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
            SystemChannels.platform,
            null,
          ),
        );
        await tester.pumpWidget(
          MaterialApp(
            locale: Locale(language),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            home: const Scaffold(
              body: Padding(padding: EdgeInsets.all(20), child: SupportLinks()),
            ),
          ),
        );
        await tester.pumpAndSettle();
        final l = AppLocalizations.of(
          tester.element(find.byType(SupportLinks)),
        )!;
        await tester.tap(find.text(l.helpCenter));
        await tester.pumpAndSettle();
        expect(find.byType(HelpCenterScreen), findsOneWidget);
        await tester.tap(find.text(l.helpDemoTitle));
        await tester.pumpAndSettle();
        expect(find.text(l.helpDemoBody), findsOneWidget);
        await tester.binding.handlePopRoute();
        await tester.pumpAndSettle();
        await tester.tap(find.text(l.contactUs));
        await tester.pumpAndSettle();
        expect(find.byType(ContactScreen), findsOneWidget);
        await tester.tap(find.text(l.copyProjectLink));
        await tester.pumpAndSettle();
        expect(copied, projectRepositoryUrl);
        expect(find.text(l.linkCopied), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
    testWidgets(
      'Navigation $language switches sections and returns to the original Home',
      (tester) async {
        tester.view.physicalSize = const Size(375, 568);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        services.registerSingleton<SearchMeals>(SearchMeals(EmptyMeals()));
        addTearDown(services.reset);
        await tester.pumpWidget(
          MaterialApp(
            locale: Locale(language),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            home: const Scaffold(
              body: Text('Home root'),
              bottomNavigationBar: AppNavigationBar(selectedIndex: 0),
            ),
          ),
        );
        await tester.pumpAndSettle();
        final l = AppLocalizations.of(
          tester.element(find.byType(AppNavigationBar)),
        )!;
        await tester.tap(find.text(l.browse));
        await tester.pumpAndSettle();
        expect(find.byType(BrowseScreen), findsOneWidget);
        await tester.tap(find.text(l.orders));
        await tester.pumpAndSettle();
        expect(find.byType(OrdersScreen), findsOneWidget);
        await tester.binding.handlePopRoute();
        await tester.pumpAndSettle();
        expect(find.text('Home root'), findsOneWidget);
        expect(find.byType(BrowseScreen), findsNothing);
        await tester.tap(find.text(l.profile));
        await tester.pumpAndSettle();
        await tester.tap(find.text(l.home));
        await tester.pumpAndSettle();
        expect(find.text('Home root'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  }
}
