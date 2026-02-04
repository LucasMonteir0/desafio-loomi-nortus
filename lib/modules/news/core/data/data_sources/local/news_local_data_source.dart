import "../../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../models/news_detail_model.dart";
import "../../models/news_item_model.dart";

abstract class NewsLocalDataSource {
  Future<ResultWrapper<void>> saveNews(List<NewsItemModel> news);
  Future<ResultWrapper<List<NewsItemModel>>> getNews();
  Future<ResultWrapper<void>> saveNewsDetails(NewsDetailsModel details);
  Future<ResultWrapper<NewsDetailsModel?>> getNewsDetails(int id);
}
