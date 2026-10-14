# Build 13 review checkpoint — 14 October 2026

Final Android 1.0.0 (13), SHA256 `318b20bf2526d994377d4df2e9b4f43058029be8ddc361f24797b111454a95b3`. All 43 Flutter tests and analyzer pass. Four final emulator cases and six physical cases passed across scoped runs, including owner-assisted fingerprint/profile. Gallery/photo/restart retains build 4 scope. Firebase release 1p7qp7hs4ct48 distributed to two authorized testers. Seven-slide build13 deck finalized and visually reviewed. STREET-3 fixed and verified Done. Private phone screenshots remain ZIP-only. Manual matrix: 43 cases, 2 Pass and 41 Not Run; Figma fidelity remains partial, Maps bonus deferred, tester acceptance unverified. No final Sprints submission. Earlier checkpoints below retain their original scopes.
# Build 12 checkpoint — 14 October 2026

Localized Contact/Help, Profile settings/support rows and shared section navigation are implemented. 35 Flutter tests and analyzer pass; native guest navigation/support/clipboard passes46s. The same APK is distributed to two testers. Historical authenticated/physical scopes below are unchanged.

# Build 11 Browse acceptance — 14 October 2026

Browse failure recovery preserves the query and text input. All 31 Flutter tests pass; analyzer is clean. Native emulator offline→online retry passed, and the same APK was distributed to both authorized testers, release `3clm3j8ki2bng`. Final APK SHA256 `e596c3ff1b5897f3a18e121f53d4f5f310f6158f7158405bf5573398c2125a8f`. Packaging verifies APK versionName/versionCode against committed pubspec and keeps only the matching build presentation. Historical device scopes below are unchanged.

# Build 10 Checkout acceptance — 14 October 2026

Checkout now has separate address/apartment, instructions and account contact rows, a controlled cash/demo-card selector, fixed total/order action, empty-cart prevention and localized title/demo notice. Compact EN/AR tests verify the action remains visible and cancelling a demo card preserves cash selection. Final emulator checkout/history/restart and screenshot tour passed; analyzer is clean. Full physical scenario evidence remains build 9. Final APK SHA256: `549280bd7c069657573bc40c3609c31d647246432198a5cb04f2fb1a0949bb5b`.

The table below retains the build 9 primary acceptance baseline.

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
| Beta distribution | Firebase App Distribution | Build 9 uploaded and distributed to both authorized testers on 14 October 2026 |

Build 9 analyzer passed, all **27 Flutter tests passed**, and formatting checked across all 75 Dart files with no changes required. Historical passes are not represented as execution on build 9.

Build 9 passed eight unique core emulator scenarios across the main run and a targeted favourites retry. The initial favourites failure was a test locator issue. All five required physical scenarios passed across the main run and two targeted retries after extending the APK-install timeout; two initial setup failures remain in the private reports. A separate emulator screenshot tour passed. These are automated results, not completion of the manual QA matrix.

## Design and optional work

The brief requires faithful Figma coverage. The supplied copy has 15 app frames; remaining differences are listed in `figma-frame-coverage.md`. Full visual fidelity is not certified.

Vendor maps, biometric gating and QA sections are labeled bonus. The brief's completion section nevertheless requests QA artifacts. Existing evidence is retained with its original device/version scope; remaining manual cases stay Not Run. Map-tile diagnosis is deferred by the owner and does not block primary functionality acceptance. Tester acceptance/installation is unverified and is distinct from successful distribution.

No final learning-platform submission has been made. Phone screenshots and original dashboard/Jira evidence are private ZIP content, not public repository assets.
