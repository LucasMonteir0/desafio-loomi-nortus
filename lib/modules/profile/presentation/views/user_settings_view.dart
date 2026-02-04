import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";

import "../../../commons/config/dependency_injection.dart";
import "../../../commons/presentation/components/app_button.dart";
import "../../../commons/presentation/components/app_footer.dart";
import "../../../commons/presentation/components/custom_app_bar.dart";
import "../../../commons/utils/extensions/string_extensions.dart";
import "../../../commons/utils/helpers/toast_helper.dart";
import "../../../commons/utils/resources/app_colors.dart";
import "../../../commons/utils/states/base_state.dart";
import "../../../commons/utils/validators/app_input_validator.dart";
import "../../core/domain/entities/address_entity.dart";
import "../../core/domain/entities/profile_entity.dart";
import "../../core/domain/entities/update_profile_entity.dart";
import "../blocs/get_profile_bloc.dart";
import "../blocs/update_profile_bloc.dart";
import "../components/profile_dropdown.dart";
import "../components/profile_section_text.dart";
import "../components/profile_text_field.dart";

class UserSettingsView extends StatefulWidget {
  final ProfileEntity profile;
  const UserSettingsView({required this.profile, super.key});

  @override
  State<UserSettingsView> createState() => _UserSettingsViewState();
}

class _UserSettingsViewState extends State<UserSettingsView> {
  late final UpdateProfileBloc _updateProfileBloc;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _zipCodeController;
  late final TextEditingController _countryController;
  late final TextEditingController _streetController;
  late final TextEditingController _numberController;
  late final TextEditingController _complementController;
  late final TextEditingController _neighborhoodController;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;

  late String _selectedLanguage;
  late String _selectedDateFormat;
  late String _selectedTimezone;

  final _formKey = GlobalKey<FormState>();

  final _languages = [
    const ProfileDropdownItem(value: "pt-BR", label: "Português - BR"),
    const ProfileDropdownItem(value: "en-US", label: "English - US"),
    const ProfileDropdownItem(value: "es-ES", label: "Español - ES"),
  ];

  final _dateFormats = [
    const ProfileDropdownItem(value: "DD/MM/AA", label: "DD/MM/AA"),
    const ProfileDropdownItem(value: "MM/DD/AA", label: "MM/DD/AA"),
    const ProfileDropdownItem(value: "AA/MM/DD", label: "AA/MM/DD"),
  ];

