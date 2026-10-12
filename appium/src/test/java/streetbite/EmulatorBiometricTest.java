package streetbite;

import io.appium.java_client.AppiumBy;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.SkipException;
import org.testng.annotations.Test;
import java.time.Duration;

/** Emulator-only visual evidence; does not replace physical biometric acceptance. */
public class EmulatorBiometricTest extends BaseTest {
  @Test(groups="evidence") public void emulatorBiometricPrompt() throws Exception {
    if (!System.getProperty("mobile.udid", "emulator-5554").startsWith("emulator-"))
      throw new SkipException("Emulator evidence only");
    String email=System.getenv("STREETBITE_TEST_EMAIL"), password=System.getenv("STREETBITE_TEST_PASSWORD");
    if (email==null || password==null) throw new SkipException("Dedicated QA account required");
    login(); credentials(email,password); button("Log in").click(); label("StreetBite");
    label("Profile\nTab 4 of 4").click();
    button("Unlock profile with fingerprint").click();
    System.out.println("EMULATOR_PROMPT_READY: Capture the visible emulator window before authentication.");
    screenshot("emulator-biometric-prompt");
    new WebDriverWait(driver, Duration.ofSeconds(240)).until(
      ExpectedConditions.visibilityOfElementLocated(AppiumBy.accessibilityId("Change photo")));
    screenshot("emulator-profile-unlocked");
  }
}
