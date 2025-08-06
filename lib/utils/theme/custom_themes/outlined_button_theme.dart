import 'package:flutter/material.dart';

class GOutlinedButtonTheme {
  GOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black, // Text color for light theme
      side: const BorderSide(
        color: Colors.blue,
      ), // Border color for light theme
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600, // Bold text
        color: Colors.black,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 20, // Padding
      ),
    ),
  );
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white, // Text color for light theme
      side: const BorderSide(
        color: Colors.blueAccent,
      ), // Border color for light theme
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600, // Bold text
        color: Colors.white,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16, // Padding
      ),
    ),
  );
}
