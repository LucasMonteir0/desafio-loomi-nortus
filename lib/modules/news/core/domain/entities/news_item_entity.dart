import "author_entity.dart";
import "news_image_entity.dart";

class NewsItemEntity {
  final int id;
  final String title;
  final NewsImageEntity image;
  final List<String> categories;
  final DateTime publishedAt;
  final String summary;
  final List<AuthorEntity> authors;

  const NewsItemEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.categories,
    required this.publishedAt,
    required this.summary,
    required this.authors,
  });
}
