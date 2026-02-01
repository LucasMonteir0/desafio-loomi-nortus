import "package:flutter/material.dart";
import "package:timeago/timeago.dart" as timeago;

import "../../../commons/presentation/components/app_network_image.dart";
import "../../../commons/utils/cache/app_cache.dart" show AppCache;
import "../../../commons/utils/resources/app_colors.dart";
import "../../core/domain/entities/news_item_entity.dart";

class NewsCard extends StatelessWidget {
  final NewsItemEntity news;
  final VoidCallback? onTap;

  const NewsCard({required this.news, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NewsCardImage(
            imageSrc: news.image.src,
            isFavorite: news.isFavorite,
            onFavTap: (isFavorite) {
              if (isFavorite) {
                AppCache.instance.addFavoriteNews(id: news.id);
              } else {
                AppCache.instance.removeFavoriteNews(id: news.id);
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _NewsCardCategories(categories: news.categories),
                const SizedBox(height: 8),
                _NewsCardTitle(title: news.title),
                const SizedBox(height: 8),
                _NewsCardSummary(summary: news.summary),
                const SizedBox(height: 8),
                _NewsCardTimeAgo(publishedAt: news.publishedAt),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NewsCardImage extends StatefulWidget {
  final String imageSrc;
  final ValueChanged<bool> onFavTap;
  final bool isFavorite;

  const _NewsCardImage({
    required this.imageSrc,
    required this.onFavTap,
    required this.isFavorite,
  });

  @override
  State<_NewsCardImage> createState() => _NewsCardImageState();
}

class _NewsCardImageState extends State<_NewsCardImage> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  void didUpdateWidget(covariant _NewsCardImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFavorite != widget.isFavorite) {
      _isFavorite = widget.isFavorite;
    }
  }

  void _setFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    widget.onFavTap(_isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppNetworkImage(
          src: widget.imageSrc,
          height: 180,
          width: double.infinity,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: IconButton(
            onPressed: _setFavorite,
            icon: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                _isFavorite
                    ? Icons.bookmark_outlined
                    : Icons.bookmark_border_outlined,
                size: 20,
                color: _isFavorite ? Colors.yellow : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NewsCardCategories extends StatelessWidget {
  final List<String> categories;

  const _NewsCardCategories({required this.categories});

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Text(
      categories.first.toUpperCase(),
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: AppColors.textHint,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _NewsCardTitle extends StatelessWidget {
  final String title;

  const _NewsCardTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _NewsCardSummary extends StatelessWidget {
  final String summary;

  const _NewsCardSummary({required this.summary});

  @override
  Widget build(BuildContext context) {
    return Text(
      summary,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.4,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _NewsCardTimeAgo extends StatelessWidget {
  final DateTime publishedAt;

  const _NewsCardTimeAgo({required this.publishedAt});

  @override
  Widget build(BuildContext context) {
    return Text(
      timeago.format(publishedAt, locale: "pt_BR"),
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textHint,
      ),
    );
  }
}
