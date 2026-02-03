import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "../../../commons/utils/resources/app_colors.dart";
import "../../../commons/utils/resources/app_images.dart";

class HomeTabBar extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const HomeTabBar({required this.navigationShell, super.key});

  @override
  State<HomeTabBar> createState() => _HomeTabBarState();
}

class _HomeTabBarState extends State<HomeTabBar>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.navigationShell.currentIndex,
    );
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      widget.navigationShell.goBranch(
        _tabController.index,
        initialLocation:
            _tabController.index == widget.navigationShell.currentIndex,
      );
    }
  }

  @override
  void didUpdateWidget(covariant HomeTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.navigationShell.currentIndex != _tabController.index) {
      _tabController.animateTo(widget.navigationShell.currentIndex);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondary,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Image.asset(
                AppImages.nortusImage,
                width: 36,
                height: 36,
                color: Colors.white,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  indicatorWeight: 1,
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 12),
                  labelColor: AppColors.white,
                  unselectedLabelColor: AppColors.white.withValues(alpha: 0.7),
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  dividerColor: Colors.transparent,
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,

                  labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                  tabs: const [
                    Tab(text: "Notícias"),
                    Tab(text: "Meu perfil"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
