import 'package:flutter/material.dart';
import 'package:gail_india/features/Map/map.dart';
import 'package:gail_india/features/auth/create_account_screen.dart';
import 'package:gail_india/features/auth/reset_password_screen.dart';
import 'package:gail_india/features/dashboard/Dashboard.dart';
import 'package:gail_india/features/auth/login_screen.dart';
import 'package:gail_india/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:gail_india/auth/state/auth_controller.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter buildRouter(AuthController auth) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    refreshListenable: auth,
    debugLogDiagnostics: true,
    // redirect: (context, state) {
    //   final loc = state.uri.toString();
    //   if (auth.loading && loc != '/splash') return '/splash';
    //   if (!auth.isLoggedIn && loc != '/login' && loc != '/splash')
    //     return '/login';
    //   if (auth.isLoggedIn && (loc == '/login' || loc == '/splash'))
    //     return '/dash';
    //   return null;
    // },
    redirect: (context, state) {
      // Use subloc so we ignore query params and fragments
      final loc = state.matchedLocation;
      final isAuth = auth.isLoggedIn;

      // Public routes that don't require auth:
      const publicRoutes = {
        '/splash',
        '/login',
        '/create_account',
        '/reset_password',
      };

      // If NOT logged in, only allow public routes
      if (!isAuth && !publicRoutes.contains(loc)) {
        return '/login';
      }

      // If logged in, keep them out of public auth pages
      if (isAuth && publicRoutes.contains(loc)) {
        return '/dash';
      }

      return null;
    },

    routes: [
      GoRoute(path: '/', redirect: (_, __) => '/splash'),
      GoRoute(path: '/splash', builder: (_, __) => const SplashGate()),
      GoRoute(path: '/login', builder: (_, __) => LoginPage()),
      // Single role-aware dashboard shell
      GoRoute(path: '/dash', builder: (_, __) => const DashboardPage()),
      GoRoute(path: '/create_account', builder: (_, __) => CreateAccount()),
      GoRoute(path: '/reset_password', builder: (_, __) => ForgotPassword()),
      GoRoute(path: '/map', builder: (_, __) => MapScreen()),
      GoRoute(
        path: '/areas',
        builder: (_, __) => const _Placeholder('Geographical Areas'),
      ),
      GoRoute(
        path: '/mother-stations',
        builder: (_, __) => const _Placeholder('Mother Stations'),
      ),
      GoRoute(
        path: '/daughter-booster-stations',
        builder: (_, __) => const _Placeholder('Daughter Booster Stations'),
      ),
      GoRoute(
        path: '/routes',
        builder: (_, __) => const _Placeholder('Route Management'),
      ),
      GoRoute(
        path: '/lcv',
        builder: (_, __) => const _Placeholder('LCV Management'),
      ),
      GoRoute(
        path: '/dbs-stock-status',
        builder: (_, __) => const _Placeholder('DBS Stock Status'),
      ),
      GoRoute(
        path: '/lcv-schedules',
        builder: (_, __) => const _Placeholder('LCV Schedules'),
      ),
      GoRoute(
        path: '/lcv-trip-status',
        builder: (_, __) => const _Placeholder('LCV Trip Status'),
      ),
      GoRoute(
        path: '/dry-out-history',
        builder: (_, __) => const _Placeholder('Dry-Out History'),
      ),
      GoRoute(
        path: '/ms-wise-lcv-queue',
        builder: (_, __) => const _Placeholder('MS Wise LCV Queue'),
      ),
      GoRoute(
        path: '/sales-history',
        builder: (_, __) => const _Placeholder('Sales History'),
      ),
      GoRoute(
        path: '/settings',
        builder: (_, __) => const _Placeholder('Settings'),
      ),
      GoRoute(
        path: '/analytics',
        builder: (_, __) => const _Placeholder('Analytics'),
      ),
      GoRoute(
        path: '/users',
        builder: (_, __) => const _Placeholder('User Management'),
      ),
      GoRoute(
        path: '/superadmin',
        redirect: (_, __) => '/dash',
      ), // legacy: go to /dash
    ],
  );
}

// Simple holder for screens you’ll build later (keeps nav working)
class _Placeholder extends StatelessWidget {
  final String title;
  const _Placeholder(this.title, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text('Build "$title" here (role-aware by ActiveContext).'),
      ),
    );
  }
}
