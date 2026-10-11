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
    String serial = System.getProperty("mobile.udid", "emulator-5554");
    Path apk = Path.of(System.getProperty("mobile.apk", "../flutter_app/build/app/outputs/flutter-apk/app-release.apk")).toAbsolutePath();
    if (!Files.exists(apk)) throw new IllegalArgumentException("Build StreetBite APK first");
    var options = new UiAutomator2Options().setPlatformName("Android").setDeviceName("StreetBite test device")
      .setUdid(serial).setApp(apk.toString()).setAppPackage("com.streetbite.streetbite_app")
      .setAppActivity("com.streetbite.streetbite_app.MainActivity").setNoReset(false)
      .setNewCommandTimeout(Duration.ofSeconds(120));
    driver = new AndroidDriver(URI.create(System.getProperty("mobile.server", "http://127.0.0.1:4723")).toURL(), options);
    wait = new WebDriverWait(driver, Duration.ofSeconds(30));
  }
  protected WebElement label(String text) {
    return wait.until(ExpectedConditions.visibilityOfElementLocated(AppiumBy.accessibilityId(text)));
  }
  protected void home() { label("Explore meals").click(); label("StreetBite"); }
  protected void login() { home(); label("Profile").click(); label("Log in"); }
  protected void credentials(String email, String password) {
    var fields = wait.until(d -> { var found = d.findElements(By.className("android.widget.EditText")); return found.size() >= 2 ? found : null; });
    fields.get(0).sendKeys(email); fields.get(1).sendKeys(password);
    try { driver.hideKeyboard(); } catch (WebDriverException ignored) { }
  }
  protected void screenshot(String name) throws Exception {
    String serial = System.getProperty("mobile.udid", "emulator-5554");
    String target = serial.startsWith("emulator-") ? "emulator" : "physical";
    Path path = Path.of("artifacts",target,name+".png"); Files.createDirectories(path.getParent());
    Files.write(path,driver.getScreenshotAs(OutputType.BYTES));
  }
  protected void scroll() { driver.executeScript("mobile: scrollGesture", Map.of("left",20,"top",300,"width",350,"height",500,"direction","down","percent",0.8)); }
  @AfterMethod(alwaysRun=true)
  public void teardown(ITestResult result) throws Exception {
    if (driver != null) { try { screenshot(result.getMethod().getMethodName()); } finally { driver.quit(); } }
  }
}
