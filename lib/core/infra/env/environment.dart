import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

@injectable
class Environment {
  const Environment();

  String get weatherApiKey => const String.fromEnvironment(
        'weather_api_key',
      );
  String get weatherApiBaseUrl => const String.fromEnvironment(
        'weather_api_base_url',
      );
  String get weatherApiIconUrl => const String.fromEnvironment(
        'weather_api_icon_url',
      );

  FirebaseOptions get web => const FirebaseOptions(
        apiKey: String.fromEnvironment('web_firebase_apiKey'),
        appId: String.fromEnvironment('web_firebase_appId'),
        messagingSenderId:
            String.fromEnvironment('web_firebase_messagingSenderId'),
        projectId: String.fromEnvironment('web_firebase_projectId'),
        authDomain: String.fromEnvironment('web_firebase_authDomain'),
        storageBucket: String.fromEnvironment('web_firebase_storageBucket'),
      );

  FirebaseOptions get android => const FirebaseOptions(
        apiKey: String.fromEnvironment('android_firebase_apiKey'),
        appId: String.fromEnvironment('android_firebase_appId'),
        messagingSenderId:
            String.fromEnvironment('android_firebase_messagingSenderId'),
        projectId: String.fromEnvironment('android_firebase_projectId'),
        storageBucket: String.fromEnvironment('android_firebase_storageBucket'),
      );

  FirebaseOptions get ios => const FirebaseOptions(
        apiKey: String.fromEnvironment('ios_firebase_apiKey'),
        appId: String.fromEnvironment('ios_firebase_appId'),
        messagingSenderId:
            String.fromEnvironment('ios_firebase_messagingSenderId'),
        projectId: String.fromEnvironment('ios_firebase_projectId'),
        storageBucket: String.fromEnvironment('ios_firebase_storageBucket'),
        iosBundleId: String.fromEnvironment('ios_firebase_iosBundleId'),
      );
}
