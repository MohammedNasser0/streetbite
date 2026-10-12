package streetbite;

import io.appium.java_client.AppiumBy;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.testng.Assert;
import org.testng.SkipException;
import org.testng.annotations.Test;

/** Optional live acceptance workflow, using only a dedicated QA account and demo order. */
public class CheckoutTest extends BaseTest {
  @Test(groups="evidence") public void cashOrderAndHistory() throws Exception {
    String email=System.getenv("STREETBITE_TEST_EMAIL"), password=System.getenv("STREETBITE_TEST_PASSWORD");
    if(email==null || password==null) throw new SkipException("Dedicated QA account required");
    login(); credentials(email,password); button("Log in").click(); label("StreetBite");
    label("Home\nTab 1 of 4").click(); grid();
    var card=wait.until(ExpectedConditions.elementToBeClickable(AppiumBy.androidUIAutomator(
      "new UiSelector().className(\"android.widget.ImageView\").clickable(true)")));
    String mealName=card.getAttribute("content-desc").split("\n")[0];
    card.click(); label("Meal details");
    wait.until(ExpectedConditions.elementToBeClickable(AppiumBy.androidUIAutomator(
      "new UiSelector().descriptionStartsWith(\"Add to cart\").clickable(true)"))).click();
    label("Added to your cart");
    driver.navigate().back();
    wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//*[@tooltip-text='Cart']"))).click();
    button("Place demo order").click(); button("Place demo order").click();
    label("Delivery address");
    var address=wait.until(ExpectedConditions.elementToBeClickable(By.className("android.widget.EditText")));
    address.click(); address.sendKeys("QA Test Street, Cairo");
    try { driver.hideKeyboard(); } catch (org.openqa.selenium.WebDriverException ignored) { }
    button("Save address").click();
    Assert.assertTrue(label("Order received").isDisplayed()); screenshot("order-received");
    button("Home").click();
    label("Order history\nTab 3 of 4").click();
    Assert.assertTrue(wait.until(ExpectedConditions.visibilityOfElementLocated(
      AppiumBy.androidUIAutomator("new UiSelector().descriptionStartsWith(\""+mealName+"\")"))).isDisplayed());
    screenshot("order-history");
    driver.terminateApp("com.streetbite.streetbite_app");
    driver.activateApp("com.streetbite.streetbite_app");
    home(); label("Order history\nTab 3 of 4").click();
    Assert.assertTrue(wait.until(ExpectedConditions.visibilityOfElementLocated(
      AppiumBy.androidUIAutomator("new UiSelector().descriptionStartsWith(\""+mealName+"\")"))).isDisplayed());
    screenshot("order-history-after-restart");
  }
}
