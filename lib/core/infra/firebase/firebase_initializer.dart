import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/core/infra/env/environment.dart';

/// Handles the initialization of Firebase services for the application.
/// Provides platform-specific configuration for Firebase initialization.
class FirebaseInitializer {
  const FirebaseInitializer();

  /// Initializes Firebase with platform-specific options.
  /// This method should be called during app startup before using any Firebase services.
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
