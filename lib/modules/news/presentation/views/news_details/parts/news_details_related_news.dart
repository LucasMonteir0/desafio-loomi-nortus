part of "../news_details_view.dart";

class _NewsDetailsRelatedNews extends StatelessWidget {
  final List<RelatedNewsEntity> relatedNews;
  final ValueChanged<int> onTap;
  final ValueChanged<bool> onFavTap;

  const _NewsDetailsRelatedNews({
    required this.relatedNews,
    required this.onTap,
    required this.onFavTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Notícias Relacionadas"),
        const SizedBox(height: 24),
        GridView.builder(
          itemCount: relatedNews.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final news = relatedNews[index].toNewsEntity();
            return _NewsDetailsRelatedNewsCard(
              news: news,
              onTap: () => onTap(news.id),
              onFavTap: onFavTap,
            );
          },
        ),
      ],
    );
  }
}

class _NewsDetailsRelatedNewsCard extends StatelessWidget {
  final NewsItemEntity news;
  final VoidCallback onTap;
  final ValueChanged<bool> onFavTap;

  const _NewsDetailsRelatedNewsCard({
    required this.onFavTap,
    required this.news,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AppNetworkImage(
                src: news.image.src,
                height: 154,
                width: double.infinity,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: FavoriteIcon(
                  initialValue: news.isFavorite,
                  size: 24,
                  onFavTap: (value) {
                    if (value) {
                      AppCache.instance.addFavoriteNews(news: news);
                    } else {
                      AppCache.instance.removeFavoriteNews(news: news);
                    }
                    onFavTap.call(value);
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (news.categories.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      news.categories.first.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textHint,
                      ),
                    ),
                  ),
                const SizedBox(height: 4),
                Expanded(
                  child: Text(
                    news.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      height: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  timeago.format(news.publishedAt, locale: "pt_BR"),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
