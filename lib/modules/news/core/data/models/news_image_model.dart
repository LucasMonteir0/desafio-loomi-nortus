import "../../domain/entities/news_image_entity.dart";

class NewsImageModel extends NewsImageEntity {
  const NewsImageModel({required super.src, required super.alt});

  factory NewsImageModel.fromJson(Map<String, dynamic> json) {
    return NewsImageModel(
      src: json["src"] as String,
      alt: json["alt"] as String,
    );
  }
}
