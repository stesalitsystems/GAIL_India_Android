import 'package:flutter/material.dart';

class GColors {
  GColors._();

  //App Basic Colors
  static const Color primary = Color(0xFFffda4e);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color accent = Color(0xFFBB86FC);

  //Gradient Colors
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [Color(0xFF6200EE), Color(0xFF03DAC6), Color(0xFFBB86FC)],
  );

  //Text Colors
  static const Color primaryText = Color(0xFF000000);
  static const Color secondaryText = Color(0xFF757575);
  static const Color whiteText = Color.fromARGB(255, 255, 255, 255);
  static const Color yellowText = Color(0xFFffd94f);

  //background Colors
  static const Color light = Color.fromARGB(255, 255, 255, 255);
  static const Color dark = Color.fromARGB(255, 0, 0, 0);
  static const Color primaryBackground = Color.fromARGB(255, 0, 0, 0);

  //Background container
  static const Color lightContainer = Color.fromARGB(255, 245, 245, 245);
  static const Color darkContainer = Color.fromARGB(255, 33, 33, 33);

  //Button Colors
  static const Color buttonPrimary = Color.fromARGB(255, 0, 0, 0);
  static const Color buttonSecondary = Colors.white;
  static const Color buttonDisabled = Color.fromARGB(255, 90, 90, 90);

  //Border Colors
  static const Color borderPrimary = Color.fromARGB(255, 0, 0, 0);
  static const Color borderSecondary = Color(0xFFBDBDBD);

  //Error and Validation Colors
  static const Color error = Color(0xFFB00020);
  static const Color success = Color(0xFF00C853);
  static const Color warning = Color(0xFFFFA000);
  static const Color info = Color(0xFF2196F3);

  //Neutral Colors
  static const Color black = Color(0xFF000000);
  static const Color darkGrey = Color(0xFF212121);
  static const Color darkerGrey = Color(0xFF424242);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color lightGrey = Color(0xFFBDBDBD);
  static const Color softGrey = Color(0xFFF5F5F5);
  static const Color white = Color(0xFFFFFFFF);
}
