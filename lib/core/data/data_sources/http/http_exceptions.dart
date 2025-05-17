import 'package:weather_app/core/infra/exception/app_exception.dart';

/// Base exception for all HTTP data source errors.
///
/// All exceptions thrown by the HTTP data source should extend this class.
class HttpDataSourceException extends AppException {
  const HttpDataSourceException(super.message);
}

/// Represents HTTP-specific exceptions that can occur during network requests.
/// Each exception corresponds to a specific HTTP status code and optionally
/// carries an Exception message.
sealed class HttpException extends HttpDataSourceException {
  const HttpException(super.message, this.code);

  /// Creates an [HttpException] instance based on an HTTP status code.
  ///
  /// Parameters:
  ///   - [code]: The HTTP status code that triggered the exception
  ///   - [message]: Optional exception message
  ///
  /// Returns an appropriate exception type based on the status code.
  /// If no specific exception type is found for the given code, returns a
  /// [ServerException].
  factory HttpException.fromStatusCode(
    final int code, [
    final String message = '',
  ]) {
    final exceptionFactory = _factories[code];

    if (exceptionFactory == null) {
      return ServerException(message: message);
    }

    return exceptionFactory(message: message);
  }

  /// The HTTP status code associated with this exception
  final int code;

  @override
  List<Object?> get props => [message, code];

  static final Map<int, HttpException Function({String message})> _factories = {
    400: BadRequestException.new,
    401: UnauthorizedException.new,
    402: PaymentRequiredException.new,
    403: ForbiddenException.new,
    404: NotFoundException.new,
    405: MethodNotAllowedException.new,
    406: NotAcceptableException.new,
    407: ProxyAuthenticationRequiredException.new,
    408: RequestTimeoutException.new,
    409: ConflictException.new,
    410: GoneException.new,
    411: LengthRequiredException.new,
    412: PreconditionFailedException.new,
    413: ContentTooLargeException.new,
    414: UriTooLongException.new,
    415: UnsupportedMediaTypeException.new,
    416: RangeNotSatisfiableException.new,
    417: ExpectationFailedException.new,
    421: MisdirectedRequestException.new,
    422: UnprocessableContentException.new,
    423: LockedException.new,
    424: FailedDependencyException.new,
    425: TooEarlyException.new,
    426: UpgradeRequiredException.new,
    428: PreconditionRequiredException.new,
    429: TooManyRequestsException.new,
    431: RequestHeaderFieldsTooLargeException.new,
    451: UnavailableForLegalReasonsException.new,
    500: ServerException.new,
    501: NotImplementedException.new,
    502: BadGatewayException.new,
    503: ServiceUnavailableException.new,
    504: GatewayTimeoutException.new,
    505: HttpVersionNotSupportedException.new,
    506: VariantAlsoNegotiatesException.new,
    507: InsufficientStorageException.new,
    508: LoopDetectedException.new,
    510: NotExtendedException.new,
    511: NetworkAuthenticationRequiredException.new,
  };
}

final class BadRequestException extends HttpException {
  const BadRequestException({final String message = ''}) : super(message, 400);
}

final class UnauthorizedException extends HttpException {
  const UnauthorizedException({final String message = ''})
      : super(message, 401);
}

final class PaymentRequiredException extends HttpException {
  const PaymentRequiredException({final String message = ''})
      : super(message, 402);
}

final class ForbiddenException extends HttpException {
  const ForbiddenException({final String message = ''}) : super(message, 403);
}

final class NotFoundException extends HttpException {
  const NotFoundException({final String message = ''}) : super(message, 404);
}

final class MethodNotAllowedException extends HttpException {
  const MethodNotAllowedException({final String message = ''})
      : super(message, 405);
}

final class NotAcceptableException extends HttpException {
  const NotAcceptableException({final String message = ''})
      : super(message, 406);
}

final class ProxyAuthenticationRequiredException extends HttpException {
  const ProxyAuthenticationRequiredException({final String message = ''})
      : super(message, 407);
}

