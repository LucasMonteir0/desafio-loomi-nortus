part of "../news_details_view.dart";

class _NewsDetailsSummary extends StatelessWidget {
  final String summary;

  const _NewsDetailsSummary({required this.summary});

  @override
  Widget build(BuildContext context) {
    if (summary.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.primary,
            blurRadius: 0.5,
            offset: Offset(-2, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.auto_awesome,
                color: AppColors.secondaryDark,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                "Resumo NortusAI",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondaryDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            summary,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
