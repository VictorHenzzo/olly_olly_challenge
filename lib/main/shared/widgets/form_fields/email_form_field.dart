import 'package:flutter/material.dart';
import 'package:weather_app/main/input_validators/input_validator_mixin.dart';
import 'package:weather_app/main/shared/widgets/form_fields/base_form_field.dart';

class EmailFormField extends StatelessWidget with InputValidatorMixin {
  const EmailFormField({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  @override
  Widget build(final BuildContext context) {
    return BaseFormField(
      controller: controller,
      validator: validateEmail,
      label: 'Email',
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      textInputAction: TextInputAction.next,
    );
  }
}
