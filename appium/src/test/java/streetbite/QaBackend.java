package streetbite;

import org.openqa.selenium.json.Json;
import java.net.URI;
import java.net.http.*;
import java.nio.file.*;
import java.time.Duration;
import java.util.*;

/** Owner-token read access for a synthetic QA account. Never logs credentials or tokens. */
final class QaBackend {
  private final Json json = new Json();
  private final HttpClient http = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(15)).build();
  private final HttpRequest profile;

  @SuppressWarnings("unchecked") QaBackend(String email, String password) throws Exception {
    Map<String,Object> config=json.toType(Files.readString(Path.of("../flutter_app/android/app/google-services.json")),Map.class);
    Map<String,Object> client=(Map<String,Object>)((List<?>)config.get("client")).get(0);
    Map<String,Object> api=(Map<String,Object>)((List<?>)client.get("api_key")).get(0);
    var signIn=HttpRequest.newBuilder(URI.create("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key="+api.get("current_key")))
      .timeout(Duration.ofSeconds(20)).header("Content-Type","application/json")
      .POST(HttpRequest.BodyPublishers.ofString(json.toJson(Map.of("email",email,"password",password,"returnSecureToken",true)))).build();
    var response=http.send(signIn,HttpResponse.BodyHandlers.ofString());
    if(response.statusCode()!=200) throw new IllegalStateException("QA sign-in HTTP "+response.statusCode());
    Map<String,Object> auth=json.toType(response.body(),Map.class);
    profile=HttpRequest.newBuilder(URI.create("https://firestore.googleapis.com/v1/projects/streetbite-6dd3c/databases/(default)/documents/users/"+auth.get("localId")))
      .timeout(Duration.ofSeconds(15)).header("Authorization","Bearer "+auth.get("idToken")).GET().build();
  }

  @SuppressWarnings("unchecked") String field(String name) throws Exception {
    var result=http.send(profile,HttpResponse.BodyHandlers.ofString());
    if(result.statusCode()!=200) throw new IllegalStateException("QA profile HTTP "+result.statusCode());
    Map<String,Object> data=json.toType(result.body(),Map.class);
    Map<String,Object> fields=(Map<String,Object>)data.get("fields");
    Object value=fields.get(name);
    return value instanceof Map<?,?> field ? Objects.toString(field.get("stringValue"), "") : "";
  }

  @SuppressWarnings("unchecked") boolean orderHasDeliveryPin(String orderId) throws Exception {
    if (!orderId.matches("[0-9]+")) throw new IllegalArgumentException("Expected demo order ID");
    var request=HttpRequest.newBuilder(URI.create(profile.uri()+"/orders/"+orderId))
      .timeout(Duration.ofSeconds(15))
      .header("Authorization",profile.headers().firstValue("Authorization").orElseThrow()).GET().build();
    var response=http.send(request,HttpResponse.BodyHandlers.ofString());
    if(response.statusCode()!=200) throw new IllegalStateException("QA order HTTP "+response.statusCode());
    Map<String,Object> document=json.toType(response.body(),Map.class);
    Map<String,Object> fields=(Map<String,Object>)document.get("fields");
    Map<String,Object> address=(Map<String,Object>)fields.get("address");
    Map<String,Object> value=(Map<String,Object>)address.get("mapValue");
    Map<String,Object> coordinates=(Map<String,Object>)value.get("fields");
    if(!coordinates.containsKey("latitude") || !coordinates.containsKey("longitude")) return false;
    double lat=Double.parseDouble((String)((Map<?,?>)coordinates.get("latitude")).get("stringValue"));
    double lng=Double.parseDouble((String)((Map<?,?>)coordinates.get("longitude")).get("stringValue"));
    return Double.isFinite(lat) && Double.isFinite(lng) && Math.abs(lat)<=90 && Math.abs(lng)<=180;
  }
}
