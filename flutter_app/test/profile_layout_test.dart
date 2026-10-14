import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite_app/domain/entities/app_user.dart';
import 'package:streetbite_app/domain/entities/meal.dart';
import 'package:streetbite_app/domain/entities/placed_order.dart';
import 'package:streetbite_app/domain/repositories/auth_repository.dart';
import 'package:streetbite_app/domain/repositories/profile_repository.dart';
import 'package:streetbite_app/injection.dart';
import 'package:streetbite_app/l10n/app_localizations.dart';
import 'package:streetbite_app/presentation/blocs/auth_cubit.dart';
import 'package:streetbite_app/presentation/blocs/cart_bloc.dart';
import 'package:streetbite_app/presentation/screens/profile_screen.dart';

const qaUser = AppUser(
  id: 'qa',
  name: 'StreetBite QA',
  email: 'qa@example.test',
);

class TestAuth implements AuthRepository {
  @override
  Stream<AppUser?> get changes => Stream.value(qaUser);
  @override
  Future<void> login(String email, String password) async {}
  @override
  Future<void> signup(String name, String email, String password) async {}
  @override
  Future<void> logout() async {}
}

class TestProfile implements ProfileRepository {
  @override
  Stream<AppUser> watchProfile(String uid) => Stream.value(qaUser);
  @override
  Stream<List<Meal>> watchFavourites(String uid) => Stream.value([]);
  @override
  Stream<List<PlacedOrder>> watchOrders(String uid) => Stream.value([]);
  @override
  Future<void> savePhoto(String uid, String photo) async {}
  @override
  Future<void> saveFavourite(String uid, Meal meal, bool saved) async {}
}

void main() {
  for (final language in ['en', 'ar']) {
    testWidgets(
      'Profile $language respects mocked biometric result and fits support rows',
      (tester) async {
        tester.view.physicalSize = const Size(375, 568);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        debugDefaultTargetPlatformOverride = TargetPlatform.linux;
        addTearDown(() => debugDefaultTargetPlatformOverride = null);
        const channel = MethodChannel('plugins.flutter.io/local_auth');
        var allow = false;
        tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          channel,
          (call) async {
            expect(call.method, 'authenticate');
            expect((call.arguments as Map)['biometricOnly'], isTrue);
            return allow;
          },
        );
        addTearDown(
          () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
            channel,
            null,
          ),
        );
        final auth = AuthCubit(TestAuth());
        final cart = CartBloc();
        addTearDown(auth.close);
        addTearDown(cart.close);
        services.registerSingleton<AuthCubit>(auth);
        services.registerSingleton<ProfileRepository>(TestProfile());
        addTearDown(services.reset);
        await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider.value(value: auth),
              BlocProvider.value(value: cart),
            ],
            child: MaterialApp(
              locale: Locale(language),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              home: const ProfileScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();
        final l = AppLocalizations.of(
          tester.element(find.byType(ProfileScreen)),
        )!;
        await tester.tap(find.byType(FilledButton));
        await tester.pumpAndSettle();
        expect(find.text(qaUser.email), findsNothing);
        allow = true;
        await tester.tap(find.byType(FilledButton));
        await tester.pumpAndSettle();
        expect(find.text(qaUser.email), findsOneWidget);
        await tester.scrollUntilVisible(
          find.text(l.helpCenter),
          100,
          scrollable: find.byType(Scrollable).first,
        );
        expect(find.text(l.settingsTitle), findsOneWidget);
        expect(find.text(l.contactUs), findsOneWidget);
        expect(find.text(l.helpCenter), findsOneWidget);
        expect(tester.takeException(), isNull);
        debugDefaultTargetPlatformOverride = null;
      },
    );
  }
}
