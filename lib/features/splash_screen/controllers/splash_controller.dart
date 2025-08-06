import 'package:flutter/material.dart';
import 'dart:async';

class SplashController {
  void startSplashTimer(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }
}
