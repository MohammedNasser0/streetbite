import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

// Separate configuration is required; ConnectMe's project is never reused.
Future<bool> initializeFirebase() async {
  const project = String.fromEnvironment('FIREBASE_PROJECT_ID');
  const key = String.fromEnvironment('FIREBASE_API_KEY');
  const appId = String.fromEnvironment('FIREBASE_APP_ID');
  const sender = String.fromEnvironment('FIREBASE_SENDER_ID');
  try {
    await Firebase.initializeApp(
      options: project.isEmpty
          ? streetBiteFirebaseOptions
          : const FirebaseOptions(
              apiKey: key,
              appId: appId,
              messagingSenderId: sender,
              projectId: project,
            ),
    );
    return true;
  } catch (_) {
    return false;
  }
}
