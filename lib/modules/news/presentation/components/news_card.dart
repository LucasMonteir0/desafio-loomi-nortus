import "package:flutter/material.dart";
import "package:timeago/timeago.dart" as timeago;

import "../../../commons/presentation/components/app_network_image.dart";
import "../../../commons/utils/cache/app_cache.dart";
import "../../../commons/utils/resources/app_colors.dart";
import "../../core/domain/entities/news_item_entity.dart";
import "favorite_icon.dart";

class NewsCard extends StatelessWidget {
  final NewsItemEntity news;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onFavTap;

  const NewsCard({required this.news, this.onTap, super.key, this.onFavTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NewsCardImage(news: news),
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

class _NewsCardImage extends StatelessWidget {
  final NewsItemEntity news;
  final ValueChanged<bool>? onFavTap;

  const _NewsCardImage({required this.news, this.onFavTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppNetworkImage(
          src: news.image.src,
          height: 180,
          width: double.infinity,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: FavoriteIcon(
            initialValue: news.isFavorite,
            onFavTap: (value) {
              if (value) {
                AppCache.instance.addFavoriteNews(id: news.id);
              } else {
                AppCache.instance.removeFavoriteNews(id: news.id);
              }
              onFavTap?.call(value);
            },
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
