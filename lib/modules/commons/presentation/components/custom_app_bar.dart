import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../utils/resources/app_colors.dart";
import "../../utils/resources/app_images.dart";
import "app_button.dart";

class CustomAppBar extends StatefulWidget {
  final VoidCallback? onMenuPressed;
  final ValueChanged<String>? onSearchSubmitted;
  final VoidCallback? onCloseSearch;
  final String searchHint;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    this.onMenuPressed,
    this.onSearchSubmitted,
    this.searchHint = "Pesquisar...",
    this.onCloseSearch,
    this.onBackPressed,
    super.key,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _startSearch() {
    setState(() => _isSearching = true);
    _focusNode.requestFocus();
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
      widget.onCloseSearch?.call();
    });
  }

  void _onSearch() {
    widget.onSearchSubmitted?.call(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onBackPressed != null) {
      return _BackButtonAppBar(onBackPressed: widget.onBackPressed);
    }

    final bool showMenu = widget.onMenuPressed != null;
    final bool showSearch = widget.onSearchSubmitted != null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(color: AppColors.backgroundLight),
      child: _isSearching
          ? _SearchBar(
              showMenu: showMenu,
              onMenuPressed: widget.onMenuPressed,
              controller: _searchController,
              focusNode: _focusNode,
              onSearchSubmitted: widget.onSearchSubmitted,
              searchHint: widget.searchHint,
              onSearch: _onSearch,
              onClose: _stopSearch,
            )
          : _NormalBar(
              showMenu: showMenu,
              showSearch: showSearch,
              onMenuPressed: widget.onMenuPressed,
              onStartSearch: _startSearch,
            ),
    );
  }
}

class _NormalBar extends StatelessWidget {
  final bool showMenu;
  final bool showSearch;
  final VoidCallback? onMenuPressed;
  final VoidCallback onStartSearch;

  const _NormalBar({
    required this.showMenu,
    required this.showSearch,
    required this.onStartSearch,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showMenu)
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.secondaryDark),
            onPressed: onMenuPressed,
            constraints: const BoxConstraints(),
          ),
        if (showMenu) const SizedBox(width: 12),
        SvgPicture.asset(
          AppImages.nortus,
          height: 20,
          colorFilter: const ColorFilter.mode(
            AppColors.secondaryDark,
            BlendMode.srcIn,
          ),
        ),
        const Spacer(),
        if (showSearch)
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.secondaryDark),
            onPressed: onStartSearch,
            constraints: const BoxConstraints(),
          ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  final bool showMenu;
  final VoidCallback? onMenuPressed;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onSearchSubmitted;
  final String searchHint;
  final VoidCallback onSearch;
  final VoidCallback onClose;

  const _SearchBar({
    required this.showMenu,
    required this.controller,
    required this.focusNode,
    required this.searchHint,
    required this.onSearch,
    required this.onClose,
    this.onMenuPressed,
    this.onSearchSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showMenu)
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.secondaryDark),
            onPressed: onMenuPressed,
            constraints: const BoxConstraints(),
          ),
        if (showMenu) const SizedBox(width: 12),
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.secondaryDark.withValues(alpha: 0.3),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    onSubmitted: onSearchSubmitted,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.secondaryDark,
                    ),
                    decoration: InputDecoration(
                      hintText: searchHint,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: AppColors.secondaryDark.withValues(alpha: 0.5),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                AppButton.text(
                  text: "Pesquisar",
                  onPressed: onSearch,
                  textDecoration: TextDecoration.none,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.secondaryDark.withValues(alpha: 0.3),
            ),
          ),
          child: IconButton(
            icon: Icon(
              Icons.close,
              color: AppColors.secondaryDark.withValues(alpha: 0.7),
              size: 18,
            ),
            visualDensity: VisualDensity.compact,
            onPressed: onClose,
          ),
        ),
      ],
    );
  }
}

class _BackButtonAppBar extends StatelessWidget {
  final VoidCallback? onBackPressed;
  const _BackButtonAppBar({this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextButton.icon(
        onPressed: onBackPressed,
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 18,
          color: AppColors.secondary,
        ),
        label: const Text(
          "Voltar",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
