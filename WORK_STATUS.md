# Physical QA review checkpoint — 14 October 2026

36 Pass, 6 Not Run, 1 Blocked. See docs/physical-exploratory-qa.md and CSV for actual scope. APK unchanged at final build13; new presentation revision build13-qa updates notes only. Private reviewed phone evidence stays ZIP-only. Figma fidelity remains partial; no platform submission. Original phone size, enabled Wi-Fi/data and EN/light restored; session closed.

# Current delivery checkpoint — build 13, 14 October 2026

43 Flutter tests pass; analyzer clean. Final APK SHA256318b20bf2526d994377d4df2e9b4f43058029be8ddc361f24797b111454a95b3. Four final native emulator cases and six unique physical cases passed across scoped runs, including owner-assisted fingerprint/profile. Initial Profile setup hit Play Protect; owner completed the check, checksum-verified retry passed. Gallery/photo/restart remains historicalbuild4. Firebase release 1p7qp7hs4ct48 distributed to two authorized testers. STREET-3 saved-address subtitle fixed and verified Done. Manual matrix: 43 cases, 2 Pass and 41 Not Run. Figma fidelity partial, Maps bonus deferred, tester acceptance and final platform submission unverified. Seven-slide build13 presentation finalized and visually reviewed; matching review ZIP prepared from committed source.

## Historical checkpoints
# Build13 source work in progress

Session address shared across Home/Checkout and cleared across accounts; grouped menu with pinned categories; Browse category tiles; detail quantity controls; explicit cart summary; RTL history chevron. Build13 release compilation active. No13native pass/distribution/package yet. Latest completed package remains12.

# Current delivery checkpoint — build 12, 14 October 2026

35 Flutter tests/analyzer pass; native support/navigation/clipboard passes. APK SHA256 8e9b47df5283047319d43aaab096e8331c29a08abf458da4d71557a736acabea. Distributed release2nm8gta2jnj68 to two testers. Current presentation StreetBite-project-review-build12.pptx. Physical/manual cases pending; phone unavailable. Historical scopes below remain unchanged.

## Historical checkpoints

# Current delivery checkpoint — build 11, 14 October 2026

- Android 1.0.0 (11), APK SHA256 e596c3ff1b5897f3a18e121f53d4f5f310f6158f7158405bf5573398c2125a8f.
- Uploaded/distributed to the same two authorized testers, release 3clm3j8ki2bng.
- 31 Flutter tests pass; analyzer clean. Native Browse retry passed twice after one Android System UI infrastructure failure. Preserved query/input and restored emulator connection state were asserted. Reports retained privately.
- Reviewed public emulator images: browse-retry-build11.png and browse-results-build11.png. Device environment: API37.1, 720x1600 / density280, same approximate logical viewport.
- Current presentation: StreetBite-project-review-build11.pptx. Delivery package: StreetBite-review-build11.zip, built from committed source. Historical artifacts preserved.
- Packaging now verifies versionName/versionCode against pubspec and includes only the matching presentation, preventing source/APK version mismatch.
- Full five-case physical evidence remains build9, full profile/photo/restart build4; no physical build11 claim. Phone unavailable at last check; connection requested for manual QA.
- Manual matrix now has 37 cases; added Browse recovery manual case remains Not Run. Automated results do not complete the manual cycle.
- Next design work: Profile header alignment, Settings/Contact/Help links and bottom navigation per Figma node21:3864, preserving live data and biometrics. Full Figma fidelity remains partial. Reference lists missing SF Compact Display/SF Compact/SF Pro; no font-fidelity pass claimed.
- Bonus map tiles deferred; tester acceptance unverified; no final platform submission.

Earlier checkpoints below retain their historical scope.

# Unreleased source checkpoint — 14 October 2026

