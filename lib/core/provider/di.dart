// lib/app/di.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:gail_india/auth/data/auth_api.dart';
import 'package:gail_india/auth/data/auth_repository.dart';
import 'package:gail_india/core/network/dio_client.dart';
import 'package:gail_india/core/storage/secure_storage.dart';

final secureStoreProvider = Provider((_) => SecureStore());
final dioProvider = Provider<Dio>((ref) => buildDio(ref)); // below
final authApiProvider = Provider((ref) => AuthApi(ref.read(dioProvider)));
final authRepositoryProvider = Provider(
  (ref) =>
      AuthRepository(ref.read(authApiProvider), ref.read(secureStoreProvider)),
);
