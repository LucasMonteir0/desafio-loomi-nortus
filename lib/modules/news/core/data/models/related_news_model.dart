import "../../domain/entities/related_news_entity.dart";
import "author_model.dart";

class RelatedNewsModel extends RelatedNewsEntity {
  const RelatedNewsModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    required super.categories,
    required super.publishedAt,
    required super.authors,
  });

  factory RelatedNewsModel.fromJson(Map<String, dynamic> json) {
    return RelatedNewsModel(
      id: json["id"] as int,
      title: json["title"] as String,
      imageUrl: json["imageUrl"] as String,
      categories: (json["categories"] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      publishedAt: DateTime.parse(json["publishedAt"] as String),
      authors: (json["authors"] as List<dynamic>)
          .map((e) => AuthorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "imageUrl": imageUrl,
      "categories": categories,
      "publishedAt": publishedAt.toIso8601String(),
      "authors": authors.map((e) => (e as AuthorModel).toJson()).toList(),
    };
  }
}
