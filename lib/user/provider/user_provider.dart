import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/user/model/login_response.dart';
import 'package:electronic_approval/user/model/user_request.dart';
import 'package:electronic_approval/user/user_repository.dart';
import 'package:electronic_approval/user/provider/token_provider.dart';

final userNotifierProvider = AsyncNotifierProvider<UserNotifier, LoginResponse>(
  () => UserNotifier(),
);

class UserNotifier extends AsyncNotifier<LoginResponse> {
  late final UserRepository _userRepository;
  late final Token _token;

  @override
  Future<LoginResponse> build() async {
    _userRepository = ref.watch(userRepositoryProvider);
    _token = ref.watch(tokenProvider);

    final accessToken = await _token.getAccessToken();

    if (accessToken == null) {
      return LoginResponse(accessToken: '', tokenType: '');
    }

    final response = await _userRepository.me();

    return LoginResponse.fromJson(response.response.data.toJson());
  }

  Future<LoginResponse> login(UserRequest userRequest) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final response = await _userRepository.login(userRequest: userRequest);

      _token.saveAccessToken(response.data.accessToken);
      _token.saveRefreshToken(response.response.headers.value(REFRESH_TOKEN)!);

      return response.data;
    });

    return state.value ?? LoginResponse(accessToken: '', tokenType: '');
  }

  Future<LoginResponse> refresh({String? refreshToken}) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final response = await _userRepository.refresh(
        refreshToken: refreshToken,
      );

      final data = response.response.data.toJson();

      return LoginResponse.fromJson(data);
    });

    return state.value ?? LoginResponse(accessToken: '', tokenType: '');
  }
}
