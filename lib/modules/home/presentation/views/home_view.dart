import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../../../commons/config/dependency_injection.dart";
import "../../../commons/utils/resources/app_colors.dart";
import "../../../profile/presentation/blocs/get_profile_bloc.dart";
import "../components/home_tab_bar.dart";

class HomeView extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const HomeView({required this.navigationShell, super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    getIt<GetProfileBloc>().call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            HomeTabBar(navigationShell: widget.navigationShell),
            Expanded(child: widget.navigationShell),
          ],
        ),
      ),
    );
  }
}
