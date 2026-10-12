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
