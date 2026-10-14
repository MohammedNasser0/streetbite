package streetbite;

import io.appium.java_client.AppiumBy;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.testng.Assert;
import org.testng.annotations.Test;

/** Synthetic guest address; no personal location, real order or payment. */
public class DesignFlowTest extends BaseTest {
 @Test(groups="evidence") public void sharedAddressAndGroupedCart() throws Exception {
  home();
  label("Delivery address").click();
  focusField(0).sendKeys("StreetBite QA Street 13");
  try { driver.hideKeyboard(); } catch (org.openqa.selenium.WebDriverException ignored) {}
  button("Save address").click();
  label("StreetBite QA Street 13");
  screenshot("home-address-build13");
  button("Menu").click();
  label("All meals");
  screenshot("grouped-menu-build13");
  button("Add to cart").click();
  label("Added to your cart");
  wait.until(ExpectedConditions.elementToBeClickable(AppiumBy.androidUIAutomator(
    "new UiSelector().descriptionStartsWith(\"Cart • 1\").clickable(true)"))).click();
  label("Subtotal"); label("Additional charges");
  screenshot("cart-summary-build13");
  button("Place demo order").click();
  label("Checkout");
  Assert.assertTrue(label("StreetBite QA Street 13").isDisplayed());
  screenshot("checkout-shared-address-build13");
 }

 @Test(groups="evidence") public void categoriesAndDetailsQuantity() throws Exception {
  home(); label("Browse\nTab 2 of 4").click();
  label("Categories"); screenshot("browse-categories-build13");
  label("All meals").click();
  wait.until(ExpectedConditions.elementToBeClickable(AppiumBy.androidUIAutomator(
    "new UiSelector().className(\"android.widget.ImageView\").clickable(true)"))).click();
  label("Meal details");
  wait.until(ExpectedConditions.elementToBeClickable(AppiumBy.androidUIAutomator(
    "new UiSelector().descriptionStartsWith(\"Add to cart •\").clickable(true)"))).click();
  label("Added to your cart");
  wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//*[@tooltip-text='Increase quantity']"))).click();
  screenshot("details-quantity-build13");
  wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//*[@tooltip-text='Cart']"))).click();
  Assert.assertTrue(wait.until(d -> d.findElements(By.className("android.widget.ImageView"))
    .stream().anyMatch(e -> {
      String description=e.getAttribute("content-desc");
      return description!=null && description.endsWith("\n2");
    })));
 }
}
