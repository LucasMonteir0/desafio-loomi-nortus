// part of "../profile_view.dart";

// class _ProfileFavoriteNews extends StatelessWidget {
//   const _ProfileFavoriteNews();

//   @override
//   Widget build(BuildContext context) {
//     final favoriteNewsIds = AppCache.instance.getFavoriteNewsIds();

//     if (favoriteNewsIds.isEmpty) {
//       return const SizedBox.shrink();
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SectionHeader(title: "Notícias Favoritadas"),
//         const SizedBox(height: 16),
//         BlocBuilder<GetNewsBloc, BaseState>(
//           bloc: getIt<GetNewsBloc>(),
//           builder: (context, state) {
//             final favoriteNews = allNews
//                 .where((news) => favoriteNewsIds.contains(news.id))
//                 .toList();

//             if (favoriteNews.isEmpty) {
//               return const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 16),
//                 child: Text(
//                   "Nenhuma notícia favoritada ainda",
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: AppColors.textSecondary,
//                   ),
//                 ),
//               );
//             }

//             return ListView.separated(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: favoriteNews.length,
//               separatorBuilder: (_, _) => const SizedBox(height: 16),
//               itemBuilder: (context, index) {
//                 final news = favoriteNews[index];
//                 return NewsCard(
//                   news: news,
//                   onTap: () => context.push("${Routes.news}/${news.id}"),
//                   onFavTap: (isFavorite) {
//                     if (!isFavorite) {
//                       AppCache.instance.removeFavoriteNews(id: news.id);
//                     }
//                   },
//                 );
//               },
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
