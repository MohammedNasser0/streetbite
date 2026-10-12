# Test closure — work in progress

Final acceptance remains open. Fourteen Flutter unit/widget tests and eight Appium emulator scenarios passed on the Maps-enabled build 4. Two additional screenshot tours passed, including Maps rendering and marker interaction on the installed beta. Ten direct authenticated Firestore REST checks passed. Email/Password authentication and Firebase beta distribution were verified.

See [emulator verification](emulator-verification.md) for versions, scope and evidence. Backend REST checks do not establish end-to-end signup, profile or checkout behavior.

The five required Appium cases passed on a physical OPPO Android 16 phone using the initial build 4 artifact; see [physical verification](physical-verification.md) for exact scope. Real-device manual results, completed biometric/gallery evidence, full Figma fidelity and full app-flow acceptance remain open. User-supplied Firebase dashboard screenshots confirm version 1.0.0 (1), two invited testers and zero accepted/downloaded. No manual case is marked passed without execution.

## Build 4 offline verification

On the Maps-enabled build 4 emulator, cached meal metadata survived network disconnection and app termination/relaunch; adding a cached meal to the cart showed confirmation. Network settings were restored in test cleanup. This is an emulator result. Image bytes are not persistently cached: offline images use the restaurant placeholder. The first draft test incorrectly required an Android ImageView offline; that assertion failed, while meal text was present. The corrected test checks cached metadata and cart usability, not offline photo persistence.
