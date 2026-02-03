part of "../news_view.dart";

class _NewsListContent extends StatelessWidget {
  final List<NewsItemEntity> items;
  final bool isLoadingMore;
  final String searchQuery;
  final ScrollController scrollController;
  final VoidCallback onRefresh;
  final ValueChanged<int> onNewsTap;

  const _NewsListContent({
    required this.items,
    required this.isLoadingMore,
    required this.searchQuery,
    required this.scrollController,
    required this.onRefresh,
    required this.onNewsTap,
  });

  List<NewsItemEntity> get _filteredItems {
    if (searchQuery.isEmpty) {
      return items;
    }

    return items.where((news) {
      final titleMatch = news.title.toLowerCase().contains(searchQuery);
      final categoryMatch = news.categories.any(
        (cat) => cat.toLowerCase().contains(searchQuery),
      );
      return titleMatch || categoryMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = _filteredItems;

    if (items.isEmpty && !isLoadingMore) {
      return const _NewsEmptyState();
    }

    if (filteredItems.isEmpty && searchQuery.isNotEmpty) {
      return _NewsNoSearchResults(searchQuery: searchQuery);
    }

    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      color: AppColors.primary,
      child: ListView.separated(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        itemCount:
            filteredItems.length +
            (isLoadingMore && searchQuery.isEmpty ? 1 : 0),
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          if (index == filteredItems.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Center(child: AppProgressIndicator()),
            );
          }

          final item = filteredItems[index];
          return NewsCard(news: item, onTap: () => onNewsTap(item.id))
              .animate()
              .fade(duration: 400.ms, delay: (100 * index).ms)
              .slideY(begin: 0.1, duration: 400.ms, curve: Curves.easeOut);
        },
      ),
    );
  }
}
