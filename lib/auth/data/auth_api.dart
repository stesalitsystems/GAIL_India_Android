// lib/auth/data/auth_api.dart
import 'package:dio/dio.dart';
import 'package:gail_india/core/model/user.dart';

class AuthApi {
  final Dio _dio;
  AuthApi(this._dio);

  Future<Map<String, dynamic>> login(String u, String p) async {
    final r = await _dio.post(
      '/auth/login',
      data: {'username': u, 'password': p},
    );
    return r.data as Map<String, dynamic>; // {accessToken, refreshToken}
  }

  Future<Map<String, dynamic>> refresh(String refreshToken) async {
    final r = await _dio.post(
      '/auth/refresh',
      data: {'refreshToken': refreshToken},
    );
    return r.data as Map<String, dynamic>;
  }

  Future<User> me() async {
    final r = await _dio.get('/me');
    return User.fromJson(r.data);
  }
}
