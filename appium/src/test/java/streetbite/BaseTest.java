package streetbite;

import io.appium.java_client.AppiumBy;
import io.appium.java_client.android.AndroidDriver;
import io.appium.java_client.android.options.UiAutomator2Options;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.annotations.*;
import org.testng.ITestResult;
import java.net.URI;
import java.nio.file.*;
import java.time.Duration;
import java.util.Map;

public abstract class BaseTest {
  protected AndroidDriver driver;
  protected WebDriverWait wait;
  @BeforeMethod
  public void setup() throws Exception {
    driver = null;
    String serial = System.getProperty("mobile.udid", "emulator-5554");
    Path apk = Path.of(System.getProperty("mobile.apk", "../flutter_app/build/app/outputs/flutter-apk/app-release.apk")).toAbsolutePath();
    if (!Files.exists(apk)) throw new IllegalArgumentException("Build StreetBite APK first");
    boolean reuse=Boolean.getBoolean("mobile.reuseVerifiedInstall");
    if(reuse) VerifiedInstallation.check(serial,apk);
    var options = new UiAutomator2Options().setPlatformName("Android").setDeviceName("StreetBite test device")
      .setUdid(serial).setApp(apk.toString()).setAppPackage("com.streetbite.streetbite_app")
      .setAppActivity("com.streetbite.streetbite_app.MainActivity").setNoReset(reuse)
      .setNewCommandTimeout(Duration.ofSeconds(120));
    options.setCapability("appium:enforceAppInstall", !reuse);
    // Some OEM phones deny `pm clear` to ADB. A fresh test-only install avoids
    // that permission without changing the phone's security settings.
    if (!serial.startsWith("emulator-")) {
      options.setFullReset(!reuse);
      // OEM install scanning may outlast the default 90-second setup timeout.
      options.setCapability("appium:androidInstallTimeout", 180000);
    }
    driver = new AndroidDriver(URI.create(System.getProperty("mobile.server", "http://127.0.0.1:4723")).toURL(), options);
    wait = new WebDriverWait(driver, Duration.ofSeconds(30));
    wait.ignoring(StaleElementReferenceException.class);
  }
  protected WebElement label(String text) {
    return wait.until(ExpectedConditions.visibilityOfElementLocated(AppiumBy.accessibilityId(text)));
  }
  protected void home() { label("Explore meals").click(); label("StreetBite"); }
  protected void login() { home(); label("Profile\nTab 4 of 4").click(); label("Log in"); }
  protected WebElement button(String text) {
    return wait.until(ExpectedConditions.elementToBeClickable(AppiumBy.androidUIAutomator(
      "new UiSelector().description(\""+text+"\").clickable(true)")));
  }
  protected void grid() {
    wait.until(d -> d.findElements(By.className("android.widget.HorizontalScrollView")).size() >= 2);
    for (int attempt=0; attempt<4; attempt++) {
      scroll();
      if (!driver.findElements(AppiumBy.accessibilityId("Add to cart")).isEmpty()) return;
    }
    throw new AssertionError("Meal grid was not reachable after scrolling");
  }
  protected void credentials(String email, String password) {
    focusField(0).sendKeys(email);
    focusField(1).sendKeys(password);
    try { driver.hideKeyboard(); } catch (WebDriverException ignored) { }
  }
  protected WebElement focusField(int index) {
    return wait.until(d -> {
      var fields=d.findElements(By.className("android.widget.EditText"));
      if(fields.size()<=index) return null;
      var field=fields.get(index);
      field.click();
      field=d.findElements(By.className("android.widget.EditText")).get(index);
      return "true".equals(field.getAttribute("focused")) ? field : null;
    });
  }
  protected void screenshot(String name) throws Exception {
    String serial = System.getProperty("mobile.udid", "emulator-5554");
    String target = serial.startsWith("emulator-") ? "emulator" : "physical";
    Path path = Path.of("artifacts",target,name+".png"); Files.createDirectories(path.getParent());
    Files.write(path,driver.getScreenshotAs(OutputType.BYTES));
    Files.writeString(path.resolveSibling(name+".xml"), driver.getPageSource());
  }
  protected void scroll() {
    var size = driver.manage().window().getSize();
    driver.executeScript("mobile: scrollGesture", Map.of(
      "left", (int)(size.width*0.1), "top", (int)(size.height*0.45),
      "width", (int)(size.width*0.8), "height", (int)(size.height*0.35),
      "direction", "down", "percent", 0.9));
  }
  @AfterMethod(alwaysRun=true)
  public void teardown(ITestResult result) throws Exception {
    if (driver != null) { try { screenshot(result.getMethod().getMethodName()); } finally { driver.quit(); driver = null; } }
  }
}
