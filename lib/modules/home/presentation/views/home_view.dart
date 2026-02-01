import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "../../../commons/presentation/components/custom_app_bar.dart";
import "../../../commons/utils/resources/app_colors.dart";
import "../components/home_tab_bar.dart";

class HomeView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomeView({required this.navigationShell, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            HomeTabBar(navigationShell: navigationShell),
            CustomAppBar(onMenuPressed: () {}, onSearchSubmitted: (value) {}),
            Expanded(child: navigationShell),
          ],
        ),
      ),
    );
  }
}
