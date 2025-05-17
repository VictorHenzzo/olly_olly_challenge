import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/core/infra/env/environment.dart';

class FirebaseInitializer {
  const FirebaseInitializer();

  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: _getOptionsByPlatform(),
    );
  }

  FirebaseOptions _getOptionsByPlatform() {
    const env = Environment();

    if (kIsWeb) {
      return env.web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return env.android;
      case TargetPlatform.iOS:
        return env.ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for $defaultTargetPlatform',
        );
    }
  }
}
