import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/drafts/repository/drafts_repository.dart';
import 'package:electronic_approval/drafts/model/drafts.dart';
import 'package:electronic_approval/common/pagination/pagination.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'drafts_provider.freezed.dart';

@freezed
class DraftState with _$DraftState {
  const factory DraftState.loading() = _Loading;
  const factory DraftState.data(Pagination<Drafts> drafts) = _Paginated;
  const factory DraftState.single(Drafts draft) = _Single;
  const factory DraftState.error(Object error) = _Error;
}

class DraftsProvider extends AsyncNotifier<DraftState> {
  late final DraftsRepository _draftsRepository;

  @override
  Future<DraftState> build() async {
    return const DraftState.loading();
  }

  Future<DraftState> getDrafts() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final response = await _draftsRepository.getDrafts();
      return DraftState.data(response);
    });

    return state.value ?? DraftState.error(Exception('Failed to get drafts'));
  }
}
