package streetbite;

import io.appium.java_client.AppiumBy;
import io.appium.java_client.android.connection.ConnectionStateBuilder;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.testng.Assert;
import org.testng.SkipException;
import org.testng.annotations.Test;
import java.util.Map;

/** Test-emulator-only interruption; restores the prior network configuration. */
public class BrowseRetryTest extends BaseTest {
 @Test(groups="evidence") public void retryPreservesFailedQuery() throws Exception {
  if(!System.getProperty("mobile.udid","emulator-5554").startsWith("emulator-"))
   throw new SkipException("Connectivity changes are restricted to the QA emulator");
  home();label("Browse\nTab 2 of 4").click();label("Browse");
  var input=wait.until(ExpectedConditions.elementToBeClickable(By.className("android.widget.EditText")));
  var original=driver.getConnection();
  try {
   driver.setConnection(new ConnectionStateBuilder().withWiFiDisabled().withDataDisabled().build());
   input.click();input.sendKeys("chicken");
   driver.executeScript("mobile: performEditorAction",Map.of("action","search"));
   try {driver.hideKeyboard();} catch(org.openqa.selenium.WebDriverException ignored){}
   label("Could not load meals. Check your connection and try again.");
   screenshot("browse-retry-error");
   Assert.assertEquals(driver.findElement(By.className("android.widget.EditText")).getText(),"chicken");
   driver.setConnection(original);
   Thread.sleep(2000); // Android needs time to restore its network route before the request.
   button("Try again").click();
   wait.until(ExpectedConditions.invisibilityOfElementLocated(AppiumBy.accessibilityId(
    "Could not load meals. Check your connection and try again.")));
   wait.until(ExpectedConditions.visibilityOfElementLocated(AppiumBy.androidUIAutomator(
    "new UiSelector().className(\"android.widget.ImageView\").clickable(true)")));
   Assert.assertEquals(driver.findElement(By.className("android.widget.EditText")).getText(),"chicken");
   Thread.sleep(2000); // Wait for the compositor and remote images before visual evidence.
   screenshot("browse-retry-results");
  } finally {driver.setConnection(original);}
 }
}
