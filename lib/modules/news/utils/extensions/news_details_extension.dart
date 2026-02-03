import "../../core/domain/entities/news_detail_entity.dart";
import "../../core/domain/entities/news_item_entity.dart";

extension NewsDetailsExtension on NewsDetailsEntity {
  NewsItemEntity toNewsItem() {
    return NewsItemEntity(
      id: id,
      title: title,
      image: image,
      categories: categories,
      publishedAt: publishedAt,
      summary: newsResume,
      authors: authors,
      isFavorite: isFavorite,
    );
  }
}
