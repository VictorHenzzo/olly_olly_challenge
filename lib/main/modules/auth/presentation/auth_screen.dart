import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/domain/exceptions/auth/sign_in_exceptions.dart';
import 'package:weather_app/core/domain/exceptions/auth/sign_up_exceptions.dart';
import 'package:weather_app/main/modules/auth/bloc/auth_bloc.dart';
import 'package:weather_app/main/shared/ui_context.dart';
import 'package:weather_app/main/shared/widgets/adaptative_widget.dart';
import 'package:weather_app/main/shared/widgets/form_background_card.dart';
import 'package:weather_app/main/shared/widgets/form_fields/email_form_field.dart';
import 'package:weather_app/main/shared/widgets/form_fields/password_form_field.dart';

part 'widgets/auth_mode_switcher.dart';
part 'widgets/credential_form.dart';
part 'widgets/credential_form_error_feedback.dart';

enum _CurrentMode {
  signIn,
  signUp;
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({required this.bloc, super.key});

  final AuthBloc bloc;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final ValueNotifier<_CurrentMode> modeController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    modeController = ValueNotifier(_CurrentMode.signIn);
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    modeController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: AdaptativeWidgetBuilder(
        mobile: (final context, final constraints) => _buildForm(
          math.max(constraints.maxWidth * 0.8, 350),
        ),
        desktop: (final context, final constraints) => _buildForm(
          math.max(constraints.maxWidth * 0.3, 500),
          decoration: (final child) => BackgroundDecorationCard(child: child),
        ),
      ),
    );
  }

  Widget _buildForm(
    final double width, {
    final Widget Function(Widget)? decoration,
  }) {
    Widget content = Form(
      key: formKey,
      child: _AuthModeSwitcher(
        modeController: modeController,
        onSignIn: () => _CredentialForm(
          emailController: emailController,
          passwordController: passwordController,
          submit: _signIn,
          changeMode: _toggleMode,
          mode: modeController.value,
        ),
        onSignUp: () => _CredentialForm(
          emailController: emailController,
          passwordController: passwordController,
          submit: _signUp,
          changeMode: _toggleMode,
          mode: modeController.value,
        ),
      ),
    );

    if (decoration != null) {
      content = decoration(content);
    }

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: width),
        child: content,
      ),
    );
  }

  void _toggleMode(final _CurrentMode current) {
    final newMode = current == _CurrentMode.signIn
        ? _CurrentMode.signUp
        : _CurrentMode.signIn;
    modeController.value = newMode;
    passwordController.clear();
  }

  void _signIn() {
    if (!_validateForm()) {
      return;
    }

    widget.bloc.add(
      SignInEvent(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
  }

  void _signUp() {
    if (!_validateForm()) {
      return;
    }

    widget.bloc.add(
      SignUpEvent(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
  }

  bool _validateForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
