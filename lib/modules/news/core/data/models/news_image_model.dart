import "dart:typed_data";

import "../../domain/entities/news_image_entity.dart";

class NewsImageModel extends NewsImageEntity {
  const NewsImageModel({required super.src, required super.alt, super.bytes});

  factory NewsImageModel.fromJson(Map<String, dynamic> json) {
    return NewsImageModel(
      src: json["src"] as String,
      alt: json["alt"] as String,
      bytes: json["imageBytes"] as Uint8List?,
    );
  }

  Map<String, dynamic> toJson() {
    return {"src": src, "alt": alt, "imageBytes": bytes};
  }
}
