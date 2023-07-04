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
  Color suffixIconColor = const Color(0xfffab94f),
  Color prefixIconColor = const Color(0xfffab94f),
  Color labelColor = const Color(0xfffab94f),
  Color focusColor = const Color(0xfffab94f),
  Color focusedBorderColor = const Color(0xfffab94f),
}) =>
    TextFormField(
      obscureText: isPassword,
      validator: validate,
      controller: controller,
      onFieldSubmitted: submit,
      onChanged: onChange,
      keyboardType: type,
      decoration: InputDecoration(
        suffixIconColor: suffixIconColor,
        labelStyle: TextStyle(color: labelColor),
        focusColor: focusColor,
        prefixIconColor: prefixIconColor,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedBorderColor)),
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
