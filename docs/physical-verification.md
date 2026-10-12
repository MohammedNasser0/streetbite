# Physical Android verification — 12 October 2026

Environment: OPPO CPH2669, Android 16, physical USB-connected phone. Dedicated synthetic QA account; no personal account credentials used.

## Required Appium suite

Five cases passed, zero failed/skipped, in 2m51s on the initial build 4 APK (SHA256 `6e0db872a3b93b22f22923f87ff57bd3335db598d1c23586d6114cace7d935cf`):

| Case | Result | Screenshot |
|---|---|---|
| Empty login fields | Pass | Retained privately |
| Invalid credentials | Pass | Retained privately |
| Valid dedicated-account login | Pass | Retained privately |
| Meal-grid scrolling | Pass | Retained privately |
| Add-to-cart feedback | Pass | Retained privately |

The initial build omitted the Maps-enabled compile flag. The corrected build 4 artifact has SHA256 `8a6c53e8e5a57af4197c2e65643f997bb1feeeef1802fc21581135be465e0f47`; Maps and additional acceptance are being verified separately. The same five cases subsequently passed on the corrected artifact across two runs: Home scrolling/cart feedback and empty login passed first; invalid-credentials and valid-login passed in a targeted 1m14s retry. One installation exceeded the 90-second setup timeout, and the first valid-login attempt was interrupted while the phone Settings screen was foregrounded. Interrupted attempts remain retained privately and are not counted as app passes.

The first physical attempt had OEM `pm clear` permission failures. BaseTest now uses a fresh installation for the dedicated test package on physical devices, without relaxing phone security. A stale driver teardown was also fixed. Original reports remain privately retained.

## Owner-assisted device features — passed on final build 4

The fingerprint/profile/gallery/restart Appium scenario passed on the Maps-enabled build 4 in 1m49s with owner participation. It checked the live profile name, favourites section, device details, a changed photo stored through the QA owner's Firestore record, and the same stored photo after terminating/relaunching the app and authenticating again. Private screenshots were visually reviewed: the profile shows the synthetic QA identity and OPPO CPH2669 / Android 16; the food thumbnail persists after restart.

Android returns a black image for the protected biometric prompt. This is a screenshot limitation; no security flag was bypassed. A black screenshot is not visual biometric-prompt evidence.

Optional payment/checkout runs were interrupted when the USB connection became unauthorized and UiAutomator2 stopped. These are not successful acceptance runs. Do not mark corresponding manual cases passed based on them.

Manual-case execution is tracked separately in `manual-test-cases.csv`; an automated pass does not silently become a manual result. No physical-device screenshot is substituted with emulator imagery.

Physical screenshots are retained privately at the user's explicit request; they are not published to this public repository.

The owner initially had no second camera available and may try a normal manual screenshot of the biometric prompt. No capture workaround or security-setting change is requested. Until a real visible capture is supplied, this visual evidence remains unavailable.
