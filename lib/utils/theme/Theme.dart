import 'package:flutter/material.dart';
import 'package:gail_india/utils/theme/custom_themes/appbar_theme.dart';
import 'package:gail_india/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:gail_india/utils/theme/custom_themes/chip_theme.dart';
import 'package:gail_india/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:gail_india/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:gail_india/utils/theme/custom_themes/text_theme.dart';
import 'package:gail_india/utils/theme/custom_themes/textfield_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class GAppTheme {
  GAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Color(0xFFffd94f),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: GoogleFonts.openSans().fontFamily,
    textTheme: GoogleFonts.openSansTextTheme(GTextTheme.lightTextTheme),
    appBarTheme: GAppbarTheme.lightAppBarTheme,
    chipTheme: GChipTheme.lightChipTheme,
    bottomSheetTheme: GBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: GElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: GTextFormFieldTheme.lightInputDecorationTheme,
    outlinedButtonTheme: GOutlinedButtonTheme.lightOutlinedButtonTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    fontFamily: GoogleFonts.openSans().fontFamily,
    textTheme: GoogleFonts.openSansTextTheme(GTextTheme.darkTextTheme),
    appBarTheme: GAppbarTheme.darkAppBarTheme,
    chipTheme: GChipTheme.darkChipTheme,
    bottomSheetTheme: GBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: GElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: GTextFormFieldTheme.darkInputDecorationTheme,
    outlinedButtonTheme: GOutlinedButtonTheme.darkOutlinedButtonTheme,
  );
}
