part of "../news_details_view.dart";

class _NewsDetailsImage extends StatelessWidget {
  final NewsImageEntity image;

  const _NewsDetailsImage({required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppNetworkImage(src: image.src, height: 220, width: double.infinity),
        if (image.alt.isNotEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                image.alt,
                style: const TextStyle(fontSize: 12, color: AppColors.textHint),
              ),
            ),
          ),
      ],
    );
  }
}
