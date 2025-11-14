import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/common/interceptor/custom_interceptor.dart';
import 'package:electronic_approval/user/provider/token_provider.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:8080/api',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      sendTimeout: const Duration(seconds: 5),
    ),
  );
  dio.interceptors.add(CustomInterceptor(ref.watch(tokenProvider), dio));
  return dio;
});
