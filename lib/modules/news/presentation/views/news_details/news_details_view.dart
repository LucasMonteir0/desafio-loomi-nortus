import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:timeago/timeago.dart" as timeago;

import "../../../../commons/config/dependency_injection.dart";
import "../../../../commons/config/routes.dart";
import "../../../../commons/presentation/components/app_error_widget.dart";
import "../../../../commons/presentation/components/app_footer.dart";
import "../../../../commons/presentation/components/app_network_image.dart";
import "../../../../commons/presentation/components/app_progress_indicator.dart";
import "../../../../commons/presentation/components/custom_app_bar.dart";
import "../../../../commons/utils/cache/app_cache.dart";
import "../../../../commons/utils/extensions/date_extensions.dart";
import "../../../../commons/utils/resources/app_colors.dart";
import "../../../../commons/utils/states/base_state.dart";
import "../../../core/domain/entities/author_entity.dart";
import "../../../core/domain/entities/news_detail_entity.dart";
import "../../../core/domain/entities/news_image_entity.dart";
import "../../../core/domain/entities/news_item_entity.dart";
import "../../../core/domain/entities/related_news_entity.dart";
import "../../../utils/extensions/news_extension.dart";
import "../../blocs/get_news_detail_bloc.dart";
import "../../components/favorite_icon.dart";
import "../../components/news_category_chip.dart";
import "../../components/section_header.dart";

part "parts/news_details_author_section.dart";
part "parts/news_details_categories.dart";
part "parts/news_details_image.dart";
part "parts/news_details_related_news.dart";
part "parts/news_details_summary.dart";

class NewsDetailsView extends StatefulWidget {
  final int newsId;

  const NewsDetailsView({required this.newsId, super.key});

  @override
  State<NewsDetailsView> createState() => _NewsDetailsViewState();
}

class _NewsDetailsViewState extends State<NewsDetailsView> {
  late final GetNewsDetailBloc _bloc;

  bool shouldUpdateOnPop = false;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<GetNewsDetailBloc>();
    _bloc.call(widget.newsId);
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _onRelatedNewsTap(int newsId) async {
    final result = await context.push<bool>("${Routes.news}/$newsId");
    if (result == true) {
      _bloc.call(widget.newsId);
      shouldUpdateOnPop = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            bottom: false,
            child: CustomAppBar(
              onBackPressed: () => context.pop(shouldUpdateOnPop),
            ),
          ),
          Expanded(
            child: BlocBuilder<GetNewsDetailBloc, BaseState>(
              bloc: _bloc,
              builder: (context, state) {
                return switch (state) {
                  InitialState() ||
                  LoadingState() => const Center(child: AppProgressIndicator()),
                  SuccessState<NewsDetailsEntity>(:final data) =>
                    _NewsDetailsContent(
                      news: data,
                      onRelatedNewsTap: _onRelatedNewsTap,
                      shouldUpdateOnPop: (value) {
                        shouldUpdateOnPop = value;
                      },
                    ),
                  ErrorState() => AppErrorWidget(
                    onRetry: () => _bloc.call(widget.newsId),
                  ),
                  _ => const SizedBox.shrink(),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NewsDetailsContent extends StatelessWidget {
  final NewsDetailsEntity news;
  final ValueChanged<int> onRelatedNewsTap;
  final ValueChanged<bool> shouldUpdateOnPop;

  const _NewsDetailsContent({
    required this.news,
    required this.onRelatedNewsTap,
    required this.shouldUpdateOnPop,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _NewsDetailsHeaderRow(
                  categories: news.categories,
                  news: news,
                  shouldUpdateOnPop: shouldUpdateOnPop,
                ).animate().fade().slideY(
                  begin: 0.1,
                  curve: Curves.easeOut,
                  duration: 400.ms,
                ),
                const SizedBox(height: 12),
                _NewsDetailsTitle(title: news.title)
                    .animate()
                    .fade(delay: 100.ms, duration: 400.ms)
                    .slideY(begin: 0.1, curve: Curves.easeOut),
                const SizedBox(height: 12),
                _NewsDetailsPublishedInfo(publishedAt: news.publishedAt)
                    .animate()
                    .fade(delay: 150.ms, duration: 400.ms)
                    .slideY(begin: 0.1, curve: Curves.easeOut),
                const SizedBox(height: 16),
              ],
            ),
          ),
          _NewsDetailsImage(image: news.image)
              .animate()
              .fade(delay: 200.ms, duration: 400.ms)
              .slideY(begin: 0.1, curve: Curves.easeOut),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _NewsDetailsSummary(summary: news.newsResume)
                    .animate()
                    .fade(delay: 300.ms, duration: 400.ms)
                    .slideY(begin: 0.1, curve: Curves.easeOut),
                const SizedBox(height: 24),
                _NewsDetailsDescription(description: news.description)
                    .animate()
                    .fade(delay: 400.ms, duration: 400.ms)
                    .slideY(begin: 0.1, curve: Curves.easeOut),
                const SizedBox(height: 16),
                _NewsDetailsCategoriesRow(categories: news.categories)
                    .animate()
                    .fade(delay: 500.ms, duration: 400.ms)
                    .slideY(begin: 0.1, curve: Curves.easeOut),
                if (news.authors.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  _NewsDetailsAuthorSection(authors: news.authors)
                      .animate()
                      .fade(delay: 600.ms, duration: 400.ms)
                      .slideY(begin: 0.1, curve: Curves.easeOut),
                ],
                if (news.relatedNews.isNotEmpty) ...[
                  const SizedBox(height: 32),
                  _NewsDetailsRelatedNews(
                        relatedNews: news.relatedNews,
                        onTap: onRelatedNewsTap,
                        onFavTap: (value) {
                          shouldUpdateOnPop(true);
                        },
                      )
                      .animate()
                      .fade(delay: 700.ms, duration: 400.ms)
                      .slideY(begin: 0.1, curve: Curves.easeOut),
                ],
              ],
            ),
          ),
          const AppFooter(),
        ],
      ),
    );
  }
}

class _NewsDetailsTitle extends StatelessWidget {
  final String title;

  const _NewsDetailsTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.3,
      ),
    );
  }
}

class _NewsDetailsPublishedInfo extends StatelessWidget {
  final DateTime publishedAt;

  const _NewsDetailsPublishedInfo({required this.publishedAt});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Publicado: ${publishedAt.toDateAndTime()}",
          style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
        ),
      ],
    );
  }
}

class _NewsDetailsDescription extends StatelessWidget {
  final String description;

  const _NewsDetailsDescription({required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: const TextStyle(
        fontSize: 16,
        color: AppColors.textPrimary,
        height: 1.6,
      ),
    );
  }
}
