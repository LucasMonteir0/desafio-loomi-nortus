import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";

import "../../../commons/config/app_router.dart";
import "../../../commons/config/dependency_injection.dart";
import "../../../commons/config/routes.dart";
import "../../../commons/presentation/components/app_button.dart";
import "../../../commons/presentation/components/app_checkbox.dart";
import "../../../commons/presentation/components/app_tab_bar.dart";
import "../../../commons/presentation/components/app_text_field.dart";
import "../../../commons/utils/cache/app_cache.dart";
import "../../../commons/utils/helpers/toast_helper.dart";
import "../../../commons/utils/resources/app_colors.dart";
import "../../../commons/utils/resources/app_images.dart";
import "../../../commons/utils/states/base_state.dart";
import "../../../commons/utils/validators/app_input_validator.dart";
import "../blocs/sign_in_bloc.dart";
import "../blocs/sign_up_bloc.dart";

part "forms/sign_in_form.dart";
part "forms/sign_up_form.dart";

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const tabBarHeight = 56.0;
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      top: size.height * 0.1,
                      right: -(size.width * 0.35),
                      child: Image.asset(
                        AppImages.nortusImage,
                        fit: BoxFit.contain,
                        color: AppColors.border,
                        opacity: const AlwaysStoppedAnimation(0.8),
                        width: 500,
                        height: 500,
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.12,
                      left: 24,
                      child: SvgPicture.asset(
                        AppImages.nortus,
                        width: 140,
                        colorFilter: const ColorFilter.mode(
                          AppColors.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: SafeArea(
                        top: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: tabBarHeight / 2 + 24),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 24,
                              ),
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                              child: AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                alignment: Alignment.topCenter,
                                child: _tabController.index == 0
                                    ? const _SignInForm()
                                    : _SignUpForm(
                                        onSuccess: () =>
                                            _tabController.animateTo(0),
                                      ),
                              ),
                            ),
                            if (_tabController.index == 0) ...[
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  AppButton.text(
                                    text: "Esqueci a senha",
                                    color: AppColors.white,
                                    onPressed: () {},
                                  ),
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: AppColors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  AppButton.text(
                                    text: "Continuar sem conta",
                                    color: AppColors.white,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -(tabBarHeight / 2),
                    left: 24,
                    right: 24,
                    child: AppTabBar(
                      tabs: const ["Acessar conta", "Não tenho conta"],
                      controller: _tabController,
                      backgroundColor: AppColors.white,
                    ).animate(target: 1).fadeIn(duration: 400.ms),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
