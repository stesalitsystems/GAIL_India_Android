import 'package:flutter/material.dart';
import 'package:gail_india/features/role_driver/driver_dashboard/screens/driver_dashboard.dart';

class DriverController {
  void login(BuildContext context, String email, String password) {
    // Always navigate to dashboard with any input
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DriverDashboardScreen()),
    );
  }
}
