import 'package:flutter/material.dart';

class GElevatedButtonTheme {
  GElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: Colors.black, // Primary color for light theme
      foregroundColor: Colors.white, // Text color for light theme
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey,
      side: const BorderSide(
        color: Color.fromARGB(255, 0, 0, 0), // No border for light theme
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(vertical: 18), // Padding
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600, // Bold text
        color: Colors.white,
      ),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: Colors.blue, // Primary color for dark theme
      foregroundColor: Colors.white, // Text color for dark theme
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey,
      side: const BorderSide(
        color: Colors.blue, // No border for dark theme
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(vertical: 18), // Padding
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600, // Bold text
        color: Colors.white,
      ),
    ),
  );
}
