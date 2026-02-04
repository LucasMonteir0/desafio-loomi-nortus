import "dart:typed_data";

import "package:flutter/material.dart";

import "../../utils/resources/app_colors.dart";

class AppNetworkImage extends StatelessWidget {
  final String src;
  final Uint8List? bytes;
  final double? height;
  final double? width;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const AppNetworkImage({
    required this.src,
    this.bytes,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late Widget image;

    if (bytes != null && bytes!.isNotEmpty) {
      image = Image.memory(
        bytes!,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ?? _DefaultErrorWidget(height: height),
      );
    } else {
      image = Image.network(
        src,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ?? _DefaultErrorWidget(height: height),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return placeholder ?? _DefaultPlaceholder(height: height);
        },
      );
    }

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return image;
  }
}

class _DefaultPlaceholder extends StatelessWidget {
  final double? height;

  const _DefaultPlaceholder({this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: AppColors.backgroundLight,
      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}

class _DefaultErrorWidget extends StatelessWidget {
  final double? height;

  const _DefaultErrorWidget({this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: AppColors.backgroundLight,
      child: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          size: 48,
          color: AppColors.textDisabled,
        ),
      ),
    );
  }
}
