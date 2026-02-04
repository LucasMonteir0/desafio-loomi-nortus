import "../../../../commons/config/dependency_injection.dart";
import "../../../../commons/core/domain/entities/pagination.dart";
import "../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../domain/entities/news_detail_entity.dart";
import "../../domain/entities/news_item_entity.dart";
import "../../domain/repositories/news_repository.dart";
import "../data_sources/remote/news_data_source.dart";
import "../data_sources/local/news_local_data_source.dart";
import "../models/news_detail_model.dart";
import "../models/news_item_model.dart";

class NewsRepositoryImpl implements NewsRepository {
  late final NewsDataSource _remoteDataSource;
  late final NewsLocalDataSource _localDataSource;

  NewsRepositoryImpl() {
    _remoteDataSource = getIt<NewsDataSource>();
    _localDataSource = getIt<NewsLocalDataSource>();
  }

  @override
  Future<ResultWrapper<Pagination<NewsItemEntity>>> getNews(int page) async {
    final result = await _remoteDataSource.getNews(page);

    if (result.isSuccess) {
      final items = result.data!.data;

      final models = items.map((e) => e as NewsItemModel).toList();
      if (models.isNotEmpty) {
        await _localDataSource.saveNews(models);
      }
      return result;
    }

    final localResult = await _localDataSource.getNews();

    if (localResult.isSuccess) {
      return ResultWrapper.success(
        Pagination(
          data: localResult.data!,
          page: 1,
          pageSize: 10,
          totalItems: localResult.data!.length,
          totalPages: 1,
        ),
      );
    }

    return result;
  }

  @override
  Future<ResultWrapper<NewsDetailsEntity>> getNewsDetails(int id) async {
    final result = await _remoteDataSource.getNewsDetails(id);

    if (result.isSuccess) {
      await _localDataSource.saveNewsDetails(result.data as NewsDetailsModel);
      return result;
    }

    final localResult = await _localDataSource.getNewsDetails(id);
    if (localResult.isSuccess) {
      return ResultWrapper.success(localResult.data!);
    }

    return result;
  }
}
