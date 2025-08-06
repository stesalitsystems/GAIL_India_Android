import 'package:flutter/material.dart';
import 'package:gail_india/utils/theme/custom_themes/appbar_theme.dart';
import 'package:gail_india/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:gail_india/utils/theme/custom_themes/chip_theme.dart';
import 'package:gail_india/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:gail_india/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:gail_india/utils/theme/custom_themes/text_theme.dart';
import 'package:gail_india/utils/theme/custom_themes/textfield_theme.dart';

class GAppTheme {
  GAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Color(0xFFffd94f), // Example primary color
    scaffoldBackgroundColor: Colors.white,
    textTheme: GTextTheme.lightTextTheme,
    appBarTheme: GAppbarTheme.lightAppBarTheme,
    chipTheme: GChipTheme.lightChipTheme,
    bottomSheetTheme: GBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: GElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: GTextFormFieldTheme.lightInputDecorationTheme,
    outlinedButtonTheme: GOutlinedButtonTheme.lightOutlinedButtonTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: GTextTheme.darkTextTheme,
    appBarTheme: GAppbarTheme.darkAppBarTheme,
    chipTheme: GChipTheme.darkChipTheme,
    bottomSheetTheme: GBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: GElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: GTextFormFieldTheme.darkInputDecorationTheme,
    outlinedButtonTheme: GOutlinedButtonTheme.darkOutlinedButtonTheme,
  );
}
