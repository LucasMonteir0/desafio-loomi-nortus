import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:go_router/go_router.dart";

import "../../../../commons/config/dependency_injection.dart";
import "../../../../commons/config/routes.dart";
import "../../../../commons/presentation/components/app_progress_indicator.dart"
    show AppProgressIndicator;
import "../../../../commons/presentation/components/custom_app_bar.dart";
import "../../../../commons/utils/resources/app_colors.dart";
import "../../../../commons/utils/resources/app_images.dart";
import "../../../../commons/utils/states/pagination_state.dart";
import "../../../core/domain/entities/news_item_entity.dart";
import "../../blocs/get_news_bloc.dart";
import "../../components/news_card.dart";

part "parts/news_empty_state.dart";
part "parts/news_no_search_results.dart";
part "parts/news_list_content.dart";

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  late final GetNewsBloc _bloc;
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _bloc = getIt<GetNewsBloc>();
    _bloc.load();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _bloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _bloc.load();
    }
  }

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query.toLowerCase().trim();
    });
  }

  void _onNewsTap(int newsId) async {
    final result = await context.push<bool>("${Routes.news}/$newsId");
    if (result == true) {
      _bloc.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          searchHint: "Buscar notícias...",
          onSearchSubmitted: _onSearch,
          onCloseSearch: () => _onSearch(""),
          onMenuPressed: () {},
        ),
        Expanded(
          child: BlocBuilder<GetNewsBloc, PaginationState<NewsItemEntity>>(
            bloc: _bloc,
            builder: (context, state) {
              return switch (state) {
                PaginationInitialState() => const Center(
                  child: AppProgressIndicator(),
                ),
                PaginationLoadingState(
                  :final currentItems,
                  :final isLoadingMore,
                ) =>
                  currentItems.isEmpty && !isLoadingMore
                      ? const Center(child: AppProgressIndicator())
                      : _NewsListContent(
                          items: currentItems,
                          isLoadingMore: isLoadingMore,
                          searchQuery: _searchQuery,
                          scrollController: _scrollController,
                          onRefresh: _bloc.refresh,
                          onNewsTap: _onNewsTap,
                        ),
                PaginationSuccessState(:final items) => _NewsListContent(
                  items: items,
                  isLoadingMore: false,
                  searchQuery: _searchQuery,
                  scrollController: _scrollController,
                  onRefresh: _bloc.refresh,
                  onNewsTap: _onNewsTap,
                ),
                PaginationErrorState(:final currentItems) => _NewsListContent(
                  items: currentItems,
                  isLoadingMore: false,
                  searchQuery: _searchQuery,
                  scrollController: _scrollController,
                  onRefresh: _bloc.refresh,
                  onNewsTap: _onNewsTap,
                ),
              };
            },
          ),
        ),
      ],
    );
  }
}
