import "../../../../commons/utils/cache/app_cache.dart";
import "../../domain/entities/news_item_entity.dart";
import "author_model.dart";
import "news_image_model.dart";

class NewsItemModel extends NewsItemEntity {
  const NewsItemModel({
    required super.id,
    required super.title,
    required super.image,
    required super.categories,
    required super.publishedAt,
    required super.summary,
    required super.authors,
    required super.isFavorite,
  });

  factory NewsItemModel.fromJson(Map<String, dynamic> json) {
    return NewsItemModel(
      id: json["id"] as int,
      title: json["title"] as String,
      image: NewsImageModel.fromJson(json["image"] as Map<String, dynamic>),
      categories: (json["categories"] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      publishedAt: DateTime.parse(json["publishedAt"] as String),
      summary: json["summary"] as String,
      authors: (json["authors"] as List<dynamic>)
          .map((e) => AuthorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isFavorite: AppCache.instance.isFavoriteNews(id: json["id"] as int),
    );
  }
}
