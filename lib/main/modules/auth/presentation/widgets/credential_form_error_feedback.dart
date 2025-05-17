part of '../auth_screen.dart';

class _CredentialFormErrorFeedback extends StatelessWidget {
  const _CredentialFormErrorFeedback();

  @override
  Widget build(final BuildContext context) {
    final uiContext = UiContext.of(context);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (final context, final state) {
        String? feedback;

        if (state is AuthSignInError) {
          feedback = _getErrorFromAuthSignInError(state);
        }

        if (state is AuthSignUpError) {
          feedback = _getErrorFromAuthSignUpError(state);
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (final child, final animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: feedback == null
              ? const SizedBox.shrink(key: ValueKey('empty'))
              : Text(
                  key: ValueKey(feedback),
                  feedback,
                  style: uiContext.textTheme.bodyMedium?.copyWith(
                    color: uiContext.colorScheme.error,
                  ),
                ),
        );
      },
    );
  }

  String _getErrorFromAuthSignInError(final AuthSignInError state) {
    return switch (state.exception) {
      InvalidCredentialSignInException() =>
        'The credentials provided are invalid. Please double-check and try again.',
      InvalidEmailSignInException() =>
        'The email address is not valid. Please enter a valid email.',
      UserNotFoundSignInException() =>
        'No account found with this email address.',
      WrongPasswordSignInException() => 'Incorrect password. Please try again.',
      UnknownSignInException() =>
        'An unexpected error occurred while signing in. Please try again later.',
    };
  }

  String _getErrorFromAuthSignUpError(final AuthSignUpError state) {
    return switch (state.exception) {
      EmailAlreadyInUseSignUpException() =>
        'This email is already associated with an account. Try logging in instead.',
      InvalidEmailSignUpException() =>
        'The email address is not valid. Please enter a valid email.',
      WeakPasswordSignUpException() =>
        'The password is too weak. Please use at least 6 characters.',
      UnknownSignUpException() =>
        'An unexpected error occurred while creating the account. Please try again later.',
    };
  }
}
