# Emulator verification — 12 October 2026

Environment: Flutter 3.47.6 / Dart 3.13.5, Medium_Phone AVD (Android API 37, emulator-5554), Appium 3.8.0, UiAutomator2 8.7.0, Java/TestNG.

## Completed checks

- Flutter analyzer: no issues found.
- Flutter unit/widget tests: 10 passed. Includes cache fallback/corruption, cart/model behavior, order validation and EN/AR delivery form layouts at 375/412 logical pixels.
- Release APK: build succeeded, version 1.0.0+2, approximately 54.9 MB. Development signing key is used for this beta.
- APK SHA256: `3b8b7025831f73a22ad90e78608e2d3f163c203641f3cdb7ed86f24eb3870cdb`.
- Appium functional run: **5 passed, 0 failed, 0 skipped**, 3m 16s. Empty login validation, invalid credentials, valid login, meal grid scrolling, and add-to-cart snackbar.
- Final build-2 run: **7 passed, 0 failed, 0 skipped**, 5m 36s. The five required scenarios plus Maps and cash checkout/order history after app restart. Shared driver enforces APK installation and waits for focused input fields, refreshing stale native references.
- Dedicated QA account creation succeeded in Firebase, confirming Email/Password is enabled. Credentials remain in an ignored local file.

## Failures resolved during test setup

The initial Appium run failed because the suite used an incomplete tab label, scrolled before menu loading, used fixed gesture coordinates and typed into unfocused fields. These were automation defects. The suite now targets the full native tab description, waits for menu content, sizes gestures from the device viewport and focuses input fields before typing. The next complete five-scenario run passed.

An expanded checkout run revealed a keyboard-focus race and a locator that expected the meal name separately from the price in the native order-row description. Focus/stale-reference waits and prefix matching resolved these automation failures. The final seven-scenario run passed without skips.

## Remaining acceptance evidence

Physical Android execution, biometric/gallery verification, signup/profile/favourites UI acceptance, full manual QA and full Figma screen coverage remain pending. Emulator results do not stand in for real-device execution. Manual cases remain unexecuted until their specific steps are run.

The first Maps screenshot tour could not locate a vendor marker within 30 seconds. After explicitly installing the latest APK with `adb install -r`, both additional evidence tours passed. Map tiles, all five markers and the Cairo info window are visible in `screenshots/vendor-map.png`. The installed app had previously retained an older build with the same version code.

## Live backend checks

Ten Firestore REST checks using the dedicated QA account passed: owner profile write/read, favourite write/read/removal, order create/read, denial of modifying an existing order, cross-user profile access and unauthenticated profile access. Only QA-owned records were used. This checks the deployed rules and data access, not full application checkout or profile workflows.

The additional Appium checkout workflow passed on build 2: login, add a meal, cash demo checkout with a synthetic address, order acknowledgement, live order history and order history after terminating/restarting the app. Persisted authentication was verified by opening the order history without signing in again. This does not establish real payment processing or delivery dispatch.

## Beta distribution

Firebase confirmed upload and distribution of version 1.0.0 (1) to both authorized testers on 12 October 2026. Release ID: `6okh6af9cglmo`. Tester acceptance and installation have not been verified.

Build 2 was subsequently uploaded and distributed to the same two testers. Release ID: 11dliohcsqaq0. Its checksum and final seven-scenario run are listed above. Build-2 acceptance/download status has not been checked.
