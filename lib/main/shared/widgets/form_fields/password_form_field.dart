import 'package:flutter/material.dart';
import 'package:weather_app/main/input_validators/input_validator_mixin.dart';
import 'package:weather_app/main/shared/widgets/form_fields/base_form_field.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    required this.controller,
    required this.onSubmitted,
    super.key,
  });

  final TextEditingController controller;
  final VoidCallback onSubmitted;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField>
    with InputValidatorMixin {
  late bool isVisible;

  @override
  void initState() {
    super.initState();
    isVisible = false;
  }

  @override
  Widget build(final BuildContext context) {
    return BaseFormField(
      controller: widget.controller,
      autofillHints: const [AutofillHints.password],
      label: 'Password',
      textInputAction: TextInputAction.done,
      onSubmitted: (final value) => widget.onSubmitted(),
      keyboardType:
          isVisible ? TextInputType.visiblePassword : TextInputType.text,
      obscureText: !isVisible,
      suffixIcon: IconButton(
        icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
        onPressed: _toggleVisibility,
      ),
      validator: validatePassword,
    );
  }

  void _toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }
}
