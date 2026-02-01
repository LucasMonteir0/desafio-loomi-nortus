import "author_entity.dart";

class RelatedNewsEntity {
  final int id;
  final String title;
  final String imageUrl;
  final List<String> categories;
  final DateTime publishedAt;
  final List<AuthorEntity> authors;

  const RelatedNewsEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.categories,
    required this.publishedAt,
    required this.authors,
  });
}
