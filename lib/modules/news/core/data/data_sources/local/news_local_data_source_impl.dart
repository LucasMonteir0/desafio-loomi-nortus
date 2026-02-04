import "dart:typed_data";
import "package:sqflite/sqflite.dart";

import "../../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../../../../commons/core/domain/services/http_service.dart";
import "../../../../../commons/core/domain/services/local_databasse_service.dart";
import "../../../../../commons/utils/errors/errors.dart";
import "../../models/news_detail_model.dart";
import "../../models/news_item_model.dart";
import "news_local_data_source.dart";

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final LocalDatabaseService _databaseService;
  final HttpService _httpService;

  NewsLocalDataSourceImpl(this._databaseService, this._httpService);

  @override
  Future<ResultWrapper<void>> saveNews(List<NewsItemModel> news) async {
    try {
      final db = await _databaseService.database;
      final batch = db.batch();

      final downloadFutures = news.map(
        (item) => _httpService.getBytes(item.image.src),
      );

      final downloadResults = await Future.wait(downloadFutures);

      for (var i = 0; i < news.length; i++) {
        final item = news[i];
        final response = downloadResults[i];
        Uint8List? bytes;

        if (response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300) {
          bytes = Uint8List.fromList(response.data!);
        }

        final data = item.toDecodedJson();
        data["imageBytes"] = bytes;

        batch.insert(
          "news_items",
          data,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit();
      return ResultWrapper.success(null);
    } on DatabaseException catch (e) {
      return ResultWrapper.error(
        UnknownError(
          message: "Erro ao salvar notícias localmente: ${e.toString()}",
        ),
      );
    } catch (e) {
      return ResultWrapper.error(
        UnknownError(message: "Erro inesperado ao salvar notícias localmente."),
      );
    }
  }

  @override
  Future<ResultWrapper<List<NewsItemModel>>> getNews() async {
    try {
      final db = await _databaseService.database;
      final result = await db.query("news_items", orderBy: "publishedAt DESC");

      final news = result.map((e) {
        final Map<String, dynamic> map = Map<String, dynamic>.from(e);
        return NewsItemModel.fromDecodedJson(map);
      }).toList();
      return ResultWrapper.success(news);
    } on DatabaseException catch (e) {
      return ResultWrapper.error(
        UnknownError(
          message: "Erro ao buscar notícias localmente: ${e.toString()}",
        ),
      );
    } catch (e) {
      return ResultWrapper.error(
        UnknownError(message: "Erro inesperado ao buscar notícias localmente."),
      );
    }
  }

  @override
  Future<ResultWrapper<void>> saveNewsDetails(NewsDetailsModel details) async {
    try {
      final db = await _databaseService.database;

      Uint8List? bytes;
      try {
        final response = await _httpService.getBytes(details.image.src);
        if (response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300) {
          bytes = Uint8List.fromList(response.data!);
        }
      } catch (_) {}

      final data = details.toDecodedJson();
      data["imageBytes"] = bytes;

      await db.insert(
        "news_details",
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return ResultWrapper.success(null);
    } on DatabaseException catch (e) {
      return ResultWrapper.error(
        UnknownError(
          message:
              "Erro ao salvar detalhes da notícia localmente: ${e.toString()}",
        ),
      );
    } catch (e) {
      return ResultWrapper.error(
        UnknownError(
          message: "Erro inesperado ao salvar detalhes da notícia localmente.",
        ),
      );
    }
  }

  @override
  Future<ResultWrapper<NewsDetailsModel?>> getNewsDetails(int id) async {
    try {
      final db = await _databaseService.database;
      final result = await db.query(
        "news_details",
        where: "id = ?",
        whereArgs: [id],
      );

      if (result.isEmpty) {
        return ResultWrapper.success(null);
      }

      final Map<String, dynamic> map = Map<String, dynamic>.from(result.first);
      final detail = NewsDetailsModel.fromDecodedJson(map);
      return ResultWrapper.success(detail);
    } on DatabaseException catch (e) {
      return ResultWrapper.error(
        UnknownError(
          message:
              "Erro ao buscar detalhes da notícia localmente: ${e.toString()}",
        ),
      );
    } catch (e) {
      return ResultWrapper.error(
        UnknownError(
          message: "Erro inesperado ao buscar detalhes da notícia localmente.",
        ),
      );
    }
  }
}