- Source version 1.0.0+11: Browse network-error view now offers Retry. MenuCubit retries its last query, preserving the entered search text.
- All 31 Flutter tests passed, including EN/AR failure→retry→results checks that assert the same query is reused.
- No build 11 APK, native pass or distribution is claimed. Existing final APK/ZIP/Firebase release remain build 10. Do not package the current source with the build 10 APK as if they match.
- Analyzer passed with no issues. Next: build and verify the Browse failure/retry flow on native Android before distribution. Full Figma fidelity/manual QA/current dashboard capture remain open.

Earlier delivery checkpoints below retain their original scope.

# Documentation checkpoint — 14 October 2026

- Source/application remains the verified and distributed build 10; no new app build required for these documentation changes.
- Added Arabic manual QA walkthrough and eight planned cases, bringing the matrix to 36. New cases remain Not Run; prior recorded results unchanged.
- Current documentation package: StreetBite-review-build10-qa.zip. Prior build10 ZIP is preserved.
- Tried the actual Firebase build-10 console URL and one reload; page remained on its loading spinner. A current dashboard screenshot is still missing; API distribution confirmation is retained and the public screenshot is explicitly historical.
- Phone still has build 9 after stalled build10 install was stopped. No new physical pass claimed.
- Remaining: full Figma fidelity, actual manual QA execution and current Firebase dashboard capture. Bonus map tiles deferred; tester acceptance unverified; no final platform submission.

Earlier checkpoints below retain their historical scope.

# Latest checkpoint — build 10, 14 October 2026

- Final Android APK 1.0.0 (10), SHA256 549280bd7c069657573bc40c3609c31d647246432198a5cb04f2fb1a0949bb5b.
- Firebase upload/distribution to the same two authorized testers succeeded, release 10m6d1qnfpap0.
- Checkout reviewed against Figma node 10:338. Separate address/apartment, instructions and contact rows; localized title/demo notice; fixed total/order action; safe cancelled-card selection.
- 29 Flutter tests passed before the localized notice correction; affected two tests passed again after it. Final analyzer clean.
- Final emulator cash checkout/history/restart and screen tour both passed in 2m 48s. Full core emulator/physical evidence remains build 9. Full profile photo persistence remains build 4.
- Reviewed signed-out Checkout screenshot is public. All phone screenshots remain private ZIP only. Current deck: StreetBite-project-review-build10.pptx; current package: StreetBite-review-build10.zip.
- Remaining: full Figma fidelity (see frame inventory), remaining manual QA; bonus map tiles deferred. Tester acceptance unverified; no final learning-platform submission.

Previous checkpoints below are historical.

# Latest delivery checkpoint — 14 October 2026

- Firebase login renewal succeeded using the official interactive local callback.
- Build 1.0.0 (9) uploaded and distributed to the same two authorized testers. Release ID: 6a8l9q8aa79m0. Upload checksum matches the tested APK: 5ff43eda0287184b759d80a67c7e1694f98a22baa04c35e2176411dde7d9b917.
- The initial streamed upload encountered ECONNRESET. The same APK succeeded via Firebase REST with explicit Content-Length; no new access scopes or recipients were added.
- Current presentation: StreetBite-project-review-build9-distributed.pptx. Current private ZIP: StreetBite-review-build9-distributed.zip. Historical ZIPs are preserved.
- Verification remains 27 Flutter tests, eight unique core emulator scenarios and five required physical cases across documented main/retry runs.
- Remaining: full Figma fidelity and unexecuted manual QA. Bonus map-tile diagnosis is deferred. Tester acceptance unverified; no final learning-platform submission.

Earlier checkpoints below retain their historical scope.

# Current checkpoint — 13 October 2026

- Latest local APK: 1.0.0 (9); SHA256 5ff43eda0287184b759d80a67c7e1694f98a22baa04c35e2176411dde7d9b917.
- Analyzer and 27 Flutter tests passed. Eight unique core emulator cases and five required physical cases passed across scoped main/retry runs. Screenshot tour passed.
- Reviewed physical images are private ZIP evidence only. Current public details/cart images and seven-slide presentation prepared.
- Build 9 Firebase upload pending after renewed authorization was rejected. Build 5 remains the distributed beta.
- Review delivery is prepared from committed source with APK, current deck and private screenshots.
- Remaining: diagnose Firebase renewal; Figma fidelity partial, bonus map tiles deferred, remaining manual QA Not Run. No final platform submission.

