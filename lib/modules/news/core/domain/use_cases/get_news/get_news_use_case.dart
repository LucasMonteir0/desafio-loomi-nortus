import "../../../../../commons/core/domain/entities/pagination.dart";
import "../../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../entities/news_item_entity.dart";

abstract class GetNewsUseCase {
  Future<ResultWrapper<Pagination<NewsItemEntity>>> call(int page);
}
