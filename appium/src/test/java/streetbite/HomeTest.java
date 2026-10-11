package streetbite;
import org.testng.Assert;
import org.testng.annotations.Test;
public class HomeTest extends BaseTest {
  @Test public void mealGridScroll() { home(); scroll(); Assert.assertFalse(driver.findElements(
    io.appium.java_client.AppiumBy.accessibilityId("Add to cart")).isEmpty()); }
  @Test public void addMealFeedback() { home(); scroll(); label("Add to cart").click();
    Assert.assertTrue(label("Added to your cart").isDisplayed()); }
}
