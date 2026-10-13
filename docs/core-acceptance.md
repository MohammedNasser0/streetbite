# Primary functionality acceptance

Latest local Android artifact: **1.0.0 (9)**, development signing. APK SHA256: `5ff43eda0287184b759d80a67c7e1694f98a22baa04c35e2176411dde7d9b917`.

| Primary requirement | Implementation/evidence | Current scope |
|---|---|---|
| Fade onboarding | WelcomeScreen fade-in; genuine emulator capture | Implemented; prior emulator tour |
| Login and persistent auth | Firebase Auth / AuthCubit; three login cases | All three pass on build 9 emulator and physical phone across scoped runs |
| Signup validation / Builder profile | AuthScreen / UserBuilder; numeric-name rejection and successful live signup | Build 3 targeted emulator passes; unchanged auth source |
| Live menu / offers / responsive grid | Dio, PageView, five offers, MediaQuery, MenuCubit | Build 9 scrolling and add-feedback checks pass on emulator and phone |
| Offline metadata cache | Remote/cache factory and shared_preferences | Repository tests pass; build 4 offline restart/cart pass |
| Details and live cart | MealDetailsScreen / shared CartAction / BlocConsumer | Build 9 EN/AR count, feedback and cart-navigation widget tests pass |
| Cart removal / totals | CartBloc / CartScreen / empty-cart listener | Unit/layout tests pass; physical build 5 cart pass |
| Saved favourites | Owner Firestore subcollection / live stream | Build 9 emulator save/restart/remove passes after a locator correction |
| Orders / cash-card strategies | PlaceOrder and separate payment strategies | Build 9 cash checkout/history/restart passes; no real payment or dispatch |
| Profile / gallery / live records | ProfileRepository / singleton FirestoreService | Owner-assisted physical build 4 photo/restart pass |
| English/Arabic and light/dark | ARB, LocaleCubit and ThemeBloc | Compact EN/AR tests pass; prior genuine EN/AR/dark captures |
| Beta distribution | Firebase App Distribution | Build 5 currently distributed to both authorized testers; new artifact pending |

Build 9 analyzer passed, all **27 Flutter tests passed**, and formatting checked across all 75 Dart files with no changes required. Historical passes are not represented as execution on build 9.

Build 9 passed eight unique core emulator scenarios across the main run and a targeted favourites retry. The initial favourites failure was a test locator issue. All five required physical scenarios passed across the main run and two targeted retries after extending the APK-install timeout; two initial setup failures remain in the private reports. A separate emulator screenshot tour passed. These are automated results, not completion of the manual QA matrix.

## Design and optional work

The brief requires faithful Figma coverage. The supplied copy has 15 app frames; remaining differences are listed in `figma-frame-coverage.md`. Full visual fidelity is not certified.

Vendor maps, biometric gating and QA sections are labeled bonus. The brief's completion section nevertheless requests QA artifacts. Existing evidence is retained with its original device/version scope; remaining manual cases stay Not Run. Map-tile diagnosis is deferred by the owner and does not block primary functionality acceptance. Tester acceptance/installation is unverified and is distinct from successful distribution.

No final learning-platform submission has been made. Phone screenshots and original dashboard/Jira evidence are private ZIP content, not public repository assets.
