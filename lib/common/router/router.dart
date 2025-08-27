// lib/app/router.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gail_india/auth/data/router_refresh_stream.dart';
import 'package:gail_india/core/model/role.dart';
import 'package:gail_india/dashboard/presentation/dash_dbs_admin.dart';
import 'package:gail_india/dashboard/presentation/dash_driver.dart';
import 'package:gail_india/dashboard/presentation/dash_ga_incharge.dart';
import 'package:gail_india/dashboard/presentation/dash_ms_admin.dart';
import 'package:gail_india/dashboard/presentation/dash_super_admin.dart';
import 'package:gail_india/features/create_account/screens/create_account_screen.dart';
import 'package:gail_india/features/login_screen/screens/login.dart';
import 'package:gail_india/features/login_screen/screens/login_screen.dart';
import 'package:gail_india/features/reset_password/screens/reset_password_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:gail_india/auth/state/auth_controller.dart';
import 'package:gail_india/features/splash_screen/screens/splash_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // final refreshListenable = GoRouterRefreshStream(
  //   ref.read(authControllerProvider.notifier).stream,
  // );

  return GoRouter(
    initialLocation: '/splash',
    // refreshListenable: refreshListenable,
    // redirect: (context, state) {
    //   final auth = ref.read(authControllerProvider);
    //   final loc = state.uri.toString(); // use uri instead of location

    //   if (auth.loading && loc != '/splash') return '/splash';
    //   if (!auth.isLoggedIn && loc != '/login' && loc != '/splash') {
    //     return '/login';
    //   }
    //   if (auth.isLoggedIn && (loc == '/login' || loc == '/splash')) {
    //     switch (auth.userRole) {
    //       case UserRole.superAdmin:
    //         return '/dash/superadmin';
    //       case UserRole.gaIncharge:
    //         return '/dash/ga';
    //       case UserRole.msAdmin:
    //         return '/dash/ms';
    //       case UserRole.dbsAdmin:
    //         return '/dash/dbs';
    //       case UserRole.driver:
    //         return '/dash/driver';
    //     }
    //   }
    //   return null;
    // },
    routes: [
      GoRoute(path: '/', redirect: (_, __) => '/splash'),
      GoRoute(path: '/splash', builder: (_, __) => const SplashGate()),
      GoRoute(path: '/login', builder: (_, __) => LoginPage()),
      GoRoute(path: '/login1', builder: (_, __) => const LoginPage1()),
      GoRoute(path: '/reset_password', builder: (_, __) => ForgotPassword()),
      GoRoute(path: '/create_account', builder: (_, __) => CreateAccount()),
      GoRoute(path: '/superadmin', builder: (_, __) => const DashSuperAdmin()),
      GoRoute(path: '/dash/ga', builder: (_, __) => const DashGaIncharge()),
      GoRoute(path: '/dash/ms', builder: (_, __) => const DashMsAdmin()),
      GoRoute(path: '/dash/dbs', builder: (_, __) => const DashDbsAdmin()),
      GoRoute(path: '/dash/driver', builder: (_, __) => const DashDriver()),
    ],
  );
});
