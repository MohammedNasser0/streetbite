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

## Signup correction — build 3

Build **1.0.0 (3)** corrects numeric/punctuation initials in the signup name validator. Two targeted Appium cases passed separately: numeric-name rejection and successful signup with owner-token verification of the Builder-created Firestore profile. The prior seven-scenario run applies to build 2; it was not rerun as a full suite on build 3. Flutter analyzer and all ten existing unit/widget tests passed after the fix. Private Jira evidence records the fix and its post-fix screenshot. No physical-device pass is claimed.

Build-3 APK SHA256: 1b4e44064cb07aa7d7cea0fe3af81fafdfc34ad1cdfe254c94a12ad996b01e80. Firebase confirmed upload and distribution to both testers; release ID: 7dopgsri4kak0.

## Current build 9 — 13 October 2026

Fresh StreetBite_Core_QA emulator, Android 17/API 37.1, serial emulator-5556. Eight unique core scenarios passed across two runs: CartTest (1), CheckoutTest (1), HomeTest (2), LoginTest (3), and FavouritesTest (1). The main run passed seven cases and failed the favourites locator; after correcting its escaped-newline prefix, the targeted save/restart/remove case passed. No product fix was required for that locator error. A separate EvidenceTest.screenTour passed and supplied reviewed public details/cart images. This is not a single green eight-case suite. Reports, including the initial failure, remain private.

Build 9 APK SHA256: `5ff43eda0287184b759d80a67c7e1694f98a22baa04c35e2176411dde7d9b917`. The optional map tour was not rerun; blank tile diagnosis is deferred.

## Build 10 Checkout review — 14 October 2026

Final APK SHA256: `549280bd7c069657573bc40c3609c31d647246432198a5cb04f2fb1a0949bb5b`. CheckoutTest.cashOrderAndHistory and EvidenceTest.screenTour both passed on the final APK in 2m 48s. Cash order creation, history and restart persistence were asserted. The reviewed signed-out Checkout screenshot has no personal account details and is public.

All 29 Flutter tests passed before a localized notice wording correction; both Checkout EN/AR compact-layout and cancelled-card checks passed again after that correction. Final analyzer reports no issues. The first build-10 native run also passed, but its APK and screenshots are superseded by the final wording-corrected artifact. Initial unit-test failures were harness scrolling/localized-back issues; the corrected tests pass. Full core native scenario coverage remains scoped to build 9.

## Build 11 Browse recovery — 14 October 2026

APK SHA256 `e596c3ff1b5897f3a18e121f53d4f5f310f6158f7158405bf5573398c2125a8f`. BrowseRetryTest passed in 52 seconds after an initial System UI ANR prevented reaching onboarding. The first failure is infrastructure evidence, not a Browse assertion failure. The successful emulator run used Android 17/API 37.1, serial emulator-5556, with a 720×1600 / density 280 override to reduce graphics load while preserving the logical viewport. The test disables Wi-Fi/data only on the QA emulator, submits uncached `chicken`, asserts the error and retained query, restores connectivity, taps Retry and asserts results and the same query. A finally block restores the original connection state.

The reviewed error screenshot and final settled results screenshot are public. A repeated passing run also completed in 52 seconds and supplied the final results capture. No new physical execution or manual pass is claimed.

## Build 12 support/navigation verification
On 14 October, all35 Flutter tests passed and analysis reported no issues. The Android release APK built successfully. Native QA-emulator support/navigation passed in46s: Home/Browse, guest Order history login gate, back to Home, Help, Contact, copy public URL and return. Initial failed test assumptions are retained privately (label, login gate, SelectableText locator). This does not certify authenticated Profile/bio or real-device cases on12. Reviewed Contact/Help screenshots remain private for now. Build12 deck/ZIP still pending.
