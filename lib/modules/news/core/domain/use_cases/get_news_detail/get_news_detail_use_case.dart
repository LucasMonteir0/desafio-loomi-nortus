import "../../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../entities/news_detail_entity.dart";

abstract class GetNewsDetailUseCase {
  Future<ResultWrapper<NewsDetailEntity>> call(int id);
}
