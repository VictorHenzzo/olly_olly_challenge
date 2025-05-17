part of '../auth_screen.dart';

class _CredentialForm extends StatelessWidget {
  const _CredentialForm({
    required this.changeMode,
    required this.emailController,
    required this.passwordController,
    required this.submit,
    required this.mode,
  });

  final void Function(_CurrentMode current) changeMode;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback submit;
  final _CurrentMode mode;

  @override
  Widget build(final BuildContext context) {
    final uiContext = UiContext.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          _getTitle(),
          style: uiContext.textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        EmailFormField(controller: emailController),
        const SizedBox(height: 16),
        PasswordFormField(
          controller: passwordController,
          onSubmitted: submit,
        ),
        const SizedBox(height: 8),
        const _CredentialFormErrorFeedback(),
        const SizedBox(height: 8),
        Align(
          child: TextButton(
            onPressed: () => changeMode(mode),
            child: Text(_getChangeModeText()),
          ),
        ),
        const SizedBox(height: 16),
        _buildButton(),
      ],
    );
  }

  Widget _buildButton() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (final context, final state) {
        final isLoading = state is AuthLoading;
        final onPressed = isLoading ? null : submit;

        return ElevatedButton(
          onPressed: onPressed,
          child: Text(_getButtonText()),
        );
      },
    );
  }

  String _getTitle() {
    return switch (mode) {
      _CurrentMode.signIn => 'Sign in',
      _CurrentMode.signUp => 'Sign up',
    };
  }

  String _getButtonText() {
    return switch (mode) {
      _CurrentMode.signIn => 'SIGN IN',
      _CurrentMode.signUp => 'SIGN UP',
    };
  }

  String _getChangeModeText() {
    return switch (mode) {
      _CurrentMode.signIn => "Doesn't have an account? Signup",
      _CurrentMode.signUp => 'Already has an account? Signin',
    };
  }
}
