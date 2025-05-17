import 'package:weather_app/core/infra/exception/app_exception.dart';

/// Base exception class for geolocation position fetching errors.
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
