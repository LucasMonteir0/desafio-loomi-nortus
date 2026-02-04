part of "../auth_view.dart";

class _SignUpForm extends StatefulWidget {
  const _SignUpForm({required this.onSuccess});

  final VoidCallback onSuccess;

  @override
  State<_SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final SignUpBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<SignUpBloc>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _bloc.close();
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
            labelText: "Digite seu E-mail",
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: AppInputValidator.email,
          ),
          const SizedBox(height: 16),
          AppTextField(
            labelText: "Digite a senha",
            controller: _passwordController,
            obscureText: true,
            textInputAction: TextInputAction.next,
            validator: AppInputValidator.password,
          ),
          const SizedBox(height: 16),
          AppTextField(
            labelText: "Confirme a senha",
            controller: _confirmPasswordController,
            obscureText: true,
            textInputAction: TextInputAction.done,
            validator: AppInputValidator.confirmPassword(
              () => _passwordController.text,
            ),
          ),
          const SizedBox(height: 24),
          BlocConsumer<SignUpBloc, BaseState>(
            bloc: _bloc,
            listener: (context, state) {
              if (state.isSuccess) {
                ToastHelper.showSuccess(
                  context,
                  "Cadastro realizado com sucesso",
                );
                _emailController.clear();
                _passwordController.clear();
                _confirmPasswordController.clear();
                widget.onSuccess();
              }
              if (state is ErrorState) {
                ToastHelper.showError(context, state.error.message);
              }
            },
            builder: (context, state) {
              return AppButton.primary(
                text: "Criar conta",
                isLoading: state.isLoading,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _bloc.call(_emailController.text, _passwordController.text);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
