package streetbite;

import io.appium.java_client.AppiumBy;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.json.Json;
import org.testng.Assert;
import org.testng.SkipException;
import org.testng.annotations.Test;

/** Synthetic-account acceptance; restores this meal's initial saved state. */
public class FavouritesTest extends BaseTest {
  private By action(String text) { return By.xpath("//*[@tooltip-text='"+text+"']"); }
  private void press(String text) {
    wait.until(ExpectedConditions.elementToBeClickable(action(text))).click();
  }
  @Test(groups="evidence") public void favouriteSurvivesRestart() throws Exception {
    String email=System.getenv("STREETBITE_TEST_EMAIL"), password=System.getenv("STREETBITE_TEST_PASSWORD");
    if(email==null || password==null) throw new SkipException("Dedicated QA account required");
    login(); credentials(email,password); button("Log in").click(); label("StreetBite");
    label("Home\nTab 1 of 4").click(); grid();
    var card=wait.until(ExpectedConditions.elementToBeClickable(AppiumBy.androidUIAutomator(
      "new UiSelector().className(\"android.widget.ImageView\").clickable(true)")));
    String name=card.getAttribute("content-desc").split("\n")[0];
    card.click(); label("Meal details");
    boolean initiallySaved=!driver.findElements(action("Remove favourite")).isEmpty();
    if(initiallySaved) { press("Remove favourite"); wait.until(ExpectedConditions.presenceOfElementLocated(action("Save favourite"))); }
    press("Save favourite");
    wait.until(ExpectedConditions.presenceOfElementLocated(action("Remove favourite")));
    screenshot("favourite-saved");
    driver.terminateApp("com.streetbite.streetbite_app");
    driver.activateApp("com.streetbite.streetbite_app");
    home(); grid();
    wait.until(ExpectedConditions.elementToBeClickable(AppiumBy.androidUIAutomator(
      "new UiSelector().descriptionStartsWith("+new Json().toJson(name)+").clickable(true)"))).click();
    label("Meal details");
    Assert.assertTrue(wait.until(ExpectedConditions.presenceOfElementLocated(action("Remove favourite"))).isDisplayed());
    screenshot("favourite-after-restart");
    press("Remove favourite");
    wait.until(ExpectedConditions.presenceOfElementLocated(action("Save favourite")));
    if(initiallySaved) {
      press("Save favourite");
      wait.until(ExpectedConditions.presenceOfElementLocated(action("Remove favourite")));
    }
  }
}
