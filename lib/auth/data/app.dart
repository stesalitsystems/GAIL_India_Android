// lib/app/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gail_india/common/router/router.dart';
import 'package:gail_india/utils/theme/Theme.dart';

class AppRoot extends ConsumerWidget {
  const AppRoot({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: MaterialApp.router(
        title: 'Gail India',
        themeMode: ThemeMode.light,
        theme: GAppTheme.lightTheme,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
