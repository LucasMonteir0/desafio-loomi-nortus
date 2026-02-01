import "../../../../../commons/config/dependency_injection.dart";
import "../../../../../commons/core/domain/entities/pagination.dart";
import "../../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../entities/news_item_entity.dart";
import "../../repositories/news_repository.dart";
import "get_news_use_case.dart";

class GetNewsUseCaseImpl implements GetNewsUseCase {
  late final NewsRepository _repository;

  GetNewsUseCaseImpl() {
    _repository = getIt<NewsRepository>();
  }

  @override
  Future<ResultWrapper<Pagination<NewsItemEntity>>> call(int page) {
    return _repository.getNews(page);
  }
}
