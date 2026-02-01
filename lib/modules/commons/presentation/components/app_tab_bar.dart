import "package:flutter/material.dart";

import "../../utils/resources/app_colors.dart";

class AppTabBar extends StatelessWidget {
  const AppTabBar({
    required this.tabs,
    required this.controller,
    super.key,
    this.backgroundColor,
    this.selectedTabColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.height,
    this.borderRadius,
  });

  final List<String> tabs;
  final TabController controller;
  final Color? backgroundColor;
  final Color? selectedTabColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final double? height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = borderRadius ?? 40.0;
    final effectiveHeight = height ?? 56.0;

    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: effectiveHeight,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
      ),
      padding: const EdgeInsets.all(8),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          color: selectedTabColor ?? AppColors.primary,
          borderRadius: BorderRadius.circular(effectiveBorderRadius - 4),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: selectedTextColor ?? AppColors.white,
        unselectedLabelColor: unselectedTextColor ?? AppColors.textSecondary,
        labelStyle: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
        unselectedLabelStyle: textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        tabs: tabs.map((label) => Tab(text: label)).toList(),
      ),
    );
  }
}
