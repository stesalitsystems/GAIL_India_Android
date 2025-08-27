// lib/core/storage/secure_store.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStore {
  final _s = const FlutterSecureStorage();
  Future<void> saveTokens(String at, String rt) async {
    await _s.write(key: 'access', value: at);
    await _s.write(key: 'refresh', value: rt);
  }

  Future<String?> readAccess() => _s.read(key: 'access');
  Future<String?> readRefresh() => _s.read(key: 'refresh');
  Future<void> clear() async => _s.deleteAll();

  Future<void> saveUserRole(id) async {}
}
