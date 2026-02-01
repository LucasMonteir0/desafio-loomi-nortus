part of "../news_view.dart";

class _NewsNoSearchResults extends StatelessWidget {
  final String searchQuery;

  const _NewsNoSearchResults({required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text.rich(
              TextSpan(
                text: "Resultado da busca por ",
                style: const TextStyle(color: AppColors.textPrimary),
                children: [
                  TextSpan(
                    text: searchQuery,
                    style: const TextStyle(color: AppColors.secondary),
                  ),
                ],
              ),
            ),
            const Text(
              "Verifique se existe algum erro de digitação no termo.",
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 36),
            Center(child: Image.asset(AppImages.emptyMailBox)),
          ],
        ),
      ),
    );
  }
}
