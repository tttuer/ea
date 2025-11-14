import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/common/dio/dio.dart';
import 'package:electronic_approval/user/model/login_response.dart';
import 'package:electronic_approval/user/model/user_request.dart';
import 'package:electronic_approval/user/model/user_response.dart';

part 'user_repository.g.dart';

const String REFRESH_TOKEN = 'refresh_token';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return UserRepository(dio, baseUrl: '${dio.options.baseUrl}/users');
});

@RestApi()
abstract class UserRepository {
  factory UserRepository(Dio dio, {required String baseUrl}) = _UserRepository;

  @POST('/login')
  @FormUrlEncoded()
  Future<HttpResponse<LoginResponse>> login({
    @Field('username') required String username,
    @Field('password') required String password,
  });

  @POST('/refresh')
  Future<HttpResponse<LoginResponse>> refresh({
    @Header(REFRESH_TOKEN) String? refreshToken,
  });

  @GET('/me')
  @Headers({'access_token': true})
  Future<HttpResponse<UserResponse>> me();
}
