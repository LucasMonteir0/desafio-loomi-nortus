import "../../../../commons/core/domain/entities/pagination.dart";
import "../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../domain/entities/news_detail_entity.dart";
import "../../domain/entities/news_item_entity.dart";

abstract class NewsDataSource {
  Future<ResultWrapper<Pagination<NewsItemEntity>>> getNews(int page);
  Future<ResultWrapper<NewsDetailEntity>> getNewsDetails(int id);
}
