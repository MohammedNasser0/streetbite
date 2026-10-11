import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceService {
  Future<String> describe() async {
    final plugin = DeviceInfoPlugin();
    if (kIsWeb) {
      final data = await plugin.webBrowserInfo;
      return data.browserName.name;
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      final data = await plugin.androidInfo;
      return '${data.manufacturer} ${data.model} • Android ${data.version.release}';
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final data = await plugin.iosInfo;
      return '${data.utsname.machine} • iOS ${data.systemVersion}';
    }
    return defaultTargetPlatform.name;
  }
}
