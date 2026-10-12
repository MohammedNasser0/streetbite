# StreetBite Appium suite

Java/TestNG + Appium UiAutomator2. Five scenarios: valid/invalid/empty login, home grid scroll, and add-to-cart snackbar. All classes share BaseTest and use explicit waits.

Use Java 17+, Android SDK and an Appium server with UiAutomator2 on port 4723. The installed tools in the parent `appium_mobile_testing/` may be reused; this suite is independent of that task's tests and results.

```powershell
$env:JAVA_HOME='C:\Program Files\Android\Android Studio\jbr'
$env:PATH="$env:JAVA_HOME\bin;$env:LOCALAPPDATA\Android\sdk\platform-tools;$env:PATH"
# Set STREETBITE_TEST_EMAIL / STREETBITE_TEST_PASSWORD privately for a dedicated test account.
.\gradlew.bat test '-Dmobile.udid=emulator-5554'
# Physical device:
.\gradlew.bat test '-Dmobile.udid=YOUR_DEVICE_SERIAL' '-Dmobile.target=physical'
```

Screenshots are written to `artifacts/emulator/` or `artifacts/physical/`. Valid-login is explicitly skipped without test credentials. A skip is not a pass. Execution evidence is recorded separately; no inherited ConnectMe test result counts toward StreetBite.

The driver forces APK installation so a previous build with the same version code cannot silently be reused. On 12 October 2026, all five functional scenarios passed without skips. Optional screenshot tours and the QA-only live checkout test use the `evidence` group and are excluded from the default run:

```powershell
.\gradlew.bat test --tests streetbite.EvidenceTest '-Dmobile.evidence=true' '-Dmobile.udid=emulator-5554'
.\gradlew.bat test --tests streetbite.CheckoutTest '-Dmobile.evidence=true' '-Dmobile.udid=emulator-5554'
.\gradlew.bat test --tests streetbite.SignupTest '-Dmobile.evidence=true' '-Dmobile.udid=emulator-5554'
```

The checkout test creates a demo order in the dedicated QA account. Use no real customer data. Public screenshots exclude private QA credentials and raw Appium server logs.

SignupTest contains numeric-name validation and successful signup/profile persistence checks. The positive case requires the ignored Android `google-services.json` to verify Firestore with the new account's own token. Generated QA credentials are stored only in ignored `artifacts/qa-signup-account.json`. Both signup cases passed separately on build 3; the seven-scenario run was on build 2.

Optional acceptance classes also include PaymentTest (fixed-data card selection), CartTest (quantity and empty-cart feedback), OfflineTest (emulator-only network interruption with connectivity restored in finally), and ProfileTest (owner-assisted fingerprint/profile). Run these explicitly with `-Dmobile.evidence=true`.

ProfileTest needs the physical device owner to touch the enrolled fingerprint sensor. Add `-Dmobile.photo=true` only when the owner can choose a new non-personal test thumbnail and authenticate again after restart. Native XML, credential fixtures and logs stay ignored; reviewed physical screenshots are included only in the private delivery ZIP at the owner's request.

### Additional build-5 evidence
CartTest and EmulatorBiometricTest passed on the enrolled emulator. The biometric case pauses for a Windows capture and unlocks only after a simulated sensor touch. It supplements physical acceptance and must not be represented as physical-device execution.
