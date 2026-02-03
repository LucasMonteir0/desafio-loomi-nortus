import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "../../../commons/utils/resources/app_colors.dart";

class ProfileTextField extends StatelessWidget {
  const ProfileTextField({
    required this.controller,
    required this.hint,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    super.key,
  });

  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.secondary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
    );
  }
}