final class RequestTimeoutException extends HttpException {
  const RequestTimeoutException({final String message = ''})
      : super(message, 408);
}

final class ConflictException extends HttpException {
  const ConflictException({final String message = ''}) : super(message, 409);
}

final class GoneException extends HttpException {
  const GoneException({final String message = ''}) : super(message, 410);
}

final class LengthRequiredException extends HttpException {
  const LengthRequiredException({final String message = ''})
      : super(message, 411);
}

final class PreconditionFailedException extends HttpException {
  const PreconditionFailedException({final String message = ''})
      : super(message, 412);
}

final class ContentTooLargeException extends HttpException {
  const ContentTooLargeException({final String message = ''})
      : super(message, 413);
}

final class UriTooLongException extends HttpException {
  const UriTooLongException({final String message = ''}) : super(message, 414);
}

final class UnsupportedMediaTypeException extends HttpException {
  const UnsupportedMediaTypeException({final String message = ''})
      : super(message, 415);
}

final class RangeNotSatisfiableException extends HttpException {
  const RangeNotSatisfiableException({final String message = ''})
      : super(message, 416);
}

final class ExpectationFailedException extends HttpException {
  const ExpectationFailedException({final String message = ''})
      : super(message, 417);
}

final class MisdirectedRequestException extends HttpException {
  const MisdirectedRequestException({final String message = ''})
      : super(message, 421);
}

final class UnprocessableContentException extends HttpException {
  const UnprocessableContentException({final String message = ''})
      : super(message, 422);
}

final class LockedException extends HttpException {
  const LockedException({final String message = ''}) : super(message, 423);
}

final class FailedDependencyException extends HttpException {
  const FailedDependencyException({final String message = ''})
      : super(message, 424);
}

final class TooEarlyException extends HttpException {
  const TooEarlyException({final String message = ''}) : super(message, 425);
}

final class UpgradeRequiredException extends HttpException {
  const UpgradeRequiredException({final String message = ''})
      : super(message, 426);
}

final class PreconditionRequiredException extends HttpException {
  const PreconditionRequiredException({final String message = ''})
      : super(message, 428);
}

final class TooManyRequestsException extends HttpException {
  const TooManyRequestsException({final String message = ''})
      : super(message, 429);
}

final class RequestHeaderFieldsTooLargeException extends HttpException {
  const RequestHeaderFieldsTooLargeException({final String message = ''})
      : super(message, 431);
}

final class UnavailableForLegalReasonsException extends HttpException {
  const UnavailableForLegalReasonsException({final String message = ''})
      : super(message, 451);
}

final class ServerException extends HttpException {
  const ServerException({final String message = ''}) : super(message, 500);
}

final class NotImplementedException extends HttpException {
  const NotImplementedException({final String message = ''})
      : super(message, 501);
}

final class BadGatewayException extends HttpException {
  const BadGatewayException({final String message = ''}) : super(message, 502);
}

final class ServiceUnavailableException extends HttpException {
  const ServiceUnavailableException({final String message = ''})
      : super(message, 503);
}

final class GatewayTimeoutException extends HttpException {
  const GatewayTimeoutException({final String message = ''})
      : super(message, 504);
}

final class HttpVersionNotSupportedException extends HttpException {
  const HttpVersionNotSupportedException({final String message = ''})
      : super(message, 505);
}

final class VariantAlsoNegotiatesException extends HttpException {
  const VariantAlsoNegotiatesException({final String message = ''})
      : super(message, 506);
}

final class InsufficientStorageException extends HttpException {
  const InsufficientStorageException({final String message = ''})
      : super(message, 507);
}

final class LoopDetectedException extends HttpException {
  const LoopDetectedException({final String message = ''})
      : super(message, 508);
}

final class NotExtendedException extends HttpException {
  const NotExtendedException({final String message = ''}) : super(message, 510);
}

final class NetworkAuthenticationRequiredException extends HttpException {
  const NetworkAuthenticationRequiredException({final String message = ''})
      : super(message, 511);
}
