import "package:flutter/material.dart";

import "../resources/app_colors.dart";

enum ToastStatus { success, error, warning, info }

class ToastHelper {
  static void _show(
    BuildContext context, {
    required String message,
    ToastStatus status = ToastStatus.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final (
      Color backgroundColor,
      Color foregroundColor,
      IconData icon,
    ) = switch (status) {
      ToastStatus.success => (
        AppColors.successBackground,
        AppColors.success,
        Icons.check_circle_outline,
      ),
      ToastStatus.error => (
        AppColors.errorBackground,
        AppColors.error,
        Icons.error_outline,
      ),
      ToastStatus.warning => (
        AppColors.warningBackground,
        AppColors.warning,
        Icons.warning_amber_outlined,
      ),
      ToastStatus.info => (
        AppColors.infoBackground,
        AppColors.info,
        Icons.info_outline,
      ),
    };

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: foregroundColor, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(message, style: TextStyle(color: foregroundColor)),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: duration,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  static void showSuccess(BuildContext context, String message) {
    _show(context, message: message, status: ToastStatus.success);
  }

  static void showError(BuildContext context, String message) {
    _show(context, message: message, status: ToastStatus.error);
  }

  static void showWarning(BuildContext context, String message) {
    _show(context, message: message, status: ToastStatus.warning);
  }

  static void showInfo(BuildContext context, String message) {
    _show(context, message: message);
  }
}
