import 'dart:async';

import 'package:olly_olly_challenge/core/data/data_sources/auth_data_source/auth_data_source.dart';
import 'package:olly_olly_challenge/core/data/data_sources/auth_data_source/auth_data_source_exception.dart';
import 'package:olly_olly_challenge/core/domain/enums/auth/auth_status.dart';
import 'package:olly_olly_challenge/core/domain/exceptions/auth/sign_in_exceptions.dart';
import 'package:olly_olly_challenge/core/domain/exceptions/auth/sign_up_exceptions.dart';
import 'package:olly_olly_challenge/core/domain/repositories/auth_repository.dart';
import 'package:olly_olly_challenge/core/infra/either/either.dart';
import 'package:olly_olly_challenge/core/infra/exception/app_exception.dart';

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
  Stream<AuthStatus> fetchAuthState() {
    return _dataSource.fetchAuthState().transform(
      StreamTransformer.fromHandlers(
        handleError: (final _, final __, final sink) {
          sink.add(AuthStatus.unauthenticated);
        },
      ),
    );
  }
}
