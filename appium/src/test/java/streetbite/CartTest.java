package streetbite;

import io.appium.java_client.AppiumBy;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.testng.Assert;
import org.testng.annotations.Test;

/** Quantity controls and last-item feedback on the installed beta. */
public class CartTest extends BaseTest {
  private void quantity(int expected) {
    // Flutter merges the meal name, price and count into the image semantics.
    Assert.assertTrue(wait.until(d -> d.findElements(By.className("android.widget.ImageView"))
      .stream().anyMatch(e -> {
        String description=e.getAttribute("content-desc");
        return description!=null && description.endsWith("\n"+expected);
      })));
  }
  private void tooltip(String text) {
    wait.until(ExpectedConditions.elementToBeClickable(
      By.xpath("//*[@tooltip-text='"+text+"']"))).click();
  }

  @Test(groups="evidence") public void quantityAndEmptyFeedback() throws Exception {
    home(); grid(); label("Add to cart").click(); label("Added to your cart");
    tooltip("Cart"); label("Cart");
    tooltip("Increase quantity");
    quantity(2);
    screenshot("cart-quantity-two");
    tooltip("Decrease quantity");
    quantity(1);
    tooltip("Remove");
    Assert.assertTrue(label("Your cart is empty").isDisplayed());
    // Both the empty-state body and transient feedback must be present.
    wait.until(d -> d.findElements(AppiumBy.accessibilityId("Your cart is empty")).size() >= 2);
    screenshot("cart-empty-feedback");
  }
}
