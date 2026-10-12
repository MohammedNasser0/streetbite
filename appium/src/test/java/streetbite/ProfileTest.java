package streetbite;

import io.appium.java_client.AppiumBy;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;
import org.testng.SkipException;
import org.testng.annotations.Test;
import org.openqa.selenium.json.Json;
import java.time.Duration;

/** Physical-device acceptance. The device owner completes fingerprint authentication. */
public class ProfileTest extends BaseTest {
  private void profileName(String expectedName) {
    Assert.assertTrue(wait.until(ExpectedConditions.visibilityOfElementLocated(
      AppiumBy.androidUIAutomator("new UiSelector().descriptionStartsWith("+
        new Json().toJson(expectedName)+")"))).isDisplayed());
  }
  @Test(groups="evidence") public void fingerprintAndProfile() throws Exception {
    if (System.getProperty("mobile.udid", "emulator-5554").startsWith("emulator-"))
      throw new SkipException("An enrolled physical device and its owner are required");
    String email=System.getenv("STREETBITE_TEST_EMAIL"), password=System.getenv("STREETBITE_TEST_PASSWORD");
    if(email==null || password==null) throw new SkipException("Dedicated QA account required");
    var backend=new QaBackend(email,password);
    String expectedName=backend.field("name");
    Assert.assertFalse(expectedName.isBlank(), "QA account needs a named profile");
    String initialPhoto=backend.field("photo");
    login(); credentials(email,password); button("Log in").click(); label("StreetBite");
    label("Profile\nTab 4 of 4").click();
    button("Unlock profile with fingerprint").click();
    System.out.println("OWNER_ACTION_REQUIRED: Touch the phone fingerprint sensor.");
    screenshot("biometric-prompt");
    new WebDriverWait(driver, Duration.ofSeconds(180)).until(
      ExpectedConditions.visibilityOfElementLocated(AppiumBy.accessibilityId("Change photo")));
    Assert.assertTrue(label("Change photo").isDisplayed());
    Assert.assertTrue(label("Favourites").isDisplayed());
    profileName(expectedName);
    Assert.assertTrue(wait.until(ExpectedConditions.visibilityOfElementLocated(
      AppiumBy.androidUIAutomator("new UiSelector().descriptionContains(\"Android\")"))).isDisplayed());
    screenshot("profile-device-details");
    if (Boolean.getBoolean("mobile.photo")) {
      button("Change photo").click();
      System.out.println("OWNER_ACTION_REQUIRED: Select the supplied StreetBiteQA.png sample in the photo picker.");
      new WebDriverWait(driver, Duration.ofSeconds(180)).until(d -> {
        try { String photo=backend.field("photo"); return !photo.isBlank() && !photo.equals(initialPhoto); }
        catch(Exception error) { return false; }
      });
      label("Change photo"); screenshot("profile-photo");
      String savedPhoto=backend.field("photo");
      driver.terminateApp("com.streetbite.streetbite_app");
      driver.activateApp("com.streetbite.streetbite_app");
      home(); label("Profile\nTab 4 of 4").click();
      button("Unlock profile with fingerprint").click();
      System.out.println("OWNER_ACTION_REQUIRED: Authenticate again after app restart.");
      new WebDriverWait(driver, Duration.ofSeconds(180)).until(
        ExpectedConditions.visibilityOfElementLocated(AppiumBy.accessibilityId("Change photo")));
      profileName(expectedName);
      Assert.assertEquals(backend.field("photo"),savedPhoto,"Profile photo survives restart");
      screenshot("profile-photo-after-restart");
    }
  }
}
