import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../utils/resources/app_colors.dart";
import "../../utils/resources/app_images.dart";
import "app_button.dart";

class CustomAppBar extends StatefulWidget {
  final VoidCallback? onMenuPressed;
  final ValueChanged<String>? onSearchSubmitted;
  final String searchHint;

  const CustomAppBar({
    this.onMenuPressed,
    this.onSearchSubmitted,
    this.searchHint = "Pesquisar...",
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
    });
  }

  void _onSearch() {
    widget.onSearchSubmitted?.call(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    final bool showMenu = widget.onMenuPressed != null;
    final bool showSearch = widget.onSearchSubmitted != null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(color: AppColors.backgroundLight),
      child: _isSearching
          ? _buildSearchBar(showMenu)
          : _buildNormalBar(showMenu, showSearch),
    );
  }

  Widget _buildNormalBar(bool showMenu, bool showSearch) {
    return Row(
      children: [
        if (showMenu)
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.secondaryDark),
            onPressed: widget.onMenuPressed,
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
            onPressed: _startSearch,
            constraints: const BoxConstraints(),
          ),
      ],
    );
  }

  Widget _buildSearchBar(bool showMenu) {
    return Row(
      children: [
        if (showMenu)
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.secondaryDark),
            onPressed: widget.onMenuPressed,
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
                    controller: _searchController,
                    focusNode: _focusNode,
                    onSubmitted: widget.onSearchSubmitted,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.secondaryDark,
                    ),
                    decoration: InputDecoration(
                      hintText: widget.searchHint,
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
                  onPressed: _onSearch,
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
            onPressed: _stopSearch,
          ),
        ),
      ],
    );
  }
}
