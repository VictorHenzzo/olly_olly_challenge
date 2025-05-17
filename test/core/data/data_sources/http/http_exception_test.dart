import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/data/data_sources/http/http_exceptions.dart';

void main() {
  group('HttpException', () {
    test('400 creates BadRequest', () {
      final exception = HttpException.fromStatusCode(400, 'test message');
      expect(exception, isA<BadRequestException>());
      expect(exception.code, 400);
      expect(exception.message, 'test message');
    });

    test('401 creates UnauthorizedException', () {
      final exception = HttpException.fromStatusCode(401, 'test message');
      expect(exception, isA<UnauthorizedException>());
      expect(exception.code, 401);
      expect(exception.message, 'test message');
    });

    test('402 creates PaymentRequiredException', () {
      final exception = HttpException.fromStatusCode(402, 'test message');
      expect(exception, isA<PaymentRequiredException>());
      expect(exception.code, 402);
      expect(exception.message, 'test message');
    });

    test('403 creates ForbiddenException', () {
      final exception = HttpException.fromStatusCode(403, 'test message');
      expect(exception, isA<ForbiddenException>());
      expect(exception.code, 403);
      expect(exception.message, 'test message');
    });

    test('404 creates NotFoundException', () {
      final exception = HttpException.fromStatusCode(404, 'test message');
      expect(exception, isA<NotFoundException>());
      expect(exception.code, 404);
      expect(exception.message, 'test message');
    });

    test('405 creates MethodNotAllowedException', () {
      final exception = HttpException.fromStatusCode(405, 'test message');
      expect(exception, isA<MethodNotAllowedException>());
      expect(exception.code, 405);
      expect(exception.message, 'test message');
    });

    test('406 creates NotAcceptableException', () {
      final exception = HttpException.fromStatusCode(406, 'test message');
      expect(exception, isA<NotAcceptableException>());
      expect(exception.code, 406);
      expect(exception.message, 'test message');
    });

    test('407 creates ProxyAuthenticationRequiredException', () {
      final exception = HttpException.fromStatusCode(407, 'test message');
      expect(exception, isA<ProxyAuthenticationRequiredException>());
      expect(exception.code, 407);
      expect(exception.message, 'test message');
    });

    test('408 creates RequestTimeoutException', () {
      final exception = HttpException.fromStatusCode(408, 'test message');
      expect(exception, isA<RequestTimeoutException>());
      expect(exception.code, 408);
      expect(exception.message, 'test message');
    });

    test('409 creates ConflictException', () {
      final exception = HttpException.fromStatusCode(409, 'test message');
      expect(exception, isA<ConflictException>());
      expect(exception.code, 409);
      expect(exception.message, 'test message');
    });

    test('410 creates GoneException', () {
      final exception = HttpException.fromStatusCode(410, 'test message');
      expect(exception, isA<GoneException>());
      expect(exception.code, 410);
      expect(exception.message, 'test message');
    });

    test('411 creates LengthRequiredException', () {
      final exception = HttpException.fromStatusCode(411, 'test message');
      expect(exception, isA<LengthRequiredException>());
      expect(exception.code, 411);
      expect(exception.message, 'test message');
    });

    test('412 creates PreconditionFailedException', () {
      final exception = HttpException.fromStatusCode(412, 'test message');
      expect(exception, isA<PreconditionFailedException>());
      expect(exception.code, 412);
      expect(exception.message, 'test message');
    });

    test('413 creates ContentTooLargeException', () {
      final exception = HttpException.fromStatusCode(413, 'test message');
      expect(exception, isA<ContentTooLargeException>());
      expect(exception.code, 413);
      expect(exception.message, 'test message');
    });

    test('414 creates UriTooLongException', () {
      final exception = HttpException.fromStatusCode(414, 'test message');
      expect(exception, isA<UriTooLongException>());
      expect(exception.code, 414);
      expect(exception.message, 'test message');
    });

    test('415 creates UnsupportedMediaTypeException', () {
      final exception = HttpException.fromStatusCode(415, 'test message');
      expect(exception, isA<UnsupportedMediaTypeException>());
      expect(exception.code, 415);
      expect(exception.message, 'test message');
    });

    test('416 creates RangeNotSatisfiableException', () {
      final exception = HttpException.fromStatusCode(416, 'test message');
      expect(exception, isA<RangeNotSatisfiableException>());
      expect(exception.code, 416);
      expect(exception.message, 'test message');
    });

    test('417 creates ExpectationFailedException', () {
      final exception = HttpException.fromStatusCode(417, 'test message');
      expect(exception, isA<ExpectationFailedException>());
      expect(exception.code, 417);
      expect(exception.message, 'test message');
    });

    test('421 creates MisdirectedRequestException', () {
      final exception = HttpException.fromStatusCode(421, 'test message');
      expect(exception, isA<MisdirectedRequestException>());
      expect(exception.code, 421);
      expect(exception.message, 'test message');
    });

    test('422 creates UnprocessableContentException', () {
      final exception = HttpException.fromStatusCode(422, 'test message');
      expect(exception, isA<UnprocessableContentException>());
      expect(exception.code, 422);
      expect(exception.message, 'test message');
    });

    test('423 creates LockedException', () {
      final exception = HttpException.fromStatusCode(423, 'test message');
      expect(exception, isA<LockedException>());
      expect(exception.code, 423);
      expect(exception.message, 'test message');
    });

    test('424 creates FailedDependencyException', () {
      final exception = HttpException.fromStatusCode(424, 'test message');
      expect(exception, isA<FailedDependencyException>());
      expect(exception.code, 424);
      expect(exception.message, 'test message');
    });

    test('425 creates TooEarlyException', () {
      final exception = HttpException.fromStatusCode(425, 'test message');
      expect(exception, isA<TooEarlyException>());
      expect(exception.code, 425);
      expect(exception.message, 'test message');
    });

    test('426 creates UpgradeRequiredException', () {
      final exception = HttpException.fromStatusCode(426, 'test message');
      expect(exception, isA<UpgradeRequiredException>());
      expect(exception.code, 426);
      expect(exception.message, 'test message');
    });

    test('428 creates PreconditionRequiredException', () {
      final exception = HttpException.fromStatusCode(428, 'test message');
      expect(exception, isA<PreconditionRequiredException>());
      expect(exception.code, 428);
      expect(exception.message, 'test message');
    });

    test('429 creates TooManyRequestsException', () {
      final exception = HttpException.fromStatusCode(429, 'test message');
      expect(exception, isA<TooManyRequestsException>());
      expect(exception.code, 429);
      expect(exception.message, 'test message');
    });

    test('431 creates RequestHeaderFieldsTooLargeException', () {
      final exception = HttpException.fromStatusCode(431, 'test message');
      expect(exception, isA<RequestHeaderFieldsTooLargeException>());
      expect(exception.code, 431);
      expect(exception.message, 'test message');
    });

    test('451 creates UnavailableForLegalReasonsException', () {
      final exception = HttpException.fromStatusCode(451, 'test message');
      expect(exception, isA<UnavailableForLegalReasonsException>());
      expect(exception.code, 451);
      expect(exception.message, 'test message');
    });

    test('500 creates ServerException', () {
      final exception = HttpException.fromStatusCode(500, 'test message');
      expect(exception, isA<ServerException>());
      expect(exception.code, 500);
      expect(exception.message, 'test message');
    });

    test('501 creates NotImplementedException', () {
      final exception = HttpException.fromStatusCode(501, 'test message');
      expect(exception, isA<NotImplementedException>());
      expect(exception.code, 501);
      expect(exception.message, 'test message');
    });

    test('502 creates BadGatewayException', () {
      final exception = HttpException.fromStatusCode(502, 'test message');
      expect(exception, isA<BadGatewayException>());
      expect(exception.code, 502);
      expect(exception.message, 'test message');
    });

    test('503 creates ServiceUnavailableException', () {
      final exception = HttpException.fromStatusCode(503, 'test message');
      expect(exception, isA<ServiceUnavailableException>());
      expect(exception.code, 503);
      expect(exception.message, 'test message');
    });

    test('504 creates GatewayTimeoutException', () {
      final exception = HttpException.fromStatusCode(504, 'test message');
      expect(exception, isA<GatewayTimeoutException>());
      expect(exception.code, 504);
      expect(exception.message, 'test message');
    });

    test('505 creates HttpVersionNotSupportedException', () {
      final exception = HttpException.fromStatusCode(505, 'test message');
      expect(exception, isA<HttpVersionNotSupportedException>());
      expect(exception.code, 505);
      expect(exception.message, 'test message');
    });

    test('506 creates VariantAlsoNegotiatesException', () {
      final exception = HttpException.fromStatusCode(506, 'test message');
      expect(exception, isA<VariantAlsoNegotiatesException>());
      expect(exception.code, 506);
      expect(exception.message, 'test message');
    });

    test('507 creates InsufficientStorageException', () {
      final exception = HttpException.fromStatusCode(507, 'test message');
      expect(exception, isA<InsufficientStorageException>());
      expect(exception.code, 507);
      expect(exception.message, 'test message');
    });

    test('508 creates LoopDetectedException', () {
      final exception = HttpException.fromStatusCode(508, 'test message');
      expect(exception, isA<LoopDetectedException>());
      expect(exception.code, 508);
      expect(exception.message, 'test message');
    });

    test('510 creates NotExtendedException', () {
      final exception = HttpException.fromStatusCode(510, 'test message');
      expect(exception, isA<NotExtendedException>());
      expect(exception.code, 510);
      expect(exception.message, 'test message');
    });

    test('511 creates NetworkAuthenticationRequiredException', () {
      final exception = HttpException.fromStatusCode(511, 'test message');
      expect(exception, isA<NetworkAuthenticationRequiredException>());
      expect(exception.code, 511);
      expect(exception.message, 'test message');
    });

    test('unknown status code creates ServerException', () {
      final exception = HttpException.fromStatusCode(599, 'test message');
      expect(exception, isA<ServerException>());
      expect(exception.code, 500);
      expect(exception.message, 'test message');
    });
  });
}
