// lib/main.dart
import 'package:flutter/material.dart';
import 'package:gail_india/app/app.dart';
import 'package:gail_india/auth/state/auth_controller.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider<AuthController>(
      create: (_) => AuthController()..bootstrap(),
      child: const AppRoot(),
    ),
  );
}
