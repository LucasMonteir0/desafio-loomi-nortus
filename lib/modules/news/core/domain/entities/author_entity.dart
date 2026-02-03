import "package:equatable/equatable.dart";

import "news_image_entity.dart";

class AuthorEntity extends Equatable {
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

  @override
  List<Object?> get props => [name, image, photoUrl, description];
}
