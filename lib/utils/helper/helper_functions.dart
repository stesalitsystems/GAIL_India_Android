import 'package:flutter/material.dart';
import 'package:gail_india/utils/constants/colors.dart';
import 'package:gail_india/utils/constants/sizes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart' as ltlng;

class GHelperFunctions {
  // Function to check if a string is empty or null
  static bool isStringEmpty(String? str) {
    return str == null || str.isEmpty;
  }

  // Function to check if a list is empty or null
  static bool isListEmpty(List? list) {
    return list == null || list.isEmpty;
  }

  // Function to check if a map is empty or null
  static bool isMapEmpty(Map? map) {
    return map == null || map.isEmpty;
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static double getScreenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static double getScreenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static InputDecoration customInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Gsizes.inputFieldRadius),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Gsizes.inputFieldRadius),
        ),
        borderSide: BorderSide(color: GColors.buttonDisabled, width: 2.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Gsizes.inputFieldRadius),
        ),
        borderSide: BorderSide(color: GColors.buttonPrimary, width: 2.0),
      ),
    );
  }

  static Future<ltlng.LatLng?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    // Request permission if not granted
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return ltlng.LatLng(position.latitude, position.longitude);
  }
}
