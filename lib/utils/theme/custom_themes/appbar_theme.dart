import 'package:flutter/material.dart';
import 'package:gail_india/utils/constants/colors.dart';

class GAppbarTheme {
  GAppbarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: GColors.primary, // Background color for light theme
    surfaceTintColor: Colors.transparent, // Text color for light theme
    elevation: 0, // No shadow for light theme
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 24,
    ), // Icon color for light theme
    actionsIconTheme: IconThemeData(
      color: Colors.black,
      size: 24,
    ), // Action icon color for light theme
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black, // Title text color for light theme
    ),
  );

  static const darkAppBarTheme = AppBarTheme(
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent, // Background color for light theme
    surfaceTintColor: Colors.transparent, // Text color for light theme
    elevation: 0, // No shadow for light theme
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 24,
    ), // Icon color for light theme
    actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white, // Title text color for light theme
    ),
  );
}
