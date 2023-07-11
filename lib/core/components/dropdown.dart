import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

Widget defaultDropDown({
  required context,
  required String hint,
  required List items,
  required String validationText,
  required void Function(Object?)? onChanged,
}) =>
    DropdownButtonFormField2(
      isExpanded: true,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.priority_high_rounded),
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          )),
      hint: FittedBox(
        child: Text(
          hint,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      items: items
          .map((e) => DropdownMenuItem(
                value: e,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(e),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return validationText;
        }
        return null;
      },
      onChanged: onChanged,
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 0),
      ),
    );
