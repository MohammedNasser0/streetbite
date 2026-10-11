# StreetBite Appium suite

Java/TestNG + Appium UiAutomator2. Five scenarios: valid/invalid/empty login, home grid scroll, and add-to-cart snackbar. All classes share BaseTest and use explicit waits.

Use Java 17+, Android SDK and an Appium server with UiAutomator2 on port 4723. The installed tools in the parent `appium_mobile_testing/` may be reused; this suite is independent of that task's tests and results.

```powershell
$env:JAVA_HOME='C:\Program Files\Android\Android Studio\jbr'
$env:PATH="$env:JAVA_HOME\bin;$env:LOCALAPPDATA\Android\sdk\platform-tools;$env:PATH"
# Set STREETBITE_TEST_EMAIL / STREETBITE_TEST_PASSWORD privately for a dedicated test account.
.\gradlew.bat test -Dmobile.udid=emulator-5554
# Physical device:
.\gradlew.bat test -Dmobile.udid=YOUR_DEVICE_SERIAL -Dmobile.target=real
```

Screenshots are written to `artifacts/emulator/` or `artifacts/physical/`. Valid-login is explicitly skipped without test credentials. A skip is not a pass. Execution evidence is recorded separately; no inherited ConnectMe test result counts toward StreetBite.
