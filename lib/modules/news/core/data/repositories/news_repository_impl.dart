import "../../../../commons/config/dependency_injection.dart";
import "../../../../commons/core/domain/entities/pagination.dart";
import "../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../domain/entities/news_detail_entity.dart";
import "../../domain/entities/news_item_entity.dart";
import "../../domain/repositories/news_repository.dart";
import "../data_sources/news_data_source.dart";

class NewsRepositoryImpl implements NewsRepository {
  late final NewsDataSource _dataSource;

  NewsRepositoryImpl() {
    _dataSource = getIt<NewsDataSource>();
  }

  @override
  Future<ResultWrapper<Pagination<NewsItemEntity>>> getNews(int page) {
    return _dataSource.getNews(page);
  }

  @override
  Future<ResultWrapper<NewsDetailEntity>> getNewsDetails(int id) {
    return _dataSource.getNewsDetails(id);
  }
}
