import 'package:capsule_care/core/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(color: MyColors.myBlue, centerTitle: true),
  bottomNavigationBarTheme:
      BottomNavigationBarThemeData(selectedItemColor: MyColors.myBlue),
  colorScheme: const ColorScheme.light(
    background: MyColors.myGrey,
    primary: MyColors.myBlue,
    secondary: MyColors.myLightBlue,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 36.sp,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(fontSize: 16.sp),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(color: MyColors.myLightBlue, centerTitle: true),
  scaffoldBackgroundColor: Colors.black54,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black54, selectedItemColor: MyColors.myLightBlue),
  colorScheme: const ColorScheme.dark(
    background: Colors.black,
    primary: MyColors.myLightBlue,
    secondary: MyColors.myBlue,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 36.sp,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(fontSize: 16.sp),
  ),
);
