import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/user/model/user_response.dart';
import 'package:electronic_approval/user/user_repository.dart';
import 'dart:async';

final userSearchNotifierProvider =
    AsyncNotifierProvider<UserSearchNotifier, List<UserResponse>>(
      () => UserSearchNotifier(),
    );

class UserSearchNotifier extends AsyncNotifier<List<UserResponse>> {
  late final UserRepository _userRepository;
  Timer? _debounceTimer;

  @override
  Future<List<UserResponse>> build() async {
    state = const AsyncValue.loading();
    _userRepository = ref.watch(userRepositoryProvider);
    return [];
  }

  Future<List<UserResponse>> search({required String name}) async {
    _debounceTimer?.cancel();

    if(name.isEmpty) {
      state = const AsyncValue.data([]);
      return [];
    }

    final completer = Completer<List<UserResponse>>();

    _debounceTimer = Timer(Duration(milliseconds: 300), () async {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final response = await _userRepository.search(name: name);
        return response.data;
      });

      final result = state.value ?? [];
      completer.complete(result);
    });

    return completer.future;
  }

  void cancelSearch() {
    _debounceTimer?.cancel();
  }
}
