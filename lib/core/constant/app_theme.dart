import 'package:ecommerce_private_app/core/constant/app_color.dart';
import 'package:flutter/material.dart';

ThemeData englishTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
        fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
    backgroundColor: AppColor.primaryColor,
    centerTitle: true,
  ),
  fontFamily: "PlayfairDisplay",
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 26, color: AppColor.black),
    displayMedium: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20, color: AppColor.black),
    bodyMedium: TextStyle(
      height: 2,
      color: AppColor.grey,
      fontSize: 15,
    ),
  ),
  primarySwatch: Colors.blue,
);

ThemeData arabicTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
        fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
    backgroundColor: AppColor.primaryColor,
    centerTitle: true,
  ),
  fontFamily: "Cairo",
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 26, color: AppColor.black),
    displayMedium: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20, color: AppColor.black),
    bodyMedium: TextStyle(
      height: 2,
      color: AppColor.grey,
      fontSize: 15,
    ),
  ),
  primarySwatch: Colors.blue,
);
