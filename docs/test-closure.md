## Current physical exploratory QA — 14 October 2026

The matrix now records 36 Pass, 6 Not Run and 1 Blocked (owner-deferred bonus Maps). Newly observed physical/technical results and the exact remaining cases are detailed in [physical exploratory QA](physical-exploratory-qa.md). Earlier statements below retain their historical scope. This is not independent human execution or complete capstone closure.

# Current delivery checkpoint — build 13, 14 October 2026

43 Flutter tests pass; analyzer clean. Final APK SHA256318b20bf2526d994377d4df2e9b4f43058029be8ddc361f24797b111454a95b3. Four final native emulator cases and six unique physical cases passed across scoped runs, including owner-assisted fingerprint/profile. Initial Profile setup hit Play Protect; owner completed the check, checksum-verified retry passed. Gallery/photo/restart remains historicalbuild4. Firebase release 1p7qp7hs4ct48 distributed to two authorized testers. STREET-3 saved-address subtitle fixed and verified Done. Manual matrix: 43 cases, 2 Pass and 41 Not Run. Figma fidelity partial, Maps bonus deferred, tester acceptance and final platform submission unverified. Seven-slide build13 presentation finalized and visually reviewed; matching review ZIP prepared from committed source.

## Historical checkpoints
# Build 12 checkpoint — 14 October 2026

35 Flutter tests/analyzer and native guest navigation/support/clipboard passed. Earlier native test assumptions were corrected and reports retained. Distributed release `2nm8gta2jnj68`. Manual real-device cases remain pending; phone unavailable. This is a review release, not complete capstone closure.

# Test closure — work in progress

Final acceptance remains open. Fourteen Flutter unit/widget tests and eight Appium emulator scenarios passed on the Maps-enabled build 4. Two additional screenshot tours passed, including Maps rendering and marker interaction on the installed beta. Ten direct authenticated Firestore REST checks passed. Email/Password authentication and Firebase beta distribution were verified.

See [emulator verification](emulator-verification.md) for versions, scope and evidence. Backend REST checks do not establish end-to-end signup, profile or checkout behavior.

The five required Appium cases passed on a physical OPPO Android 16 phone using the initial build 4 artifact; see [physical verification](physical-verification.md) for exact scope. Real-device manual results, biometric-prompt visual evidence, full Figma fidelity and full app-flow acceptance remain open. User-supplied Firebase dashboard screenshots confirm version 1.0.0 (1), two invited testers and zero accepted/downloaded. No manual case is marked passed without execution.

## Build 4 offline verification

On the Maps-enabled build 4 emulator, cached meal metadata survived network disconnection and app termination/relaunch; adding a cached meal to the cart showed confirmation. Network settings were restored in test cleanup. This is an emulator result. Image bytes are not persistently cached: offline images use the restaurant placeholder. The first draft test incorrectly required an Android ImageView offline; that assertion failed, while meal text was present. The corrected test checks cached metadata and cart usability, not offline photo persistence.

Owner-assisted fingerprint, live profile/device details, photo save and photo persistence after restart passed on the final build 4 physical phone. Screenshots stay private in the delivery ZIP. Android blocks capture of the biometric system prompt; no black image is presented as prompt evidence.

## Build 5 source checks

Analyzer passed and nineteen Flutter tests passed after adding cart thumbnails and quantity controls. Tests verify decrementing from two to one updates the total, removing the last unit clears the cart, and English/Arabic layouts at 375/412 widths show the empty-cart SnackBar. Final APK/device checks are still in progress.

### Build 6 source verification
Analyzer and 23 Flutter tests passed. New checks cover legacy order records without images, thumbnail/date round-trip persistence and compact English/Arabic history rows. The published build-5 presentation and review ZIP describe build 5 and remain historical review artifacts until replaced by a verified build-6 package.

## Scope clarification — 13 October 2026
The Vendor Map and biometric profile gate are marked bonus in the source brief. Manual QA and Appium sections are also marked bonus, although final completion criteria request their artifacts. Map-tile diagnosis is deferred at the owner's direction while primary functional acceptance and delivery are prioritized. Existing historical bonus evidence remains included with its version and device scope. No missing manual execution is silently marked Pass.

## Build 9 acceptance checkpoint — 13 October 2026

Analyzer and all 27 Flutter tests pass. Eight unique core emulator scenarios pass across the main run and a favourites locator retry; five required physical cases pass across the main run and two APK-install setup retries. The separate screenshot tour passes. Remaining manual cases keep their existing Not Run status. Build 9 distribution is pending Firebase renewal; build 5 remains distributed. Design fidelity and deferred map tiles remain documented gaps, so this is a review package rather than a declaration of complete capstone closure.

## Distribution closure — 14 October 2026

Build 9 upload and distribution to both authorized testers succeeded. Release `6a8l9q8aa79m0` uses the same APK checksum as the tested local artifact. This resolves the previous authentication/upload blocker; remaining design fidelity and manual QA gaps are unchanged.

## Build 10 design checkpoint — 14 October 2026

Checkout composition is closer to Figma node 10:338, with a fixed action and distinct address, instructions and contact rows. Final emulator cash checkout/history/restart and screenshot tour passed. 29 Flutter tests passed before the notice wording change and both affected Checkout tests passed again afterwards; final analyzer is clean. No new full physical-suite execution or completed manual QA matrix is claimed. Remaining Figma differences and deferred bonus map-tile diagnosis are unchanged.

Build 10 distribution succeeded, release `10m6d1qnfpap0`, with the final verified APK checksum.

## Build 11 checkpoint — 14 October 2026

31 Flutter tests passed and analyzer is clean. Native emulator Browse retry passed after a System UI infrastructure failure; original failure and passing reports are retained separately. The identical APK was distributed to both authorized testers, release `3clm3j8ki2bng`. This does not complete physical/manual QA or certify full Figma fidelity.

Build12 further passed9 core/additional emulator regression cases: three login, two Home, cart quantity/empty feedback, cache/restart, favourite/restart and cash checkout/history/restart. The separate support/navigation test brings current native coverage to10 unique cases. Physical/manual scopes remain unchanged.
