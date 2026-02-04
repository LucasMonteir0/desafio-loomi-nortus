part of "../news_details_view.dart";

class _NewsDetailsAuthorSection extends StatelessWidget {
  final List<AuthorEntity> authors;

  const _NewsDetailsAuthorSection({required this.authors});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Autores",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ...authors.map((author) => _AuthorCard(author: author)),
      ],
    );
  }
}

class _AuthorCard extends StatelessWidget {
  final AuthorEntity author;

  const _AuthorCard({required this.author});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (author.imageUrl.isNotEmpty)
            ClipOval(
              child: AppNetworkImage(
                src: author.imageUrl,
                bytes: author.image?.bytes,
                width: 48,
                height: 48,
              ),
            )
          else
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.backgroundLight,
              ),
              child: const Icon(Icons.person, color: AppColors.textDisabled),
            ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  author.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (author.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    author.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
