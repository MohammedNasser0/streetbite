# Delivery checklist

- [ ] Inspect every Figma frame after sign-in; record frame-to-screen mapping.
- [x] Configure dedicated Firebase project and deploy tested rules (ten live REST access checks passed).
- [ ] Enable Maps SDK and restrict Android/iOS keys.
- [ ] Implement and verify all functional requirements.
- [x] `dart format lib test`, `flutter analyze`, `flutter test` (fourteen tests passed).
- [ ] Test English/Arabic, light/dark, two screen sizes and restart/offline flows.
- [x] Build beta APK using the development signing key; record checksum/version. Production signing remains pending.
- [x] Upload to Firebase App Distribution and invite two user-specified testers. User-supplied dashboard evidence confirms two invited, zero accepted/downloaded.
- [ ] Record actual real-device QA, Jira defects, traceability and closure.
- [x] Execute Appium login, scrolling and cart scenarios on emulator and device. Five physical cases passed on initial build 4; artifact-specific scope is in physical-verification.md.
- [ ] Complete remaining screenshots (profile/device details and biometrics). Onboarding, auth, home EN/AR/dark, details, cart and Maps captured on emulator.
- [x] Publish public GitHub repository and presentation. Final acceptance remains open.

## Latest local artifact

The Maps-enabled build 4 APK passed eight emulator Appium cases (login, home, Maps, cash checkout/history and demo-card selection), zero failures/skips. SHA256: `8a6c53e8e5a57af4197c2e65643f997bb1feeeef1802fc21581135be465e0f47`. Firebase upload and distribution to both authorized testers succeeded (release `3e6bqgorl8k0g`). All five required physical cases subsequently passed on this exact artifact across two runs; the owner-assisted profile/photo/restart scenario also passed.
