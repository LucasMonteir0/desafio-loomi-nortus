part of "../profile_view.dart";

class _ProfileFavoriteNews extends StatefulWidget {
  const _ProfileFavoriteNews();

  @override
  State<_ProfileFavoriteNews> createState() => _ProfileFavoriteNewsState();
}

class _ProfileFavoriteNewsState extends State<_ProfileFavoriteNews> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Notícias Favoritadas",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 4,
                  color: AppColors.border,
                ),
                Container(
                  height: 4,
                  width: 150,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        ValueListenableBuilder(
          valueListenable: AppCache.instance.favoriteNewsNotifier,
          builder: (context, favNews, _) {
            if (favNews.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              spacing: 16,
              mainAxisSize: MainAxisSize.min,
              children: favNews
                  .map(
                    (news) => NewsCard(
                      news: news,
                      showFavoriteIcon: false,
                      onTap: () => context.push("${Routes.news}/${news.id}"),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
