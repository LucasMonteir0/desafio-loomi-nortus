part of "../news_details_view.dart";

class _NewsDetailsHeaderRow extends StatelessWidget {
  final NewsDetailsEntity news;
  final List<String> categories;
  final ValueChanged<bool> shouldUpdateOnPop;

  const _NewsDetailsHeaderRow({
    required this.news,
    required this.categories,
    required this.shouldUpdateOnPop,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NewsCategoryChip(category: categories.first),
        const Spacer(),
        FavoriteIcon(
          initialValue: news.isFavorite,
          onFavTap: (value) {
            if (value) {
              AppCache.instance.addFavoriteNews(id: news.id);
            } else {
              AppCache.instance.removeFavoriteNews(id: news.id);
            }
            shouldUpdateOnPop(true);
          },
        ),
      ],
    );
  }
}

class _NewsDetailsCategoriesRow extends StatelessWidget {
  final List<String> categories;
  const _NewsDetailsCategoriesRow({required this.categories});

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories
          .map(
            (category) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.7),
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                category,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
