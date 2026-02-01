import "package:flutter/material.dart";

import "../../utils/resources/app_colors.dart";

class AppProgressIndicator extends StatelessWidget {
  final double? size;
  final double strokeWidth;
  final Color? color;

  const AppProgressIndicator({
    this.size,
    this.strokeWidth = 4,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final indicator = CircularProgressIndicator(
      strokeWidth: strokeWidth,
      color: color ?? AppColors.primary,
    );

    if (size != null) {
      return SizedBox(width: size, height: size, child: indicator);
    }

    return indicator;
  }
}
