import 'package:flutter/material.dart';

dynamic token = '';

class ColorManager {
  static const primaryLightColor = Colors.white;
  static const secendLightColor = Color(0xFFFAB94F);

  static const primaryDarkColor = Color(0xFF1C1C1C);
  static const secendDarkColor = Color(0xFF788CDE);
}

class ThemeManager {
  static lightTheme() => ThemeData(
        primarySwatch: Colors.amber,
        bottomSheetTheme: BottomSheetThemeData(
            // backgroundColor: ColorManager.secendLightColor,
            ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: ColorManager.secendLightColor),
        scaffoldBackgroundColor: ColorManager.primaryLightColor,
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStatePropertyAll(ColorManager.secendLightColor),
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: ColorManager.secendLightColor,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: ColorManager.secendLightColor,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorManager.secendLightColor,
          unselectedItemColor: Colors.grey,
          elevation: 20.0,
          backgroundColor: ColorManager.primaryLightColor,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      );

  static darkTheme() => ThemeData(
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: ColorManager.secendDarkColor),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: ColorManager.secendDarkColor),
        scaffoldBackgroundColor: ColorManager.primaryDarkColor,
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStatePropertyAll(ColorManager.secendDarkColor),
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: ColorManager.secendDarkColor,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: ColorManager.secendDarkColor,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorManager.secendDarkColor,
          unselectedItemColor: Colors.grey,
          elevation: 20.0,
          backgroundColor: ColorManager.primaryDarkColor,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      );
}
