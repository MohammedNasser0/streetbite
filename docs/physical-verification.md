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

## Build 5 checkpoint

The owner-assisted fingerprint/profile/name/device-details test passed again on build 5 (APK SHA256 `01fdd6ec29a1ca16f5b157c36dd0b2c2a79b6ff8da196f6ede4072d0d67cbb68`). Photo replacement/restart was verified on build 4; build 5 does not claim a repeat of that full photo scenario. The owner attempted a normal device screenshot and reported that Android refused biometric-prompt capture. Prompt visual evidence remains blocked; fingerprint functionality passed.

The initial build-5 cart quantity assertion expected a separate native label for the number. The screenshot showed quantity 2 and a doubled total, while Flutter merged name/price/count in a single accessibility label. The locator was corrected to match the observed label. This harness failure is not logged as a product defect.

### Emulator biometric evidence — build 5
The owner captured the visible Windows emulator window showing the genuine StreetBite Android biometric prompt. The original is private delivery evidence at `.delivery/verification/emulator-beta5/biometric-prompt-windows.png`; packaging includes it only in the private ZIP. EmulatorBiometricTest then passed after an emulated fingerprint touch, revealing Change photo. This supplements, and does not replace, the previously completed physical-device biometric test.

## Current build 9 — 13 October 2026

OPPO CPH2669, Android 16. All five required automated scenarios passed across two runs: emptyFields, invalidCredentials, validLogin, mealGridScroll and addMealFeedback. The main run passed three; two cases did not reach application assertions because APK installation exceeded 90 seconds. After increasing androidInstallTimeout to 180000 ms, both targeted cases passed. Original setup failures and retry XML reports are retained privately. These results do not mark unexecuted manual cases as passed.

Five current phone screenshots were visually reviewed and copied only to private delivery evidence. Full profile/photo/restart evidence remains build 4. No new build 9 biometric pass is claimed.

After testing, build 9 was reinstalled successfully on the physical phone. Package inspection confirmed versionCode=9 / versionName=1.0.0, and MainActivity launch succeeded.
