package streetbite;

import org.testng.Assert;
import org.testng.annotations.Test;
import org.openqa.selenium.json.Json;
import java.nio.file.*;
import java.net.URI;
import java.net.http.*;
import java.time.Duration;
import java.util.*;

/** Optional form acceptance. Inputs are synthetic and should never reach Firebase. */
public class SignupTest extends BaseTest {
  @Test(groups="evidence") public void numericNameIsRejected() throws Exception {
    login(); button("Create account").click(); label("Create account");
    focusField(0).sendKeys("123 Invalid");
    focusField(1).sendKeys("qa.invalidname@example.com");
    focusField(2).sendKeys("NotARealPassword123!");
    focusField(3).sendKeys("NotARealPassword123!");
    try { driver.hideKeyboard(); } catch (org.openqa.selenium.WebDriverException ignored) { }
    button("Create account").click();
    Assert.assertTrue(label("Enter a name starting with a capital letter").isDisplayed());
    screenshot("signup-name-validation");
  }
  @Test(groups="evidence") @SuppressWarnings("unchecked")
  public void validSignupPersistsProfile() throws Exception {
    String email="qa.signup."+System.currentTimeMillis()+"@streetbite.example";
    String password="Qa!"+UUID.randomUUID();
    Json json=new Json();
    Path fixture=Path.of("artifacts","qa-signup-account.json"); Files.createDirectories(fixture.getParent());
    Files.writeString(fixture,json.toJson(Map.of("email",email,"password",password)));
    login(); button("Create account").click(); label("Create account");
    focusField(0).sendKeys("StreetBite QA");
    focusField(1).sendKeys(email);
    focusField(2).sendKeys(password);
    focusField(3).sendKeys(password);
    try { driver.hideKeyboard(); } catch (org.openqa.selenium.WebDriverException ignored) { }
    button("Create account").click(); label("StreetBite");

    // Verify the Builder-created profile using this account's own ID token.
    // Private configuration and generated credentials are never logged or published.
    Map<String,Object> config=json.toType(Files.readString(Path.of("../flutter_app/android/app/google-services.json")),Map.class);
    Map<String,Object> client=(Map<String,Object>)((List<?>)config.get("client")).get(0);
    Map<String,Object> api=(Map<String,Object>)((List<?>)client.get("api_key")).get(0);
    var http=HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(15)).build();
    var signIn=HttpRequest.newBuilder(URI.create("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key="+api.get("current_key")))
      .timeout(Duration.ofSeconds(20)).header("Content-Type","application/json")
      .POST(HttpRequest.BodyPublishers.ofString(json.toJson(Map.of("email",email,"password",password,"returnSecureToken",true)))).build();
    var response=http.send(signIn,HttpResponse.BodyHandlers.ofString());
    Assert.assertEquals(response.statusCode(),200,"QA account should exist after successful signup");
    Map<String,Object> auth=json.toType(response.body(),Map.class);
    var profile=HttpRequest.newBuilder(URI.create("https://firestore.googleapis.com/v1/projects/streetbite-6dd3c/databases/(default)/documents/users/"+auth.get("localId")))
      .timeout(Duration.ofSeconds(15)).header("Authorization","Bearer "+auth.get("idToken")).GET().build();
    wait.until(d -> {
      try {
        var result=http.send(profile,HttpResponse.BodyHandlers.ofString());
        if(result.statusCode()!=200) return false;
        Map<String,Object> data=json.toType(result.body(),Map.class);
        Map<String,Object> fields=(Map<String,Object>)data.get("fields");
        return "StreetBite QA".equals(((Map<?,?>)fields.get("name")).get("stringValue"));
      } catch (Exception error) { return false; }
    });
    screenshot("signup-success");
  }
}
