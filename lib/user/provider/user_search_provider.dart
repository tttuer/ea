import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/user/model/user_response.dart';
import 'package:electronic_approval/user/user_repository.dart';

final userSearchNotifierProvider =
    AsyncNotifierProvider<UserSearchNotifier, List<UserResponse>>(
      () => UserSearchNotifier(),
    );

class UserSearchNotifier extends AsyncNotifier<List<UserResponse>> {
  late final UserRepository _userRepository;

  @override
  Future<List<UserResponse>> build() async {
    state = const AsyncValue.loading();
    _userRepository = ref.watch(userRepositoryProvider);
    return [];
  }

  Future<List<UserResponse>> search({required String name}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await _userRepository.search(name: name);
      return response.data;
    });
    return state.value ?? [];
  }
}
