// lib/common/widgets/drop_down2.dart
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:gail_india/utils/constants/colors.dart';

class AppDropdown2 extends StatelessWidget {
  const AppDropdown2({
    super.key,
    required this.items,
    required this.hintText,
    this.value,
    this.onChanged,
    this.onSaved,
    this.validator,
  });

  final List<String> items;
  final String hintText;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      value: value?.isEmpty == true ? null : value,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: GColors.borderSecondary),
        ),
      ),
      hint: Text(hintText, style: const TextStyle(fontSize: 14)),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                // Presentation label: customize as needed
                (item == 'dbs_supervisor')
                    ? 'DBS Supervisor'
                    : _titleCase(item),
                style: const TextStyle(fontSize: 14),
              ),
            ),
          )
          .toList(),
      validator: validator,
      onChanged: onChanged,
      onSaved: onSaved,
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(Icons.arrow_drop_down, color: Colors.black45),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: GColors.primary,
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  static String _titleCase(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}
