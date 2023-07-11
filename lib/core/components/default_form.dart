import 'package:flutter/material.dart';

Widget defaultForm({
  required controller,
  required TextInputType type,
  required String label,
  required IconData preIcon,
  IconData? suffix,
  required String? Function(String?) validate,
  String? Function(String?)? submit,
  String? Function(String?)? onChange,
  Function()? suffixPressed,
  bool isPassword = false,
}) =>
    TextFormField(
      obscureText: isPassword,
      validator: validate,
      controller: controller,
      onFieldSubmitted: submit,
      onChanged: onChange,
      keyboardType: type,
      decoration: InputDecoration(
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPressed,
              )
            : null,
        prefixIcon: Icon(preIcon),
        labelText: label,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
