import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/main/input_validators/input_validator_mixin.dart';

class _TestValidator with InputValidatorMixin {}

void main() {
  final validator = _TestValidator();

  group('EmailInputValidator', () {
    test('returns error for null email', () {
      expect(
        validator.validateEmail(null),
        'Please enter your email address.',
      );
    });

    test('returns error for empty email', () {
      expect(
        validator.validateEmail(''),
        'Please enter your email address.',
      );
    });

    test('returns error for missing @', () {
      expect(
        validator.validateEmail('testemail.com'),
        'Enter a valid email address.',
      );
    });

    test('returns error for missing domain', () {
      expect(
        validator.validateEmail('test@'),
        'Enter a valid email address.',
      );
    });

    test('returns error for missing username', () {
      expect(
        validator.validateEmail('@domain.com'),
        'Enter a valid email address.',
      );
    });

    test('returns null for valid email', () {
      expect(
        validator.validateEmail('test@example.com'),
        null,
      );
    });

    test('returns null for valid email with dots and plus', () {
      expect(
        validator.validateEmail('first.last+tag@sub.domain.com'),
        null,
      );
    });
  });

  group('PasswordInputValidator', () {
    test('returns error for null password', () {
      expect(
        validator.validatePassword(null),
        'Please enter your password.',
      );
    });

    test('returns error for empty password', () {
      expect(
        validator.validatePassword(''),
        'Please enter your password.',
      );
    });

    test('returns error for whitespace password', () {
      expect(
        validator.validatePassword('   '),
        'Please enter your password.',
      );
    });

    test('returns null for non-empty password', () {
      expect(validator.validatePassword('password123'), null);
    });
  });
}
