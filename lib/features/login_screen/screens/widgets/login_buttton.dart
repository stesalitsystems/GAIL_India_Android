// lib/features/Auth/login_screen/widgets/login_button.dart
import 'package:flutter/material.dart';
import 'package:gail_india/features/login_screen/controllers/login_controller.dart';
import 'package:gail_india/features/role_driver/driver_dashboard/controllers/driver_controller.dart';

import 'package:gail_india/utils/constants/colors.dart';

class LoginButton extends StatelessWidget {
  final LoginController loginController;
  final DriverController controller;

  const LoginButton({
    super.key,
    required this.loginController,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => controller.login(
          context,
          loginController.email.text,
          loginController.password.text,
        ),
        style: ElevatedButton.styleFrom(backgroundColor: GColors.buttonPrimary),
        child: const Text('Login', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