The following is historical progress; its build numbers and claims retain their original scope.

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

## Build 6 runtime verification passed
- After restoring Appium's Android SDK environment, the targeted cash checkout/history/restart case passed in 1m11s. The prior resumed attempt failed during session creation because ANDROID_HOME/ANDROID_SDK_ROOT were missing, not because an application scenario failed.
- Visually reviewed loaded emulator history: new Flan order displays the stored meal photo and localized date; older orders retain receipt placeholders. Report and original captures remain private; reviewed emulator history image is safe for public design evidence.
- The original pre-pause login timeout remains retained as an interrupted/failed attempt. A successful fresh retry is established, but its historical root cause is not proven.

## Build 7 work in progress
- Added an optional manually selected delivery pin using Google Maps. No GPS/location permission or automatic geocoding is used. Existing saved coordinates are range/finite validated; text address entry remains required. Checkout previews the selected pin and the existing address map persists it with the demo order.
- New tests cover invalid coordinates and preserving a pin while editing an existing address. Compact EN/AR form coverage remains included. Final full checks/build are running.
- Build 6 checkout/history/restart passed in 1m11s after Appium SDK environment repair. The loaded history thumbnail was visually reviewed. Build 6 is retained privately at .delivery/verification/streetbite-beta6-maps.apk and has not been distributed; build 5 remains current distributed release.

- Build 7 analyzer passed with no issues and all 25 Flutter tests passed. Maps-enabled APK build is running. Native pin selection will be checked with CheckoutTest using -Dmobile.pin=true; do not count it as passed until execution finishes.

## Map initialization defect found during build 7 review
- The native pin/order persistence test technically passed, but its screenshot showed an early tap selected 70.44945,-99.54251 while the intended initial camera was Cairo. This visual review invalidated any claim of correct initial map composition.
- Build 8 waits for an explicit native camera move before allowing selection, shows a localized loading state, and handles camera setup errors. The regression now additionally requires the selected test point to be within 0.05 degrees of the Cairo center.
- Build 8 analyzer passed with no issues and all 25 Flutter tests passed. APK build running; native regression pending. Build 7 is retained privately and is not distributed.

- Map initialization defect recorded in the dedicated Jira project (private evidence updated). No duplicate found in camera/pin and map searches. The issue remains open pending build-8 native regression. No tester acceptance or final submission is claimed.

## Build 8 verified scope
- Maps-enabled APK built, SHA256 f23d92fa2e0e958c8969c766f91ca9133ab11401d696c6ce4ffcdb861759a386. Analyzer has no issues; all 25 Flutter tests pass. EN/AR key parity and usage audit previously passed, with new mapLoading used in the map UI.
- Native pin + cash checkout + Firestore coordinate read + history/restart passed twice (1m17s and 1m31s). Selected test point 30.04443,31.23567 is within Cairo tolerance after explicit native camera initialization. Reports and reviewed evidence are private.
- Jira STREET-2 early camera/tap defect verified fixed and moved to Done. Private Jira evidence updated.
- Separate concern: the current emulator shows a blank basemap behind the marker even after a rendering delay. Sanitized SDK diagnostics show no authorization failure. Existing vendor map is being compared; no visual map acceptance is claimed for build 8 yet.
- Build 5 remains distributed. Builds 6/7/8 have not been distributed. Physical phone is currently absent from ADB; owner has been asked to reconnect it.

- Build-8 vendor-map comparison: marker and info-window interaction passed in 33s, but visual review showed the same blank basemap as the new address map. This affects both screens in the current emulator session. No proxy is modified and no permission/key restrictions are relaxed. Physical comparison and network/rendering diagnosis remain pending.
- The first build-8 native-pin report (1m17s) is preserved. The 1m31s rendering-delay retry passed in console but its XML was overwritten when starting the map comparison; do not claim two preserved XML reports. The comparison XML and screenshots are retained privately.

