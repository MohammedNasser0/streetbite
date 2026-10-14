package streetbite;

import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.security.MessageDigest;
import java.util.concurrent.TimeUnit;

/** Reuse is allowed only after comparing the installed APK bytes to the candidate. */
final class VerifiedInstallation {
 private static byte[] hash(Path file) throws Exception {
  var digest=MessageDigest.getInstance("SHA-256");
  try(var stream=Files.newInputStream(file)) {
   var buffer=new byte[8192]; int count;
   while((count=stream.read(buffer))!=-1) digest.update(buffer,0,count);
  }
  return digest.digest();
 }
 private static String run(String... command) throws Exception {
  var process=new ProcessBuilder(command).redirectErrorStream(true).start();
  if(!process.waitFor(60,TimeUnit.SECONDS)) {
   process.destroyForcibly(); throw new IllegalStateException("Installed APK verification timed out");
  }
  if(process.exitValue()!=0) throw new IllegalStateException("Unable to verify installed StreetBite APK");
  return new String(process.getInputStream().readAllBytes(),StandardCharsets.UTF_8);
 }
 static void check(String serial,Path candidate) throws Exception {
  if(serial.startsWith("emulator-")) throw new IllegalArgumentException("Verified reuse is for the physical test device only");
  String sdk=System.getenv("ANDROID_HOME");
  if(sdk==null) throw new IllegalStateException("ANDROID_HOME required for APK verification");
  String adb=Path.of(sdk,"platform-tools",System.getProperty("os.name").startsWith("Windows")?"adb.exe":"adb").toString();
  String installedPath=run(adb,"-s",serial,"shell","pm","path","com.streetbite.streetbite_app").lines()
   .filter(line -> line.startsWith("package:/data/app/") && line.endsWith("/base.apk"))
   .findFirst().orElseThrow(() -> new IllegalStateException("StreetBite is not installed")).substring(8);
  Path copy=Files.createTempFile("streetbite-installed-",".apk");
  try {
   run(adb,"-s",serial,"pull",installedPath,copy.toString());
   if(!MessageDigest.isEqual(hash(copy),hash(candidate)))
    throw new IllegalStateException("Installed StreetBite APK differs from the candidate");
  } finally {Files.deleteIfExists(copy);}
 }
}
