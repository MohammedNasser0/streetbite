package streetbite;

import org.testng.annotations.Test;

/** Guest-accessible support and section navigation; no account or biometric bypass. */
public class SupportNavigationTest extends BaseTest {
 @Test(groups="evidence") public void supportAndSectionNavigation() throws Exception {
  home();
  label("Browse\nTab 2 of 4").click();
  label("Orders\nTab 3 of 4").click();
  label("Home\nTab 1 of 4").click();
  label("StreetBite");
  button("More").click();
  label("Help center").click();
  screenshot("help-center-build12");
  driver.navigate().back();
  label("Contact us").click();
  label("https://github.com/MohammedNasser0/streetbite");
  screenshot("contact-build12");
  driver.navigate().back();
  driver.navigate().back();
  label("StreetBite");
 }
}
