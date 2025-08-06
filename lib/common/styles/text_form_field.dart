import 'package:flutter/material.dart';
import 'package:gail_india/utils/constants/colors.dart';
import 'package:gail_india/utils/constants/sizes.dart';

class GTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const GTextFormField({
    super.key,
    required this.label,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(Gsizes.inputFieldRadius),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(Gsizes.inputFieldRadius),
          ),
          borderSide: BorderSide(color: GColors.buttonDisabled, width: 2.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(Gsizes.inputFieldRadius),
          ),
          borderSide: BorderSide(color: GColors.buttonPrimary, width: 2.0),
        ),
      ),
    );
  }
}
