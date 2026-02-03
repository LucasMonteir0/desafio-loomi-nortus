import "../../../../commons/core/domain/entities/pagination.dart";
import "../../../../commons/core/domain/entities/result_wrapper.dart";
import "../entities/news_detail_entity.dart";
import "../entities/news_item_entity.dart";

abstract class NewsRepository {
  Future<ResultWrapper<Pagination<NewsItemEntity>>> getNews(int page);
  Future<ResultWrapper<NewsDetailsEntity>> getNewsDetails(int id);
}
