part of "../news_view.dart";

class _NewsEmptyState extends StatelessWidget {
  const _NewsEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Nenhuma notícia encontrada",
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 36),
          Center(child: Image.asset(AppImages.emptyMailBox)),
        ],
      ),
    );
  }
}
