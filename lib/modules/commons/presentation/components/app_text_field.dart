import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "../../utils/resources/app_colors.dart";

class AppTextField extends StatefulWidget {
  const AppTextField({
    required this.labelText,
    super.key,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.enabled = true,
    this.autofocus = false,
    this.maxLines = 1,
    this.inputFormatters,
    this.focusNode,
    this.errorText,
  });

  final String labelText;
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool enabled;
  final bool autofocus;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final String? errorText;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _isObscured;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.removeListener(_handleFocusChange);
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: widget.controller?.text ?? "",
      validator: widget.validator,
      builder: (FormFieldState<String> field) {
        final hasError =
            field.hasError ||
            (widget.errorText != null && widget.errorText!.isNotEmpty);
        final errorMessage = field.errorText ?? widget.errorText;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _TextFieldContainer(
              isFocused: _isFocused,
              hasError: hasError,
              child: TextField(
                controller: widget.controller,
                focusNode: _focusNode,
                obscureText: _isObscured,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                onChanged: (value) {
                  field.didChange(value);
                  widget.onChanged?.call(value);
                },
                onSubmitted: widget.onSubmitted,
                enabled: widget.enabled,
                autofocus: widget.autofocus,
                maxLines: widget.maxLines,
                inputFormatters: widget.inputFormatters,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  labelText: widget.labelText,
                  hintText: widget.hintText,
                  labelStyle: TextStyle(
                    fontSize: 16,
                    color: hasError
                        ? AppColors.error
                        : _isFocused
                        ? AppColors.primary
                        : AppColors.textHint,
                    fontWeight: FontWeight.w400,
                  ),
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textPlaceholder,
                    fontWeight: FontWeight.w400,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  border: InputBorder.none,
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.obscureText
                      ? _PasswordToggleButton(
                          isObscured: _isObscured,
                          onToggle: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        )
                      : widget.suffixIcon,
                ),
              ),
            ),
            if (hasError && errorMessage != null)
              _ErrorText(errorText: errorMessage),
          ],
        );
      },
    );
  }
}

class _TextFieldContainer extends StatelessWidget {
  const _TextFieldContainer({
    required this.isFocused,
    required this.hasError,
    required this.child,
  });

  final bool isFocused;
  final bool hasError;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final borderColor = hasError
        ? AppColors.error
        : isFocused
        ? AppColors.primary
        : AppColors.textFieldBorder;

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: isFocused ? 2 : 1),
      ),
      child: child,
    );
  }
}

class _PasswordToggleButton extends StatelessWidget {
  const _PasswordToggleButton({
    required this.isObscured,
    required this.onToggle,
  });

  final bool isObscured;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        color: AppColors.textHint,
        size: 24,
      ),
      onPressed: onToggle,
    );
  }
}

class _ErrorText extends StatelessWidget {
  const _ErrorText({required this.errorText});

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16),
      child: Text(
        errorText,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.error,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
