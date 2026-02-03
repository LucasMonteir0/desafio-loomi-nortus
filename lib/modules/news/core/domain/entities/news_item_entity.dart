import "package:equatable/equatable.dart";

import "author_entity.dart";
import "news_image_entity.dart";

class NewsItemEntity extends Equatable {
  final int id;
  final String title;
  final NewsImageEntity image;
  final List<String> categories;
  final DateTime publishedAt;
  final String summary;
  final List<AuthorEntity> authors;
  final bool isFavorite;

  const NewsItemEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.categories,
    required this.publishedAt,
    required this.summary,
    required this.authors,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    image,
    categories,
    publishedAt,
    summary,
    authors,
    isFavorite,
  ];
}
