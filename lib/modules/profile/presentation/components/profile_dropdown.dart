import "package:dropdown_button2/dropdown_button2.dart";
import "package:flutter/material.dart";

import "../../../commons/utils/resources/app_colors.dart";
import "profile_section_text.dart";

class ProfileDropdownItem {
  final String value;
  final String label;

  const ProfileDropdownItem({required this.value, required this.label});
}

class ProfileDropdown extends StatelessWidget {
  const ProfileDropdown({
    required this.items,
    required this.value,
    required this.label,
    required this.onChanged,
    super.key,
  });

  final List<ProfileDropdownItem> items;
  final String value;
  final String label;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileSectionText(text: label),
        const SizedBox(height: 12),
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            value: value,
            isExpanded: true,
            onChanged: onChanged,
            items: items
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item.value,
                    child: Text(
                      item.label,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                )
                .toList(),
            buttonStyleData: ButtonStyleData(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondary),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(Icons.keyboard_arrow_down),
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
