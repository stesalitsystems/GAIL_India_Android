import 'package:flutter/material.dart';

class GBottomSheetTheme {
  GBottomSheetTheme._();

  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.white, // Background color for light theme
    modalBackgroundColor:
        Colors.white, // Modal background color for light theme
    constraints: const BoxConstraints(
      minWidth: double.infinity, // Maximum height for the bottom sheet
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );

  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.black, // Background color for light theme
    modalBackgroundColor:
        Colors.black, // Modal background color for light theme
    constraints: const BoxConstraints(
      minWidth: double.infinity, // Maximum height for the bottom sheet
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}
