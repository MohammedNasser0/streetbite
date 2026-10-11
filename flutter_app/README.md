# StreetBite Flutter application

A work-in-progress bilingual Flutter food discovery and demo ordering app.

## Implemented locally

- TheMealDB search with Dio timeouts, friendly error state and versioned offline cache.
- Two-column meal grid, featured PageView, five hot-offer items and meal details.
- CartBloc quantity/total updates, removal, snackbar feedback and demo checkout.
- English/Arabic ARB resources with RTL and persisted language/theme settings.
- Firebase AuthCubit, profile Builder, Firestore favourites/orders/profile gateway.
- Gallery thumbnail upload, biometric profile gate and device details.
- Vendor map screen with five illustrative locations; a Maps key is still required.

## Run

```sh
flutter pub get
flutter gen-l10n
flutter run
```

The Android Firebase application is registered to the dedicated `streetbite-6dd3c` project. Runtime options live in `lib/core/firebase_options.dart`. These app identifiers are public configuration; authorization must come from deployed Firestore rules. Firebase Auth email/password enablement and live CRUD still require verification. Web/iOS Firebase registrations are pending.

TheMealDB development key `1` is for educational use. Production app-store publication requires the appropriate API plan. Prices, payment authorization and vendor locations are demonstration data.

## Architecture

Data sources/repositories, domain entities/contracts/use cases, and presentation blocs/screens/widgets are separated. Factory selects remote/cache sources; Builder constructs profiles; Singleton centralizes Firestore; payment strategies share a contract. Profile/order integration still needs further repository/use-case extraction before strict Clean Architecture acceptance.

## Permissions

Android: internet and biometric permission, FragmentActivity host. Gallery uses the system picker. iOS: photo-library and Face ID usage descriptions. Maps must be configured separately for each platform; enable `MAPS_CONFIGURED` only after supplying valid SDK keys.

## Validation

```sh
dart format lib test
flutter analyze
flutter test
flutter build web
flutter build apk --release
```

Recorded so far: analyzer passes; two unit tests pass. Real-device QA, Firebase security-rule tests, Appium execution, full Figma matching, release signing, App Distribution and tester acceptance are pending. See `../docs/delivery-checklist.md`. Do not submit this as a completed capstone yet.
