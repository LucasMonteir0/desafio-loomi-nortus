import "dart:convert";

import "../../../../commons/utils/cache/app_cache.dart";
import "../../domain/entities/news_detail_entity.dart";
import "author_model.dart";
import "news_image_model.dart";
import "read_also_model.dart";
import "related_news_model.dart";

class NewsDetailsModel extends NewsDetailsEntity {
  const NewsDetailsModel({
    required super.id,
    required super.title,
    required super.image,
    required super.categories,
    required super.publishedAt,
    required super.newsResume,
    required super.estimatedReadingTime,
    required super.authors,
    required super.description,
    required super.relatedNews,
    required super.isFavorite,
    super.readAlso,
  });

  factory NewsDetailsModel.fromJson(Map<String, dynamic> json) {
    return NewsDetailsModel(
      id: json["id"] as int,
      title: json["title"] as String,
      image: NewsImageModel.fromJson(json["image"] as Map<String, dynamic>),
      categories: (json["categories"] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      publishedAt: DateTime.parse(json["publishedAt"] as String),
      newsResume: json["newsResume"] as String,
      estimatedReadingTime: json["estimatedReadingTime"] as String,
      authors: (json["authors"] as List<dynamic>)
          .map((e) => AuthorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json["description"] as String,
      relatedNews: (json["relatedNews"] as List<dynamic>)
          .map((e) => RelatedNewsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      readAlso: json["readAlso"] != null
          ? ReadAlsoModel.fromJson(json["readAlso"] as Map<String, dynamic>)
          : null,
      isFavorite: AppCache.instance.isFavoriteNewsById(json["id"] as int),
    );
  }

  factory NewsDetailsModel.fromDecodedJson(Map<String, dynamic> json) {
    return NewsDetailsModel.fromJson({
      "id": json["id"],
      "title": json["title"],
      "image": jsonDecode(json["image"] as String),
      "categories": jsonDecode(json["categories"] as String),
      "publishedAt": json["publishedAt"],
      "newsResume": json["newsResume"],
      "estimatedReadingTime": json["estimatedReadingTime"],
      "authors": jsonDecode(json["authors"] as String),
      "description": json["description"],
      "relatedNews": jsonDecode(json["relatedNews"] as String),
      "readAlso": json["readAlso"] != null
          ? jsonDecode(json["readAlso"] as String)
          : null,
    });
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "image": (image as NewsImageModel).toJson(),
      "categories": categories,
      "publishedAt": publishedAt.toIso8601String(),
      "newsResume": newsResume,
      "estimatedReadingTime": estimatedReadingTime,
      "authors": authors.map((e) => (e as AuthorModel).toJson()).toList(),
      "description": description,
      "relatedNews": relatedNews
          .map((e) => (e as RelatedNewsModel).toJson())
          .toList(),
      "readAlso": (readAlso as ReadAlsoModel?)?.toJson(),
    };
  }

  Map<String, dynamic> toDecodedJson() {
    return {
      "id": id,
      "title": title,
      "image": jsonEncode((image as NewsImageModel).toJson()),
      "categories": jsonEncode(categories),
      "publishedAt": publishedAt.toIso8601String(),
      "newsResume": newsResume,
      "estimatedReadingTime": estimatedReadingTime,
      "authors": jsonEncode(
        authors.map((e) => (e as AuthorModel).toJson()).toList(),
      ),
      "description": description,
      "relatedNews": jsonEncode(
        relatedNews.map((e) => (e as RelatedNewsModel).toJson()).toList(),
      ),
      "readAlso": readAlso != null
          ? jsonEncode((readAlso as ReadAlsoModel).toJson())
          : null,
    };
  }
}
