part of "../auth_view.dart";

class _SignUpForm extends StatelessWidget {
  const _SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Formulário de registro",
        style: TextStyle(fontSize: 16, color: AppColors.textHint),
      ),
    );
  }
}
