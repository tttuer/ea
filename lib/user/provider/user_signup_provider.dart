import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/user/model/user_response.dart';
import 'package:electronic_approval/user/user_repository.dart';

final userSignupNotifierProvider =
    AsyncNotifierProvider<UserSignupNotifier, UserResponse?>(
      () => UserSignupNotifier(),
    );

class UserSignupNotifier extends AsyncNotifier<UserResponse?> {
  late final UserRepository _userRepository;

  @override
  Future<UserResponse?> build() async {
    state = const AsyncValue.loading();
    _userRepository = ref.watch(userRepositoryProvider);
    return null;
  }

  Future<UserResponse?> signup({
    required String name,
    required String userId,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await _userRepository.signup(
        name: name,
        userId: userId,
        password: password,
      );
      return response.data;
    });
    return state.value;
  }
}
