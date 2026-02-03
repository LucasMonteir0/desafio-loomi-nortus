part of "../profile_view.dart";

class _ProfileHeader extends StatelessWidget {
  final ProfileEntity profile;

  const _ProfileHeader({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          profile.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          profile.email,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 16,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 4),
            Text(
              "${profile.address.city}, ${profile.address.country}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
