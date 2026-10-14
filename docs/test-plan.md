## Current physical exploratory QA — 14 October 2026

The matrix now records 36 Pass, 6 Not Run and 1 Blocked (owner-deferred bonus Maps). Newly observed physical/technical results and the exact remaining cases are detailed in [physical exploratory QA](physical-exploratory-qa.md). Earlier statements below retain their historical scope. This is not independent human execution or complete capstone closure.

# StreetBite test plan

## Scope
Welcome/splash, login, signup, home discovery, browse/search, details, favourites, cart quantity/last-item removal, checkout, fixed-data demo card, delivery address, order acknowledgement/history, profile/photo/device/biometrics, vendor map, settings, Help center and Contact. Cover English/Arabic, RTL, light/dark, offline cache/restart and accessibility at 375×812 and 412×915.

## Test levels and environments
Unit tests for models, cache fallback, cart totals and order validation; widget tests for form validation/localization/responsiveness; Appium on Android emulator and physical Android. Firestore ownership rules require emulator tests and live signed-in verification. iOS requires macOS/Xcode/device execution and cannot be certified from Windows.

## Exit criteria
No open blocker/critical defects; all required flows pass; every failed case has a reproducible Jira record; no unhandled exceptions; analyzer and automated checks pass; real-device evidence captured; signed beta distributed to two testers; all required Figma frames mapped and visually reviewed.

## Evidence rules
Record actual observed results and environment. Never treat a planned case, skipped test, mocked response or emulator screenshot as physical-device execution. Jira issues are created only for observed defects. No duplicate or invented issues to satisfy a count.

## Manual execution preparation — 14 October 2026

The matrix now contains 36 uniquely identified cases. Eight added cases cover onboarding, browse, current Checkout composition, cancelled demo-card selection, empty-cart checkout prevention, address validation/editing and settings. Added cases remain Not Run. Follow `manual-qa-walkthrough.md` to record actual device/version/date and observed results; automated passes do not replace manual execution.

Build 11 adds TC_BROWSE_002 for uncached offline search and query-preserving recovery. The matrix now has 37 cases; the new manual case remains Not Run. Native automated evidence is recorded separately.

Build 12 adds TC_SUPPORT_001–002 for localized FAQ content and public-link copying/back navigation. The matrix now has39 unique cases; both remain Not Run until physical manual execution. Native support/navigation/clipboard evidence is separate.

Build13 adds TC_ADDRESS_003, TC_MENU_001, TC_BROWSE_003 and TC_DETAILS_002. Current matrix:43 unique manual cases, with real-device execution pending for new cases. Grouped menu and shared Home address are in scope.
