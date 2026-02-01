part of "../auth_view.dart";

class _SignInForm extends StatefulWidget {
  const _SignInForm();

  @override
  State<_SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  late final TextEditingController _loginController;
  late final TextEditingController _passwordController;
  late final SignInBloc _bloc;
  final _formKey = GlobalKey<FormState>();

  late final ValueNotifier<bool> _showPasswordInput;
  bool? _rememberUser;

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
    _bloc = getIt<SignInBloc>();
    _showPasswordInput = ValueNotifier<bool>(false);

    _loginController.addListener(() {
      _showPasswordInput.value = _loginController.text.isNotEmpty;
    });
  }

  void _handleBloc() {
    if (_formKey.currentState!.validate()) {
      _bloc.call(
        login: _loginController.text,
        password: _passwordController.text,
        rememberUser: _rememberUser ?? false,
      );
    }
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _bloc.close();
    _showPasswordInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField(
            labelText: "Digite seu login",
            controller: _loginController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: AppInputValidator.empty,
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: ValueListenableBuilder(
              valueListenable: _showPasswordInput,
              builder: (context, showPassword, child) {
                if (!showPassword) {
                  return const SizedBox.shrink();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    AppTextField(
                          labelText: "Digite a senha",
                          controller: _passwordController,
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          validator: AppInputValidator.empty,
                          onSubmitted: (_) => _handleBloc(),
                        )
                        .animate()
                        .fadeIn(duration: 300.ms)
                        .slideY(begin: -0.2, end: 0, duration: 300.ms),
                    const SizedBox(height: 16),
                    AppCheckbox(
                          label: "Mantenha-me conectado",
                          onChanged: (value) {
                            _rememberUser = value;
                            AppCache.instance.setRememberUser(value);
                          },
                        )
                        .animate()
                        .fadeIn(duration: 300.ms, delay: 100.ms)
                        .slideY(
                          begin: -0.2,
                          end: 0,
                          duration: 300.ms,
                          delay: 100.ms,
                        ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          BlocConsumer<SignInBloc, BaseState>(
                bloc: _bloc,
                listener: (context, state) {
                  if (state.isSuccess) {
                    ToastHelper.showSuccess(
                      context,
                      "Login realizado com sucesso",
                    );
                    context.replace(Routes.home);
                  }
                  if (state is ErrorState) {
                    ToastHelper.showError(context, state.error.message);
                  }
                },
                builder: (context, state) {
                  return AppButton.primary(
                    text: "Entrar",
                    onPressed: _handleBloc,
                    isLoading: state.isLoading,
                  );
                },
              )
              .animate()
              .fadeIn(duration: 300.ms, delay: 200.ms)
              .slideY(begin: -0.2, end: 0, duration: 300.ms, delay: 200.ms),
        ],
      ),
    );
  }
}
