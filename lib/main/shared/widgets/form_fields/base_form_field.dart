import 'package:flutter/material.dart';

class BaseFormField extends StatelessWidget {
  const BaseFormField({
    required this.controller,
    required this.autofillHints,
    required this.label,
    required this.keyboardType,
    required this.textInputAction,
    required this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.onSubmitted,
    super.key,
  });

  final TextEditingController controller;
  final List<String> autofillHints;
  final String label;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?) validator;

  @override
  Widget build(final BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: suffixIcon,
      ),
      textInputAction: textInputAction,
      validator: validator,
      onFieldSubmitted: onSubmitted,
      obscureText: obscureText,
      keyboardType: keyboardType,
      autofillHints: autofillHints,
    );
  }
}
