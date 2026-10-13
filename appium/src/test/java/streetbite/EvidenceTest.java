package streetbite;

import io.appium.java_client.AppiumBy;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.testng.annotations.Test;

/** Optional screenshot tours; excluded from the five functional scenarios by default. */
public class EvidenceTest extends BaseTest {
  @Test(groups="evidence") public void screenTour() throws Exception {
    label("Explore meals"); Thread.sleep(1000); screenshot("welcome");
    home();
    wait.until(d -> d.findElements(By.className("android.widget.HorizontalScrollView")).size() >= 2);
    // Let remote images finish decoding before taking presentation evidence.
    Thread.sleep(5000);
    screenshot("home-en");
    button("العربية").click(); label("ستريت بايت"); Thread.sleep(1500); screenshot("home-ar");
    button("English").click(); label("StreetBite");
    button("Change theme").click(); Thread.sleep(1500); screenshot("home-dark");
    button("Change theme").click();
    grid();
    wait.until(ExpectedConditions.elementToBeClickable(AppiumBy.androidUIAutomator(
      "new UiSelector().className(\"android.widget.ImageView\").clickable(true)"))).click();
    label("Meal details"); screenshot("meal-details");
    wait.until(ExpectedConditions.elementToBeClickable(AppiumBy.androidUIAutomator(
      "new UiSelector().descriptionStartsWith(\"Add to cart\").clickable(true)"))).click();
    label("Added to your cart"); screenshot("meal-details-added"); driver.navigate().back();
    wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//*[@tooltip-text='Cart']"))).click();
    wait.until(ExpectedConditions.visibilityOfElementLocated(AppiumBy.androidUIAutomator(
      "new UiSelector().descriptionStartsWith(\"Total:\")"))); screenshot("cart");
    button("Place demo order").click(); label("Checkout"); screenshot("checkout-overview");
    driver.navigate().back(); driver.navigate().back();
    label("Profile\nTab 4 of 4").click(); label("Log in"); screenshot("login");
    button("Create account").click(); label("Create account"); screenshot("signup");
  }
  @Test(groups="evidence") public void mapTour() throws Exception {
    home(); button("More").click(); label("Nearby vendors").click();
    label("Illustrative vendor locations");
    wait.until(ExpectedConditions.elementToBeClickable(AppiumBy.androidUIAutomator(
      "new UiSelector().descriptionContains(\"Cairo Bite\")"))).click();
    Thread.sleep(2000); // Native info-window rendering follows the marker tap.
    screenshot("vendor-map");
  }
}
