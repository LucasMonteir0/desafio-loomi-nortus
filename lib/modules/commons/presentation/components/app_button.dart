import "package:flutter/material.dart";

import "../../utils/resources/app_colors.dart";

abstract class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final double? width;
  final double? height;
  final double? radius;
  final Color? color;
  final TextStyle? textStyle;

  const AppButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.isLoading = false,
    this.isEnabled = true,
    this.width,
    this.height,
    this.radius,
    this.color,
    this.textStyle,
  });

  const factory AppButton.primary({
    required String text,
    required VoidCallback? onPressed,
    Key? key,
    bool isLoading,
    bool isEnabled,
    double? width,
    double? height,
  }) = _PrimaryButton;

  const factory AppButton.text({
    required String text,
    required VoidCallback? onPressed,
    Key? key,
    bool isLoading,
    bool isEnabled,
    Color? color,
    TextStyle? textStyle,
  }) = _TextButton;
}

class _PrimaryButton extends AppButton {
  const _PrimaryButton({
    required super.text,
    required super.onPressed,
    super.key,
    super.isLoading,
    super.isEnabled,
    super.width,
    super.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 56,
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
          foregroundColor: AppColors.white,
          disabledForegroundColor: AppColors.white.withValues(alpha: 0.7),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 16),
          ),
          padding: const EdgeInsets.all(16),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                ),
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}

class _TextButton extends AppButton {
  const _TextButton({
    required super.text,
    required super.onPressed,
    super.key,
    super.isLoading,
    super.isEnabled,
    super.color,
    super.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.secondary;

    return TextButton(
      onPressed: isEnabled && !isLoading ? onPressed : null,
      style: TextButton.styleFrom(
        foregroundColor: effectiveColor,
        disabledForegroundColor: effectiveColor.withValues(alpha: 0.5),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: isLoading
          ? SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
              ),
            )
          : Text(
              text,
              style:
                  textStyle ??
                  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: effectiveColor,
                  ),
            ),
    );
  }
}
