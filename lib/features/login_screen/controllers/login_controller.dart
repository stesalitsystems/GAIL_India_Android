// lib/features/Auth/login_screen/controllers/login_controller.dart
import 'package:flutter/material.dart';

class LoginController {
  final email = TextEditingController();
  final password = TextEditingController();

  void dispose() {
    email.dispose();
    password.dispose();
  }
}
