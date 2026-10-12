# StreetBite work status — 12 October 2026

## Verified and delivered
- Public repository: https://github.com/MohammedNasser0/streetbite
- Android release APK 1.0.0 (3), development signing. SHA256: 1b4e44064cb07aa7d7cea0fe3af81fafdfc34ad1cdfe254c94a12ad996b01e80.
- Firebase App Distribution upload and distribution to both authorized testers succeeded. Release ID: 7dopgsri4kak0. Acceptance is not verified.
- Ten Flutter unit/widget tests passed, including EN/AR forms at 375/412 logical pixels. Analyzer passed.
- Final build-2 Appium run: seven passed, zero failed/skipped in 5m 36s. Includes the five required cases, Maps and live checkout/order history after app restart. Additional screen tour passed.
- Google Maps tiles and all five vendor markers render on emulator. Cairo marker interaction passed.
- Email/Password authentication verified using a dedicated QA account.
- Ten live Firestore REST checks passed: owner profile read/write, favourite read/write/removal, order create/read, and denial of order modification, cross-user access and unauthenticated access. These are backend checks, not full app-flow verification.
- Screenshots and a seven-slide presentation prepared. See docs/emulator-verification.md.

## Outstanding before final acceptance
1. Complete all Figma frame mapping and faithful screen coverage. Current implementation does not establish full 50+ screen fidelity.
2. Complete signup/profile/favourites UI acceptance and offline device restart. Cash checkout, live order history and persisted authentication after app restart passed on emulator.
3. Connect a physical Android device for required manual cases, Appium login rerun, biometric/gallery evidence and device details.
4. Tester acceptance is pending. User-supplied Firebase dashboard screenshots show the release and two invited testers, zero accepted/downloaded; originals are retained privately.
5. Document actual real-device manual results/Jira defects. EN/AR key parity and direct-usage audit passed; unused ARB key removed and vendor strings moved into ARB.
6. Production signing and iOS configuration/build verification remain pending. No final Sprints submission performed.

Private Firebase configuration, Maps key and QA credentials remain ignored. Dedicated backend: streetbite-6dd3c. Do not reuse the parent ConnectMe backend.

## Build 3 checkpoint
- Corrected signup name validation; both invalid-name and successful-signup/profile persistence cases passed on emulator. Analyzer and ten Flutter tests passed after the fix.
- Dedicated private Jira project created at the user's request. A code-review defect was fixed and verified; issue details and screenshots are retained privately.
- Build 3 uploaded and distributed to both authorized testers, release7dopgsri4kak0. No tester acceptance or physical-device execution claimed.
- Full Figma fidelity, Add card design variant, profile/gallery/biometric UI acceptance, offline device checks and real-device manual/Appium QA remain outstanding.

## Build 4 work in progress
- Localized fixed-data Add card layout added and linked from checkout; it accepts no real card credentials. Checkout now scrolls on compact screens.
- Analyzer passed and fourteen Flutter tests passed; ARB parity/direct-usage audit has no unused getters.
- Five required Appium scenarios passed on a physical OPPO CPH2669 / Android 16 using the initial build 4 artifact. See docs/physical-verification.md for hashes, scope and infrastructure failures.
- Maps-enabled build 4 rebuilt; additional profile/photo/payment/checkout and final-artifact tests remain in progress. Distribution is not yet updated.
- Fingerprint opened the profile with owner participation. Test-locator refinements and gallery/restart verification remain in progress; no final profile test pass claimed yet.

## Latest verification checkpoint
- Maps-enabled build 4 passed all eight emulator cases, plus a separate offline metadata/restart/cart case. Reports are retained privately. Offline photos use placeholders.
- Owner-approved email-redacted Firebase build-1 screenshot published in README; original and extra physical images remain private for the delivery ZIP.
- Owner-assisted physical profile/photo verification is running. Final acceptance remains open.

- Maps-enabled build 4 upload and distribution succeeded: release `3e6bqgorl8k0g`. Tester acceptance remains unverified.

- Owner-assisted final-build-4 fingerprint/profile/photo/restart case PASSED (1m49s). Profile/device and before/after-restart photo images reviewed and retained privately. Five required cases are being rerun on the exact distributed artifact.

- Final Maps-enabled build 4 physical required cases passed across two runs. Targeted retry completed in 1m14s after owner left phone idle.
- Build 5 source in progress: cart thumbnails, quantity controls, last-item removal feedback and compact EN/AR coverage. Not yet built/distributed.

