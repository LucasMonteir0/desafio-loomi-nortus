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
  final TextDecoration? textDecoration;

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
    this.textDecoration,
  });

  const factory AppButton.primary({
    required String text,
    required VoidCallback? onPressed,
    Key? key,
    bool isLoading,
    bool isEnabled,
    double? width,
    double? height,
    double? radius,
  }) = _PrimaryButton;

  const factory AppButton.text({
    required String text,
    required VoidCallback? onPressed,
    Key? key,
    bool isLoading,
    bool isEnabled,
    Color? color,
    TextStyle? textStyle,
    TextDecoration? textDecoration,
  }) = _TextButton;

  const factory AppButton.outlined({
    required String text,
    required VoidCallback? onPressed,
    Key? key,
    bool isLoading,
    bool isEnabled,
    double? width,
    double? height,
    double? radius,
    Color? borderColor,
    Color? contentColor,
    IconData? icon,
  }) = _OutlinedButton;
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
    super.radius,
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
    super.textDecoration,
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
                    decoration: textDecoration ?? TextDecoration.underline,
                    decorationColor: effectiveColor,
                  ),
            ),
    );
  }
}

class _OutlinedButton extends AppButton {
  final Color? borderColor;
  final Color? contentColor;
  final IconData? icon;

  const _OutlinedButton({
    required super.text,
    required super.onPressed,
    super.key,
    super.isLoading,
    super.isEnabled,
    super.width,
    super.height,
    super.radius,
    this.borderColor,
    this.contentColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = borderColor ?? AppColors.textSecondary;
    final effectiveContentColor = contentColor ?? AppColors.textSecondary;

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 40,
      child: OutlinedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: OutlinedButton.styleFrom(
          foregroundColor: effectiveContentColor,
          disabledForegroundColor: effectiveContentColor.withValues(alpha: 0.5),
          side: BorderSide(
            color: isEnabled
                ? effectiveBorderColor
                : effectiveBorderColor.withValues(alpha: 0.5),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 100),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    effectiveContentColor,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null)
                    Icon(icon, color: effectiveContentColor, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: effectiveContentColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
