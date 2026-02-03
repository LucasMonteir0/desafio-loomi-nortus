import "package:flutter/material.dart";

import "../../utils/resources/app_colors.dart";
import "app_footer.dart";

class AppErrorWidget extends StatelessWidget {
  final String? message;
  final VoidCallback onRetry;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final TextStyle? messageStyle;
  final String? retryButtonText;

  const AppErrorWidget({
    required this.onRetry,
    super.key,
    this.message,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.messageStyle,
    this.retryButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon ?? Icons.error_outline,
                  size: iconSize ?? 64,
                  color: iconColor ?? AppColors.error,
                ),
                const SizedBox(height: 16),
                Text(
                  message ?? "Ocorreu um erro. Por favor, tente novamente.",
                  style:
                      messageStyle ??
                      const TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh),
                    label: Text(retryButtonText ?? "Tentar novamente"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const AppFooter(),
      ],
    );
  }
}
