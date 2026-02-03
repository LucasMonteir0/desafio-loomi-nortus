import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../utils/resources/app_colors.dart";
import "../../utils/resources/app_images.dart";

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      color: AppColors.black,
      child: SafeArea(
        top: false,
        right: false,
        left: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AppImages.nortus,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Copyright 2025 Nortus - Todos os Direitos Reservados",
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textPlaceholder),
            ),
          ],
        ),
      ),
    );
  }
}
