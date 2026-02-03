import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";

import "../../../auth/presentation/blocs/sign_out_bloc.dart";
import "../../../commons/config/dependency_injection.dart";
import "../../../commons/config/routes.dart";
import "../../../commons/presentation/components/app_button.dart";
import "../../../commons/presentation/components/app_error_widget.dart";
import "../../../commons/presentation/components/app_progress_indicator.dart";
import "../../../commons/presentation/components/custom_app_bar.dart";
import "../../../commons/utils/resources/app_colors.dart";
import "../../../commons/utils/states/base_state.dart";
import "../../core/domain/entities/profile_entity.dart";
import "../blocs/get_profile_bloc.dart";

part "parts/profile_header.dart";

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final GetProfileBloc _getProfileBloc;

  @override
  void initState() {
    super.initState();
    _getProfileBloc = getIt<GetProfileBloc>();
    _getProfileBloc.call();
  }

  @override
  void dispose() {
    _getProfileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(),
        Expanded(
          child: BlocBuilder<GetProfileBloc, BaseState>(
            bloc: _getProfileBloc,
            builder: (context, state) {
              return switch (state) {
                LoadingState() => const Center(child: AppProgressIndicator()),
                ErrorState() => AppErrorWidget(onRetry: _getProfileBloc.call),
                SuccessState<ProfileEntity>(data: final profile) =>
                  _ProfileSuccessWidget(profile: profile),
                _ => const SizedBox.shrink(),
              };
            },
          ),
        ),
      ],
    );
  }
}

class _ProfileSuccessWidget extends StatefulWidget {
  const _ProfileSuccessWidget({required this.profile});

  final ProfileEntity profile;

  @override
  State<_ProfileSuccessWidget> createState() => _ProfileSuccessWidgetState();
}

class _ProfileSuccessWidgetState extends State<_ProfileSuccessWidget> {
  late final SignOutBloc _signOutBloc;

  @override
  void initState() {
    super.initState();
    _signOutBloc = getIt<SignOutBloc>();
  }

  @override
  void dispose() {
    _signOutBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProfileHeader(profile: widget.profile),
          const SizedBox(height: 24),
          AppButton.outlined(
            text: "Configurações de usuário",
            icon: Icons.settings_outlined,
            onPressed: () =>
                context.push(Routes.userSettings, extra: widget.profile),
          ),
          const SizedBox(height: 16),
          BlocConsumer<SignOutBloc, BaseState>(
            bloc: _signOutBloc,
            listener: (context, state) {
              if (state.isSuccess) {
                context.go(Routes.auth);
              }
            },
            builder: (context, state) {
              return AppButton.outlined(
                text: "Sair da conta",
                isLoading: state.isLoading,
                borderColor: AppColors.error,
                contentColor: AppColors.error,
                onPressed: _signOutBloc.call,
              );
            },
          ),
          const SizedBox(height: 32),
          // const _ProfileFavoriteNews(),
        ],
      ),
    );
  }
}
