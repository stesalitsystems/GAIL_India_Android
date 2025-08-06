import 'package:flutter/material.dart';
import 'package:gail_india/features/Auth/login_screen/screens/login_screen.dart';
import 'package:gail_india/features/role_driver/trip_history/screens/trip_history_screen.dart';
import 'package:gail_india/features/role_driver/trip_schedules/screens/trip_schedules.dart';
import '../../features/splash_screen/screens/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String tripHistory = '/tripHistory';
  static const String tripSchedules = '/tripSchedules';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case tripHistory:
        return MaterialPageRoute(builder: (_) => const TripHistory());
      case tripSchedules:
        return MaterialPageRoute(builder: (_) => const TripSchedules());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
