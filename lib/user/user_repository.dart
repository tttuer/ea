import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/common/dio/dio.dart';

part 'user_repository.g.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return UserRepository(dio, baseUrl: 'http://localhost:8080');
});

@RestApi()
abstract class UserRepository {
  factory UserRepository(Dio dio, {required String baseUrl}) = _UserRepository;

  @POST('/api/users/login')
  @Headers({'access_token': 'true'})
  Future<void> login({
    @Body() required String id,
    @Body() required String password,
  });
}
