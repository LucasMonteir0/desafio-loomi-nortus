import "package:flutter/material.dart";

import "../../../commons/utils/resources/app_colors.dart";

class NewsCategoryChip extends StatelessWidget {
  final String category;
  const NewsCategoryChip({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.7)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        category,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
