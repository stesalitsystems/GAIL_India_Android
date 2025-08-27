// lib/auth/presentation/login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gail_india/auth/state/auth_controller.dart';

class LoginPage1 extends ConsumerStatefulWidget {
  const LoginPage1({super.key});
  @override
  ConsumerState<LoginPage1> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage1> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () async {
                      setState(() => loading = true);
                      try {
                        await ref
                            .read(authControllerProvider.notifier)
                            .login(email.text, password.text);
                      } finally {
                        if (mounted) setState(() => loading = false);
                      }
                    },
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text('Sign in'),
            ),
          ],
        ),
      ),
    );
  }
}
