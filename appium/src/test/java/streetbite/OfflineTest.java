package streetbite;

import io.appium.java_client.AppiumBy;
import io.appium.java_client.android.connection.ConnectionStateBuilder;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.testng.Assert;
import org.testng.SkipException;
import org.testng.annotations.Test;

/** Emulator-only network interruption; restores the original connectivity in finally. */
public class OfflineTest extends BaseTest {
  @Test(groups="evidence") public void cachedMenuSurvivesOfflineRestart() throws Exception {
    if (!System.getProperty("mobile.udid", "emulator-5554").startsWith("emulator-"))
      throw new SkipException("This scenario changes connectivity only on the test emulator");
    home(); grid();
    var card=wait.until(ExpectedConditions.visibilityOfElementLocated(AppiumBy.androidUIAutomator(
      "new UiSelector().className(\"android.widget.ImageView\").clickable(true)")));
    String mealName=card.getAttribute("content-desc").split("\n")[0];
    var original=driver.getConnection();
    try {
      driver.setConnection(new ConnectionStateBuilder().withWiFiDisabled().withDataDisabled().build());
      driver.terminateApp("com.streetbite.streetbite_app");
      driver.activateApp("com.streetbite.streetbite_app");
      home(); grid();
      Assert.assertTrue(wait.until(ExpectedConditions.visibilityOfElementLocated(
        AppiumBy.androidUIAutomator("new UiSelector().descriptionStartsWith(\""+mealName+"\")"))).isDisplayed());
      label("Add to cart").click();
      Assert.assertTrue(label("Added to your cart").isDisplayed());
      screenshot("offline-menu-after-restart");
    } finally {
      driver.setConnection(original);
    }
  }
}
