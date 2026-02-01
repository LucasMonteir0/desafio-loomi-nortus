import "package:flutter/material.dart";

import "../../utils/resources/app_colors.dart";

class AppCheckbox extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool>? onChanged;
  final String? label;

  const AppCheckbox({
    super.key,
    this.initialValue = false,
    this.onChanged,
    this.label,
  });

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  void _handleChange(bool? newValue) {
    if (newValue != null) {
      setState(() {
        _value = newValue;
      });
      widget.onChanged?.call(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: _value,
            onChanged: _handleChange,
            activeColor: AppColors.primary,
            checkColor: AppColors.white,
            side: const BorderSide(color: AppColors.borderInactive, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        if (widget.label != null) ...[
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => _handleChange(!_value),
            child: Text(
              widget.label!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
