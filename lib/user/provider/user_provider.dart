import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/user/model/login_response.dart';
import 'package:electronic_approval/user/user_repository.dart';

final userNotifierProvider = AsyncNotifierProvider<UserNotifier, LoginResponse>(
  () => UserNotifier(),
);

class UserNotifier extends AsyncNotifier<LoginResponse> {
  late final UserRepository _userRepository;

  @override
  Future<LoginResponse> build() async {
    _userRepository = ref.watch(userRepositoryProvider);
    return LoginResponse(accessToken: '', tokenType: '');
  }
}
