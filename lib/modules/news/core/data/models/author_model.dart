import "../../domain/entities/author_entity.dart";
import "news_image_model.dart";

class AuthorModel extends AuthorEntity {
  const AuthorModel({
    required super.name,
    required super.description,
    super.image,
    super.photoUrl,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      name: json["name"] as String,
      image: json["image"] != null
          ? NewsImageModel.fromJson(json["image"] as Map<String, dynamic>)
          : null,
      photoUrl: json["photoUrl"] as String?,
      description: json["description"] as String,
    );
  }
}
