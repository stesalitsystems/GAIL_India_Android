import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gail_india/app/router.dart';
import 'package:gail_india/utils/theme/Theme.dart';
import 'package:gail_india/auth/state/auth_controller.dart';
import 'package:go_router/go_router.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    // Create the router ONCE.
    final auth = context.read<AuthController>();
    _router = buildRouter(auth);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: MaterialApp.router(
        title: 'Gail India',
        themeMode: ThemeMode.light,
        theme: GAppTheme.lightTheme,
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
