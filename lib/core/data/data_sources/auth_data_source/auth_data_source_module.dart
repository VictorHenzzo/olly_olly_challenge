import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/data/data_sources/auth_data_source/auth_data_source.dart';
import 'package:weather_app/core/data/data_sources/auth_data_source/firebase_data_source_impl.dart';

@module
abstract class AuthDataSourceModule {
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @lazySingleton
  AuthDataSource authDataSource(final FirebaseAuth firebaseAuth) {
    return FirebaseDataSourceImpl(firebaseAuth);
  }
}
