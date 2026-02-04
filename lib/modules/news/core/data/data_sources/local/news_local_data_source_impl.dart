import "package:sqflite/sqflite.dart";

import "../../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../../../../commons/core/domain/services/local_databasse_service.dart";
import "../../../../../commons/utils/errors/errors.dart";
import "../../models/news_detail_model.dart";
import "../../models/news_item_model.dart";
import "news_local_data_source.dart";

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final LocalDatabaseService _databaseService;

  NewsLocalDataSourceImpl(this._databaseService);

  @override
  Future<ResultWrapper<void>> saveNews(List<NewsItemModel> news) async {
    try {
      final db = await _databaseService.database;
      final batch = db.batch();

      for (var item in news) {
        batch.insert(
          "news_items",
          item.toDecodedJson(),
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

      final news = result.map((e) => NewsItemModel.fromDecodedJson(e)).toList();
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
      await db.insert(
        "news_details",
        details.toDecodedJson(),
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

      final detail = NewsDetailsModel.fromDecodedJson(result.first);
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
