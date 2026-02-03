import "../../../commons/utils/cache/app_cache.dart";
import "../../core/domain/entities/news_image_entity.dart";
import "../../core/domain/entities/news_item_entity.dart";
import "../../core/domain/entities/related_news_entity.dart";

extension RelatedNewsExtension on RelatedNewsEntity {
  NewsItemEntity toNewsEntity() {
    return NewsItemEntity(
      id: id,
      title: title,
      summary: "",
      image: NewsImageEntity(src: imageUrl, alt: ""),
      categories: categories,
      authors: authors,
      publishedAt: publishedAt,
      isFavorite: AppCache.instance.isFavoriteNews(id),
    );
  }
}
