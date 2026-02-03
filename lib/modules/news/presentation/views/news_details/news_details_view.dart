import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:timeago/timeago.dart" as timeago;

import "../../../../commons/config/dependency_injection.dart";
import "../../../../commons/config/routes.dart";
import "../../../../commons/presentation/components/app_error_widget.dart";
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
import "../../components/news_card.dart";
import "../../components/section_header.dart";

part "parts/news_details_categories.dart";
part "parts/news_details_image.dart";
part "parts/news_details_author_section.dart";
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
      body: BlocBuilder<GetNewsDetailBloc, BaseState>(
        bloc: _bloc,
        builder: (context, state) {
          return switch (state) {
            InitialState() ||
            LoadingState() => const Center(child: AppProgressIndicator()),
            SuccessState<NewsDetailsEntity>(:final data) => _NewsDetailsContent(
              news: data,
              onBackPressed: () {
                context.pop(shouldUpdateOnPop);
              },
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
    );
  }
}

class _NewsDetailsContent extends StatelessWidget {
  final NewsDetailsEntity news;
  final VoidCallback onBackPressed;
  final ValueChanged<int> onRelatedNewsTap;
  final ValueChanged<bool> shouldUpdateOnPop;

  const _NewsDetailsContent({
    required this.news,
    required this.onBackPressed,
    required this.onRelatedNewsTap,
    required this.shouldUpdateOnPop,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(onBackPressed: onBackPressed),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _NewsDetailsHeaderRow(
                    categories: news.categories,
                    news: news,
                    shouldUpdateOnPop: shouldUpdateOnPop,
                  ),
                  const SizedBox(height: 12),
                  _NewsDetailsTitle(title: news.title),
                  const SizedBox(height: 12),
                  _NewsDetailsPublishedInfo(publishedAt: news.publishedAt),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            _NewsDetailsImage(image: news.image),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _NewsDetailsSummary(summary: news.newsResume),
                  const SizedBox(height: 24),
                  _NewsDetailsDescription(description: news.description),
                  const SizedBox(height: 16),
                  _NewsDetailsCategoriesRow(categories: news.categories),
                  if (news.authors.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    _NewsDetailsAuthorSection(authors: news.authors),
                  ],
                  if (news.relatedNews.isNotEmpty) ...[
                    const SizedBox(height: 32),
                    _NewsDetailsRelatedNews(
                      relatedNews: news.relatedNews,
                      onTap: onRelatedNewsTap,
                      onFavTap: (value) {
                        shouldUpdateOnPop(true);
                      },
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
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
