# Saved work — 12 October 2026

Work paused at the user's request when the five-hour Codex usage window reached 93%.

## Completed
- Separate Flutter application, Android/iOS/web scaffolding, dedicated Firebase Android registration.
- Live meals, versioned cache fallback, cart, bilingual themes, authentication flow, favourites/profile/order repositories, demo checkout, address and order acknowledgement screens.
- Firestore ownership rules deployed to `streetbite-6dd3c`.
- Six unit tests passed: models/cart, cache fallback/corruption, valid/invalid orders.
- Analyzer passed before the most recent small UI/device/test changes.
- Appium Java project compiled; five scenarios authored but not executed.
- QA plan, manual cases, traceability and draft closure report written.
- Public GitHub repository created: https://github.com/MohammedNasser0/streetbite-capstone

## Resume first
1. Re-run formatter, analyzer and all tests. Four new localized-layout widget tests have not run yet.
2. Rebuild Android with `flutter build apk --release --dart-define=MAPS_CONFIGURED=true`. Kotlin cross-drive cache issue was addressed in gradle.properties. Last build began before the Maps placeholder configuration edit and failed at manifest merging; confirm fresh configuration works.
3. Verify Google Maps SDK/key and Firebase Email/Password enablement. User supplied Maps key stored only in ignored android/maps.properties.
4. Install APK and run Appium on emulator. Get actual screenshots and fix observed issues. A physical Android device still needs to be connected.
5. Complete faithful frame matching and remaining card/settings/order variants; do not claim pixel fidelity yet.
6. Finish presentation, beta upload to two supplied testers, real-device QA/Jira evidence and final documentation.
7. Publish verified source changes and CI results. No final capstone submission has been performed.

## Important
Firebase configs, Maps key, build outputs and private handoff notes are ignored by Git. Copy `flutter_app/lib/core/firebase_options.example.dart` to `firebase_options.dart` and provide your own app config on a fresh checkout. Current local config is retained.

Auth console initially reported no permission to manage sign-in providers. The user is addressing setup. Do not invent test passes, tester acceptance or physical-device evidence.
