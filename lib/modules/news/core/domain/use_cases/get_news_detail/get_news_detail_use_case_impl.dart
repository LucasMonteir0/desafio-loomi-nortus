import "../../../../../commons/config/dependency_injection.dart";
import "../../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../entities/news_detail_entity.dart";
import "../../repositories/news_repository.dart";
import "get_news_detail_use_case.dart";

class GetNewsDetailUseCaseImpl implements GetNewsDetailUseCase {
  late final NewsRepository _repository;

  GetNewsDetailUseCaseImpl() {
    _repository = getIt<NewsRepository>();
  }

  @override
  Future<ResultWrapper<NewsDetailEntity>> call(int id) {
    return _repository.getNewsDetails(id);
  }
}
