// lib/core/network/dio_client.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gail_india/auth/state/auth_controller.dart';
import 'package:gail_india/core/provider/di.dart';

Dio buildDio(Ref ref) {
  final dio = Dio(BaseOptions(baseUrl: 'https://api.example.com/v1'));
  final store = ref.read(secureStoreProvider);

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (o, h) async {
        final at = await store.readAccess();
        if (at != null) o.headers['Authorization'] = 'Bearer $at';
        h.next(o);
      },
      onError: (e, h) async {
        // naive refresh flow
        if (e.response?.statusCode == 401) {
          try {
            await ref.read(authControllerProvider.notifier).refreshToken();
            final req = e.requestOptions;
            final cloned = await dio.request(
              req.path,
              data: req.data,
              queryParameters: req.queryParameters,
              options: Options(method: req.method, headers: req.headers),
            );
            return h.resolve(cloned);
          } catch (_) {}
        }
        h.next(e);
      },
    ),
  );
  return dio;
}
