// widgets/app_scaffold.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gail_india/utils/constants/menu_config.dart';
import 'package:go_router/go_router.dart';
import 'package:gail_india/auth/state/auth_controller.dart';

class AppScaffold extends ConsumerWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(authControllerProvider).userRole;
    final items = menuByRole[role] ?? [];
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: actions),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('FMS')),
            for (final m in items)
              ListTile(title: Text(m.label), onTap: () => context.go(m.path)),
          ],
        ),
      ),
      body: body,
    );
  }
}
