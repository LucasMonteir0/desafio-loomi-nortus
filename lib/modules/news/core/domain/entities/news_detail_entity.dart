import "package:equatable/equatable.dart";

import "author_entity.dart";
import "news_image_entity.dart";
import "read_also_entity.dart";
import "related_news_entity.dart";

class NewsDetailsEntity extends Equatable {
  final int id;
  final String title;
  final NewsImageEntity image;
  final List<String> categories;
  final DateTime publishedAt;
  final String newsResume;
  final String estimatedReadingTime;
  final List<AuthorEntity> authors;
  final String description;
  final List<RelatedNewsEntity> relatedNews;
  final ReadAlsoEntity? readAlso;
  final bool isFavorite;

  const NewsDetailsEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.categories,
    required this.publishedAt,
    required this.newsResume,
    required this.estimatedReadingTime,
    required this.authors,
    required this.description,
    required this.relatedNews,
    required this.isFavorite,
    this.readAlso,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    image,
    categories,
    publishedAt,
    newsResume,
    estimatedReadingTime,
    authors,
    description,
    relatedNews,
    readAlso,
    isFavorite,
  ];
}
