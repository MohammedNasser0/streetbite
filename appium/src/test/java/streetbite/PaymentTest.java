package streetbite;

import io.appium.java_client.AppiumBy;
import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.testng.Assert;
import org.testng.annotations.Test;

/** Verifies the fixed-data demo payment route without collecting card credentials. */
public class PaymentTest extends BaseTest {
  @Test(groups="evidence") public void demoCardSelection() throws Exception {
    home(); grid(); label("Add to cart").click();
    wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//*[@tooltip-text='Cart']"))).click();
    button("Place demo order").click();
    label("Cash on delivery").click(); label("Demo card payment").click();
    label("Add demo card");
    Assert.assertTrue(driver.findElements(By.className("android.widget.EditText")).isEmpty());
    Assert.assertTrue(label("Simulation only. Fixed sample details; no real card information or payment is collected.").isDisplayed());
    screenshot("demo-card");
    button("Use demo card").click();
    Assert.assertTrue(label("Demo card payment").isDisplayed());
    screenshot("checkout-demo-card");
  }
}
