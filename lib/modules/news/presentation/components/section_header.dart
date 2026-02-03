import "package:flutter/material.dart";

import "../../../commons/utils/resources/app_colors.dart";

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: const BoxDecoration(
        border: Border.symmetric(vertical: BorderSide(color: AppColors.border)),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: const BoxDecoration(
          color: AppColors.backgroundLight,
          border: Border.symmetric(
            horizontal: BorderSide(color: AppColors.border),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.secondaryDark,
          ),
        ),
      ),
    );
  }
}
