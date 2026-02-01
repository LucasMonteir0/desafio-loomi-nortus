import "../../domain/entities/news_detail_entity.dart";
import "author_model.dart";
import "news_image_model.dart";
import "read_also_model.dart";
import "related_news_model.dart";

class NewsDetailModel extends NewsDetailEntity {
  const NewsDetailModel({
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
    super.readAlso,
  });

  factory NewsDetailModel.fromJson(Map<String, dynamic> json) {
    return NewsDetailModel(
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
    );
  }
}
