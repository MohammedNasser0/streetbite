import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'core/firebase_setup.dart';
import 'core/services/firestore_service.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'presentation/blocs/auth_cubit.dart';
import 'presentation/blocs/auth_state.dart';
import 'presentation/blocs/cart_event.dart';
import 'domain/repositories/profile_repository.dart';
import 'domain/repositories/order_repository.dart';
import 'domain/usecases/place_order.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'data/repositories/order_repository_impl.dart';

import 'domain/usecases/search_meals.dart';
import 'injection.dart';
import 'l10n/app_localizations.dart';
import 'presentation/blocs/cart_bloc.dart';
import 'presentation/blocs/delivery_address_cubit.dart';
import 'presentation/blocs/locale_cubit.dart';
import 'presentation/blocs/menu_cubit.dart';
import 'presentation/blocs/theme_bloc.dart';
import 'presentation/screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  if (await initializeFirebase()) {
    final store = FirestoreService.instance(FirebaseFirestore.instance);
    services.registerSingleton<FirestoreService>(store);
    services.registerSingleton<ProfileRepository>(ProfileRepositoryImpl(store));
    services.registerSingleton<OrderRepository>(OrderRepositoryImpl(store));
    services.registerFactory(() => PlaceOrder(services<OrderRepository>()));
    services.registerSingleton<AuthCubit>(
      AuthCubit(AuthRepositoryImpl(FirebaseAuth.instance, store)),
    );
  }
  runApp(const StreetBiteApp());
}

class StreetBiteApp extends StatelessWidget {
  const StreetBiteApp({super.key});
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      if (services.isRegistered<AuthCubit>())
        BlocProvider.value(value: services<AuthCubit>()),
      BlocProvider(create: (_) => ThemeBloc(services<SharedPreferences>())),
      BlocProvider(create: (_) => LocaleCubit(services<SharedPreferences>())),
      BlocProvider(create: (_) => CartBloc()),
      BlocProvider(
        create: (_) => MenuCubit(services<SearchMeals>())..search(''),
      ),
    ],
    child: MultiBlocListener(
      listeners: [
        if (services.isRegistered<AuthCubit>())
          BlocListener<AuthCubit, AuthState>(
            listenWhen: (previous, next) => previous.user?.id != next.user?.id,
            listener: (context, state) {
              context.read<CartBloc>().add(ClearCart());
              services<DeliveryAddressCubit>().clear();
            },
          ),
      ],
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: context.watch<LocaleCubit>().state,
          themeMode: context.watch<ThemeBloc>().state,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF00C874),
            ),
            scaffoldBackgroundColor: Colors.white,
            filledButtonTheme: FilledButtonThemeData(
              style: FilledButton.styleFrom(minimumSize: const Size(0, 52)),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF00C874),
              brightness: Brightness.dark,
            ),
          ),
          home: const WelcomeScreen(),
        ),
      ),
    ),
  );
}
