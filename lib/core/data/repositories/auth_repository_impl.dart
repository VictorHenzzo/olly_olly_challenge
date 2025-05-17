import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:weather_app/core/data/data_sources/auth_data_source/auth_data_source.dart';
import 'package:weather_app/core/data/data_sources/auth_data_source/auth_data_source_exception.dart';
import 'package:weather_app/core/domain/enums/auth/auth_status.dart';
import 'package:weather_app/core/domain/exceptions/auth/sign_in_exceptions.dart';
import 'package:weather_app/core/domain/exceptions/auth/sign_up_exceptions.dart';
import 'package:weather_app/core/domain/repositories/auth_repository.dart';
import 'package:weather_app/core/infra/either/either.dart';
import 'package:weather_app/core/infra/exception/app_exception.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dataSource);

  final AuthDataSource _dataSource;

  @override
  Future<Either<SignUpException, void>> signUpWithEmailAndPassword({
    required final String email,
    required final String password,
  }) async {
    try {
      await _dataSource.signUpWithEmailAndPassword(email, password);
      return const Right(null);
    } on AuthDataSourceException catch (e) {
      return Left(SignUpException.fromCode(e.message ?? 'unknown-error'));
    }
  }

  @override
  Future<Either<SignInException, void>> signInWithEmailAndPassword({
    required final String email,
    required final String password,
  }) async {
    try {
      await _dataSource.signInWithEmailAndPassword(email, password);
      return const Right(null);
    } on AuthDataSourceException catch (e) {
      return Left(SignInException.fromCode(e.message ?? 'unknown-error'));
    }
  }

  @override
  Future<Either<AppException, void>> signOut() async {
    try {
      await _dataSource.signOut();
      return const Right(null);
    } on AuthDataSourceException catch (e) {
      return Left(AppException(e.message));
    }
  }

  @override
  Future<Either<AppException, AuthStatus>> fetchAuthState() async {
    try {
      final status = await _dataSource.fetchAuthState();
      return Right(status);
    } on AuthDataSourceException catch (e) {
      return Left(AppException(e.message));
    }
  }
}
