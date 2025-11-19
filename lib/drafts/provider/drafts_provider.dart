import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/drafts/repository/drafts_repository.dart';
import 'package:electronic_approval/drafts/model/drafts.dart';
import 'package:electronic_approval/common/pagination/pagination.dart';

final draftsListNotifierProvider =
    AsyncNotifierProvider<DraftsListNotifier, Pagination<Drafts>>(
      () => DraftsListNotifier(),
    );

class DraftsListNotifier extends AsyncNotifier<Pagination<Drafts>> {
  bool _isLoading = false;
  late final DraftsRepository _draftsRepository = ref.watch(
    draftsRepositoryProvider,
  );

  @override
  Future<Pagination<Drafts>> build() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await _draftsRepository.getDrafts();
      return response;
    });

    return state.value ??
        Pagination(total: 0, page: 0, pageSize: 0, totalPages: 0, items: []);
  }

  Future<void> getDrafts() async {
    state = await AsyncValue.guard(() async {
      final response = await _draftsRepository.getDrafts();
      return response;
    });
  }

  Future<void> fetchMore() async {
    if (_isLoading) return;

    final currentData = state.value;
    if (currentData == null) {
      return;
    }
    if (currentData.page >= currentData.totalPages) {
      return;
    }

    try {
      final response = await _draftsRepository.getDrafts(
        page: currentData.page + 1,
      );
      final newItems = [...currentData.items, ...response.items];
      final newPagination = currentData.copyWith(
        total: response.total,
        page: response.page,
        pageSize: response.pageSize,
        totalPages: response.totalPages,
        items: newItems,
      );
      state = AsyncValue.data(newPagination);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    } finally {
      _isLoading = false;
    }
  }
}
