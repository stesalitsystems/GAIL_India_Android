// lib/auth/state/auth_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gail_india/auth/state/auth_state.dart';
import 'package:gail_india/core/provider/di.dart';
import '../data/auth_repository.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    return AuthController(ref);
  },
);

class AuthController extends StateNotifier<AuthState> {
  AuthController(this.ref) : super(const AuthState.loading()) {
    bootstrap();
  }
  final Ref ref;

  Future<void> bootstrap() async {
    try {
      final repo = ref.read(authRepositoryProvider);
      final user = await repo.restore();
      state = user == null
          ? const AuthState.loggedOut()
          : AuthState.loggedIn(user);
    } catch (_) {
      state = const AuthState.loggedOut();
    }
  }

  Future<void> login(String u, String p) async {
    final repo = ref.read(authRepositoryProvider);
    final user = await repo.login(u, p);
    state = AuthState.loggedIn(user);
  }

  Future<void> refreshToken() async {
    final repo = ref.read(authRepositoryProvider);
    final rt = await repo.readRefresh();
    if (rt == null) throw Exception('No refresh token');
    final tokens = await ref.read(authApiProvider).refresh(rt);
    await repo.saveTokens(tokens['accessToken'], tokens['refreshToken']);
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AuthState.loggedOut();
  }
}
