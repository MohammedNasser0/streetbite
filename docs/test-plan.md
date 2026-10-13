# StreetBite test plan

## Scope
Welcome/splash, login, signup, home discovery, browse/search, details, favourites, cart quantity/last-item removal, checkout, fixed-data demo card, delivery address, order acknowledgement/history, profile/photo/device/biometrics, vendor map and settings. Cover English/Arabic, RTL, light/dark, offline cache/restart and accessibility at 375×812 and 412×915.

## Test levels and environments
Unit tests for models, cache fallback, cart totals and order validation; widget tests for form validation/localization/responsiveness; Appium on Android emulator and physical Android. Firestore ownership rules require emulator tests and live signed-in verification. iOS requires macOS/Xcode/device execution and cannot be certified from Windows.

## Exit criteria
No open blocker/critical defects; all required flows pass; every failed case has a reproducible Jira record; no unhandled exceptions; analyzer and automated checks pass; real-device evidence captured; signed beta distributed to two testers; all required Figma frames mapped and visually reviewed.

## Evidence rules
Record actual observed results and environment. Never treat a planned case, skipped test, mocked response or emulator screenshot as physical-device execution. Jira issues are created only for observed defects. No duplicate or invented issues to satisfy a count.

## Manual execution preparation — 14 October 2026

The matrix now contains 36 uniquely identified cases. Eight added cases cover onboarding, browse, current Checkout composition, cancelled demo-card selection, empty-cart checkout prevention, address validation/editing and settings. Added cases remain Not Run. Follow `manual-qa-walkthrough.md` to record actual device/version/date and observed results; automated passes do not replace manual execution.
