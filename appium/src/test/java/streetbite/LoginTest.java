package streetbite;
import org.testng.Assert;
import org.testng.SkipException;
import org.testng.annotations.Test;

public class LoginTest extends BaseTest {
  @Test public void emptyFields() { login(); label("Log in").click(); Assert.assertTrue(label("Enter a valid email").isDisplayed()); }
  @Test public void invalidCredentials() {
    login(); credentials("invalid.streetbite@example.com", "InvalidPassword123!"); label("Log in").click();
    Assert.assertTrue(label("Email or password is incorrect.").isDisplayed());
  }
  @Test public void validLogin() {
    String email=System.getenv("STREETBITE_TEST_EMAIL"), password=System.getenv("STREETBITE_TEST_PASSWORD");
    if(email==null || password==null) throw new SkipException("Dedicated test credentials required; never use a real user's password");
    login(); credentials(email,password); label("Log in").click(); Assert.assertTrue(label("StreetBite").isDisplayed());
  }
}
