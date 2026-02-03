import "package:flutter/material.dart";
import "../../../commons/utils/resources/app_colors.dart";

class FavoriteIcon extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool>? onFavTap;
  final double size;

  const FavoriteIcon({
    required this.initialValue,
    this.onFavTap,
    this.size = 20,
    super.key,
  });

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.initialValue;
  }

  void _setFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    widget.onFavTap?.call(_isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: const CircleBorder(),
      elevation: 1,
      child: InkWell(
        onTap: _setFavorite,
        child: Ink(
          padding: const EdgeInsets.all(4),
          color: AppColors.white,
          child: Icon(
            _isFavorite
                ? Icons.bookmark_outlined
                : Icons.bookmark_border_outlined,
            size: widget.size,
            color: _isFavorite ? Colors.yellow : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
