import "package:flutter/material.dart";

import "../../../commons/utils/resources/app_colors.dart";

class ProfileSectionText extends StatelessWidget {
  const ProfileSectionText({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
    );
  }
}
