// lib/auth/data/auth_repository.dart
import 'package:gail_india/core/model/user.dart';
import 'package:gail_india/core/storage/secure_storage.dart';

import 'auth_api.dart';

class AuthRepository {
  AuthRepository(this.api, this.secure);
  final AuthApi api;
  final SecureStore secure;

  Future<User> login(String u, String p) async {
    final tokens = await api.login(u, p);
    await secure.saveTokens(tokens['accessToken'], tokens['refreshToken']);
    return api.me();
  }

  Future<User?> restore() async {
    final at = await secure.readAccess();
    if (at == null) return null;
    return api.me();
  }

  Future<void> saveTokens(String at, String rt) => secure.saveTokens(at, rt);
  Future<String?> readRefresh() => secure.readRefresh();
  Future<void> logout() => secure.clear();
}
