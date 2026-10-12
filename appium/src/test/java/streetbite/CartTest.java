package streetbite;

import io.appium.java_client.AppiumBy;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.testng.Assert;
import org.testng.annotations.Test;

/** Quantity controls and last-item feedback on the installed beta. */
public class CartTest extends BaseTest {
  private void tooltip(String text) {
    wait.until(ExpectedConditions.elementToBeClickable(
      By.xpath("//*[@tooltip-text='"+text+"']"))).click();
  }

  @Test(groups="evidence") public void quantityAndEmptyFeedback() throws Exception {
    home(); grid(); label("Add to cart").click(); label("Added to your cart");
    tooltip("Cart"); label("Cart");
    tooltip("Increase quantity");
    Assert.assertTrue(label("2").isDisplayed());
    screenshot("cart-quantity-two");
    tooltip("Decrease quantity");
    Assert.assertTrue(label("1").isDisplayed());
    tooltip("Remove");
    Assert.assertTrue(label("Your cart is empty").isDisplayed());
    // Both the empty-state body and transient feedback must be present.
    wait.until(d -> d.findElements(AppiumBy.accessibilityId("Your cart is empty")).size() >= 2);
    screenshot("cart-empty-feedback");
  }
}
