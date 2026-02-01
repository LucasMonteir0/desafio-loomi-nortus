import "news_image_entity.dart";

class AuthorEntity {
  final String name;
  final NewsImageEntity? image;
  final String? photoUrl;
  final String description;

  const AuthorEntity({
    required this.name,
    required this.description,
    this.image,
    this.photoUrl,
  });

  String get imageUrl => image?.src ?? photoUrl ?? "";
}
