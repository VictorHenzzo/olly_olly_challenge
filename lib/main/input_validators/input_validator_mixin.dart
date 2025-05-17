mixin InputValidatorMixin {
  String? validateEmail(final String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'Please enter your email address.';
    }

    final emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);

    if (!emailValid) {
      return 'Enter a valid email address.';
    }

    return null;
  }

  String? validatePassword(final String? password) {
    if (password == null || password.trim().isEmpty) {
      return 'Please enter your password.';
    }

    return null;
  }
}