## 13 October: primary requirements first
Vendor maps, biometric gating and the manual/Appium QA sections are explicitly labeled bonus in the brief; the completion section also requests QA artifacts. The owner chose to prioritize primary functionality and defer map-tile diagnosis. Do not describe the map rendering issue as a blocker for core functionality.

Build 9 adds the explicitly requested live cart count on Meal Details and BlocConsumer feedback, using a shared CartAction with Home. Analyzer passed and all 27 Flutter tests passed, including compact English/Arabic detail-to-cart updates. APK build is running. The physical OPPO is connected again and charged to 40%; artifact-specific acceptance and final packaging remain pending.

## Build 9 local artifact and test environment
APK 1.0.0 (9) built successfully, SHA256 5ff43eda0287184b759d80a67c7e1694f98a22baa04c35e2176411dde7d9b917. Analyzer and all 27 Flutter tests passed; all 75 Dart files are formatted. A current acceptance table is maintained in docs/core-acceptance.md.

Initial emulator rerun failed entirely during Appium setup: the old biometric emulator was credential-locked after cold boot, making the settings helper activity unavailable. No application case ran. Failure XML is retained under .delivery/verification/emulator-beta9-setup-failure. The original AVD/data remain intact. A separate StreetBite_Core_QA AVD on emulator-5556 was created for primary tests; it is currently restarting with 2GB RAM after resource pressure from two simultaneous emulators. The old AVD is closed to release memory.

Physical OPPO connection is currently Unauthorized; owner has been asked to approve USB debugging. Do not claim build-9 emulator/device passes or current release distribution yet. Public presentation build 9 operation was marked started once; builder is prepared at .presentation-build/update-build9.mjs but has not been run. It needs verified .delivery/presentation-facts-build9.json and reviewed emulator screenshots first.

- Build-9 clean emulator acceptance is running on emulator-5556 / StreetBite_Core_QA. Cart quantity/removal and cash checkout/history/restart have passed so far; remaining cases are not yet counted as passed.
- A fresh core-test AVD avoids requiring access to the original credential-locked AVD. Original Medium_Phone data remain intact. New AVD completed boot after running alone with 2GB RAM. No lock credential was bypassed or changed.
- Physical phone still awaits owner approval of USB debugging. Presentation source is prepared; output has not yet been authored/finalized. Do not rerun the build-9 operation-start marker.

## Build 12 source work in progress (14 October)
Profile now uses a start-aligned avatar/name and working Settings, Contact us and Help center rows. Support pages are localized; Contact copies only the public repository URL. Home, Browse, Orders and Profile share section navigation that returns to the original Home route. All 35 Flutter tests passed; analyzer passed after fixing one test formatting warning. Native build 12 verification, distribution, deck and ZIP are pending. Build 11 remains the latest verified distributed package. The owner says the physical phone is unavailable; outstanding manual real-device cases remain pending.

Build 12 verification update: release APK built successfully (SHA256 8e9b47df5283047319d43aaab096e8331c29a08abf458da4d71557a736acabea). The native guest navigation/support/clipboard scenario passed on the QA emulator in46s. Earlier attempts exposed incorrect test assumptions about the Order history label, guest login gate and SelectableText accessibility; private reports are retained. No app source changes were needed for those retries. Physical device testing remains pending because the owner says the phone is unavailable. Build12 deck/ZIP pending.


## Build 12 core regression — 14 October 2026
Five required emulator cases passed in2m39s: valid/invalid/empty login, Home grid scrolling and add-to-cart feedback. Additional cart quantity/empty feedback, cash order/history/restart and favourite/restart checks passed; cache/offline restart also passed. All9 core/additional regression cases passed, plus the separate support/navigation case. These are emulator results and do not replace manual real-device cases. No Google API key literals found in tracked text. EN/AR localization keys match with no unused direct getters.
