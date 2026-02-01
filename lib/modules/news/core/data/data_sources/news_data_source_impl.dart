import "../../../../commons/config/dependency_injection.dart";
import "../../../../commons/config/urls.dart";
import "../../../../commons/core/data/models/pagination_model.dart";
import "../../../../commons/core/domain/entities/api/api_error.dart";
import "../../../../commons/core/domain/entities/pagination.dart";
import "../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../../../commons/core/domain/services/http_service.dart";
import "../../../../commons/utils/errors/errors.dart";
import "../../../../commons/utils/errors/handle_errors.dart";
import "../../domain/entities/news_detail_entity.dart";
import "../../domain/entities/news_item_entity.dart";
import "../models/news_detail_model.dart";
import "../models/news_item_model.dart";
import "news_data_source.dart";

class NewsDataSourceImpl implements NewsDataSource {
  late HttpService _http;

  NewsDataSourceImpl() {
    _http = getIt<HttpService>();
  }

  @override
  Future<ResultWrapper<Pagination<NewsItemEntity>>> getNews(int page) async {
    try {
      final response = await _http.get<Map<String, dynamic>>(
        "${Urls.baseUrl}/news?page=$page",
      );

      final pagination = PaginationModel.fromResponse<NewsItemEntity>(
        response.data!,
        NewsItemModel.fromJson,
      );

      return ResultWrapper.success(pagination);
    } on ApiError catch (e) {
      final error = handleError(e.statusCode);
      return ResultWrapper.error(error);
    } catch (e) {
      return ResultWrapper.error(
        UnknownError(message: "Não foi possível carregar as notícias."),
      );
    }
  }

  @override
  Future<ResultWrapper<NewsDetailEntity>> getNewsDetails(int id) async {
    try {
      final response = await _http.get<Map<String, dynamic>>(
        "${Urls.baseUrl}/news/$id/details",
      );

      final detail = NewsDetailModel.fromJson(response.data!);
      return ResultWrapper.success(detail);
    } on ApiError catch (e) {
      final error = handleError(e.statusCode);
      return ResultWrapper.error(error);
    } catch (e) {
      return ResultWrapper.error(
        UnknownError(
          message: "Não foi possível carregar os detalhes da notícia.",
        ),
      );
    }
  }
}