- Build 5 analyzer and nineteen Flutter tests passed. EN/AR localization parity and direct-usage audit passed with no unused getters. APK build running; targeted cart/checkout and physical profile evidence are next.

## Current checkpoint — build 5
- Android 1.0.0 (5), Maps enabled, uploaded and distributed to both authorized testers. Release: 7tp5domjttll8. Tester acceptance is unverified.
- APK SHA256: 01fdd6ec29a1ca16f5b157c36dd0b2c2a79b6ff8da196f6ede4072d0d67cbb68.
- Analyzer and all nineteen Flutter tests passed. Targeted build-5 physical cart and fingerprint/profile tests passed. Full photo/restart acceptance remains established on build 4.
- Build-5 emulator cash checkout/history, cart quantity/removal and enrolled fingerprint prompt/unlock checks passed. Windows capture of the real emulator prompt is retained privately and added to ZIP packaging. It is supplementary emulator evidence, not a physical-device screenshot.
- Five required physical Appium cases passed on final Maps-enabled build 4 across two runs; full fingerprint/photo/restart also passed.
- Private phone images and original Firebase/Jira evidence remain excluded from GitHub. Public images contain emulator UI and the owner-approved email-redacted historical Firebase dashboard.
- Full Figma fidelity, remaining manual QA, tester acceptance, production signing and iOS verification remain open. No final Sprints submission performed.

- Review presentation refreshed to build 5 and all seven slides rendered/visually checked. Finalizer passed integrity, geometry, reference font and first-party import checks. Current deck: presentation/StreetBite-project-review-build5.pptx. The earlier deck is retained as historical source.
- Emulator CartTest passed in 43s. Public cart image is from the emulator, not the private phone screenshots.

## Build 6 work in progress
- Compared Orders frame 21:3759 in the supplied Figma copy. Added rounded meal thumbnails, localized order dates, compact history rows and an explicit demo-order notice. Existing records without image fields retain a receipt fallback. New orders persist the recipe image URL. No fabricated courier status/current-versus-past grouping is introduced.
- Analyzer passed and all 23 Flutter tests passed, including historical order decoding, thumbnail/date round trip and compact EN/AR history rows.
- Maps-enabled build 6 is being built. Emulator checkout/history verification and release distribution are pending. Build 5 remains the distributed beta and review ZIP; the new source is not yet in that ZIP.
- Reinstalling build 5 on the physical phone stalled and was cancelled. Do not claim successful final reinstall.

- Build 6 Maps-enabled APK completed successfully (55.1 MB). SHA256: 37c49975e1729f86552c430aec4fbcc1e1ae35a77d9703c3ef1bcbf53e6db19f. Targeted emulator checkout/history/restart is running; no pass claimed yet.

## Saved continuation point — usage limit approaching
- Latest public source commit: b3153da. Build 6 APK completed; analyzer and 23 tests passed.
- Build-6 emulator CheckoutTest FAILED after login submission while waiting up to 30 seconds for the StreetBite home label (CheckoutTest.java:15). Failure screenshot remained on the login form. No runtime checkout/history acceptance is claimed for build 6. Diagnose network/auth response and rerun this targeted case before distribution or packaging. Original report: .delivery/verification/emulator-beta6/TEST-streetbite.CheckoutTest-initial.xml (private).
- Next: rerun/diagnose build-6 login; verify new order thumbnail and localized date visually after cash checkout/restart. Then distribute build 6 only after verification. Keep current build-5 review ZIP unchanged.
- Current distributed release remains build 5: 7tp5domjttll8. Private review ZIP: .delivery/StreetBite-review-build5.zip, SHA256 9038778f8ba4cea8b2422c8a5be446c6566f07c98e9b171c53702eb6ca6ba166.
- Current presentation is presentation/StreetBite-project-review-build5.pptx (7 slides, finalizer passed). Do not update its counts/version to build 6 without a deliberate revision.
- Android emulator is visible, Medium_Phone, emulator-5554, enrolled fingerprint 1. Genuine Windows prompt capture retained privately and included in ZIP. Physical device 66fc4053 was connected, but final reinstall stalled/cancelled. Appium server localhost:4723.
- Figma checkout 10:338 was visually inspected: map with adjust pin, delivery-option cards, address/detail/contact/promo rows, fixed bottom action. These remain fidelity work. Do not fabricate real delivery ETAs or charges. Accessible copy contains 15 app frames.
- No running Flutter build or Appium test remains. No final Sprints submission made. Remaining manual QA and full design fidelity are still open.
