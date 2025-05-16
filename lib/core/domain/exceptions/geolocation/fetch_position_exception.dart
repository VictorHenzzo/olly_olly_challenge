import 'package:olly_olly_challenge/core/infra/exception/app_exception.dart';

sealed class FetchPositionException extends AppException {
  const FetchPositionException([super.message]);
}

final class DeniedFetchPositionException extends FetchPositionException {
  const DeniedFetchPositionException([super.message]);
}

final class DeniedForeverFetchPositionException extends FetchPositionException {
  const DeniedForeverFetchPositionException([super.message]);
}

final class UnknownFetchPositionException extends FetchPositionException {
  const UnknownFetchPositionException([super.message]);
}
