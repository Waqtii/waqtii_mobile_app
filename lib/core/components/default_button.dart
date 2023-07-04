import 'package:flutter/material.dart';
import 'package:waqtii/constants.dart';

Widget DefaultButton({
  bool border = false,
  String text = 'Log In',
  double width = double.infinity,
  double radius = 50,
  Color color = defaultColorLight,
  Color colorText = Colors.white,
  required Function() onPressed,
}) =>
    Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
          border: border ? Border.all() : null,
          color: color,
          borderRadius: BorderRadius.circular(radius)),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: colorText,
          ),
        ),
      ),
    );
