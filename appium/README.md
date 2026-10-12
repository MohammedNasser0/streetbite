# StreetBite Appium suite

Java/TestNG + Appium UiAutomator2. Five scenarios: valid/invalid/empty login, home grid scroll, and add-to-cart snackbar. All classes share BaseTest and use explicit waits.

Use Java 17+, Android SDK and an Appium server with UiAutomator2 on port 4723. The installed tools in the parent `appium_mobile_testing/` may be reused; this suite is independent of that task's tests and results.

```powershell
$env:JAVA_HOME='C:\Program Files\Android\Android Studio\jbr'
$env:PATH="$env:JAVA_HOME\bin;$env:LOCALAPPDATA\Android\sdk\platform-tools;$env:PATH"
# Set STREETBITE_TEST_EMAIL / STREETBITE_TEST_PASSWORD privately for a dedicated test account.
.\gradlew.bat test '-Dmobile.udid=emulator-5554'
# Physical device:
.\gradlew.bat test '-Dmobile.udid=YOUR_DEVICE_SERIAL' '-Dmobile.target=real'
```

Screenshots are written to `artifacts/emulator/` or `artifacts/physical/`. Valid-login is explicitly skipped without test credentials. A skip is not a pass. Execution evidence is recorded separately; no inherited ConnectMe test result counts toward StreetBite.

The driver forces APK installation so a previous build with the same version code cannot silently be reused. On 12 October 2026, all five functional scenarios passed without skips. Optional screenshot tours and the QA-only live checkout test use the `evidence` group and are excluded from the default run:

```powershell
.\gradlew.bat test --tests streetbite.EvidenceTest '-Dmobile.evidence=true' '-Dmobile.udid=emulator-5554'
.\gradlew.bat test --tests streetbite.CheckoutTest '-Dmobile.evidence=true' '-Dmobile.udid=emulator-5554'
```

The checkout test creates a demo order in the dedicated QA account. Use no real customer data. Public screenshots exclude private QA credentials and raw Appium server logs.