  final _timezones = [
    const ProfileDropdownItem(
      value: "America/Sao_Paulo",
      label: "Brasília - DF ( GMT-3 )",
    ),
    const ProfileDropdownItem(
      value: "America/New_York",
      label: "New York ( GMT-5 )",
    ),
    const ProfileDropdownItem(
      value: "Europe/London",
      label: "London ( GMT+0 )",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _updateProfileBloc = getIt<UpdateProfileBloc>();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _zipCodeController = TextEditingController();
    _countryController = TextEditingController();
    _streetController = TextEditingController();
    _numberController = TextEditingController();
    _complementController = TextEditingController();
    _neighborhoodController = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _selectedLanguage = widget.profile.language;
    _selectedDateFormat = widget.profile.dateFormat;
    _selectedTimezone = widget.profile.timezone;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _zipCodeController.dispose();
    _countryController.dispose();
    _streetController.dispose();
    _numberController.dispose();
    _complementController.dispose();
    _neighborhoodController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _updateProfileBloc.close();
    super.dispose();
  }

  void _saveSettings() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final updatedProfile = UpdateProfileEntity(
      name: _nameController.text.returnValueIfEmpty(widget.profile.name),
      email: _emailController.text.returnValueIfEmpty(widget.profile.email),
      language: _selectedLanguage,
      dateFormat: _selectedDateFormat,
      timezone: _selectedTimezone,
      address: AddressEntity(
        zipCode: _zipCodeController.text.returnValueIfEmpty(
          widget.profile.address.zipCode,
        ),
        country: _countryController.text.returnValueIfEmpty(
          widget.profile.address.country,
        ),
        street: _streetController.text.returnValueIfEmpty(
          widget.profile.address.street,
        ),
        number: _numberController.text.returnValueIfEmpty(
          widget.profile.address.number,
        ),
        complement: _complementController.text.returnValueIfEmpty(
          widget.profile.address.complement,
        ),
        neighborhood: _neighborhoodController.text.returnValueIfEmpty(
          widget.profile.address.neighborhood,
        ),
        city: _cityController.text.returnValueIfEmpty(
          widget.profile.address.city,
        ),
        state: _stateController.text.returnValueIfEmpty(
          widget.profile.address.state,
        ),
      ),
    );
    _updateProfileBloc.update(updatedProfile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(onBackPressed: context.pop),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Configurações de usuário",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const Text(
                            "Ajustes de Idioma, Fuso Horário e Data",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ProfileDropdown(
                            label: "Idioma",
                            value: _selectedLanguage,
                            items: _languages,
                            onChanged: (value) =>
                                setState(() => _selectedLanguage = value!),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                flex: 7,
                                child: ProfileDropdown(
                                  label: "Formatação de data",
                                  value: _selectedDateFormat,
                                  items: _dateFormats,
                                  onChanged: (value) => setState(
                                    () => _selectedDateFormat = value!,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 11,
                                child: ProfileDropdown(
                                  label: "Fuso horário",
                                  value: _selectedTimezone,
                                  items: _timezones,
                                  onChanged: (value) => setState(
                                    () => _selectedTimezone = value!,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            "Informações básicas",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const ProfileSectionText(text: "Dados pessoais"),
                          const SizedBox(height: 16),
                          ProfileTextField(
                            controller: _nameController,
                            hint: widget.profile.name,
                            validator: (value) => AppInputValidator.text(
                              value,
                              isRequired: false,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ProfileTextField(
                            controller: _emailController,
                            hint: widget.profile.email,
                            validator: (value) => AppInputValidator.email(
                              value,
                              isRequired: false,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 24),
                          const ProfileSectionText(text: "Endereço"),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ProfileTextField(
                                  controller: _zipCodeController,
                                  hint: widget.profile.address.zipCode,
                                  validator: (value) => AppInputValidator.cep(
                                    value,
                                    isRequired: false,
                                  ),
                                  inputFormatters: [
                                    AppInputValidator.cepMask(),
                                  ],
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ProfileTextField(
                                  controller: _countryController,
                                  hint: widget.profile.address.country,
                                  validator: (value) => AppInputValidator.text(
                                    value,
                                    isRequired: false,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ProfileTextField(
                            controller: _streetController,
                            hint: widget.profile.address.street,
                            validator: (value) => AppInputValidator.text(
                              value,
                              isRequired: false,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ProfileTextField(
                            controller: _complementController,
                            hint: widget.profile.address.complement,
                            validator: (value) => AppInputValidator.text(
                              value,
                              isRequired: false,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: ProfileTextField(
                                  controller: _numberController,
                                  hint: widget.profile.address.number,
                                  validator: (value) =>
                                      AppInputValidator.number(
                                        value,
                                        isRequired: false,
                                      ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ProfileTextField(
                                  controller: _neighborhoodController,
                                  hint: widget.profile.address.neighborhood,
                                  validator: (value) => AppInputValidator.text(
                                    value,
                                    isRequired: false,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: ProfileTextField(
                                  controller: _cityController,
                                  hint: widget.profile.address.city,
                                  validator: (value) => AppInputValidator.text(
                                    value,
                                    isRequired: false,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ProfileTextField(
                                  controller: _stateController,
                                  hint: widget.profile.address.state,
                                  validator: (value) => AppInputValidator.state(
                                    value,
                                    isRequired: false,
                                  ),
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(2),
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r"[a-zA-Z]"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: AppButton.outlined(
                                  text: "Cancelar",
                                  onPressed: () => context.pop(),
                                  height: 48,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child:
                                    BlocConsumer<UpdateProfileBloc, BaseState>(
                                      bloc: _updateProfileBloc,
                                      listener: (context, state) {
                                        if (state.isSuccess) {
                                          getIt<GetProfileBloc>().call();
                                          ToastHelper.showSuccess(
                                            context,
                                            "Perfil atualizado com sucesso!",
                                          );
                                          context.pop();
                                          return;
                                        }

                                        if (state.isError) {
                                          ToastHelper.showError(
                                            context,
                                            (state as ErrorState).error.message,
                                          );
                                          return;
                                        }
                                      },
                                      builder: (context, state) {
                                        return AppButton.primary(
                                          text: "Salvar",
                                          isLoading: state.isLoading,
                                          onPressed: _saveSettings,
                                          radius: 100,
                                          height: 48,
                                        );
                                      },
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 64),
                    const AppFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
