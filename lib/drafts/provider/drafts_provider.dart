import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/drafts/repository/drafts_repository.dart';
import 'package:electronic_approval/drafts/model/drafts.dart';
import 'package:electronic_approval/common/pagination/pagination.dart';
import 'package:electronic_approval/drafts/provider/drafts_filter_provider.dart';
import 'package:electronic_approval/drafts/provider/drafts_filter_state.dart';

final draftsListNotifierProvider =
    AsyncNotifierProvider<DraftsListNotifier, Pagination<Drafts>>(
      () => DraftsListNotifier(),
    );

class DraftsListNotifier extends AsyncNotifier<Pagination<Drafts>> {
  bool _isLoading = false;
  late final DraftsRepository _draftsRepository = ref.watch(
    draftsRepositoryProvider,
  );

  DraftsFilterState get _filterState => ref.read(draftsFilterNotifierProvider);

  @override
  Future<Pagination<Drafts>> build() async {
    state = await AsyncValue.guard(() async {
      final response = await _draftsRepository.getDrafts(
        status: _filterState.selectedStatus?.toQueryParam(),
        startDate: _formatDate(_filterState.selectedStartDate),
        endDate: _formatDate(_filterState.selectedEndDate),
      );
      return response;
    });

    return state.value ??
        Pagination(
          isLoadingMore: false,
          total: 0,
          page: 0,
          pageSize: 0,
          totalPages: 0,
          items: [],
        );
  }

  String? _formatDate(DateTime? date) {
    if (date == null) {
      return null;
    }
    return '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> getDrafts() async {
    state = await AsyncValue.guard(() async {
      final response = await _draftsRepository.getDrafts(
        status: _filterState.selectedStatus?.toQueryParam(),
        startDate: _formatDate(_filterState.selectedStartDate),
        endDate: _formatDate(_filterState.selectedEndDate),
      );
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

    _isLoading = true;
    state = AsyncValue.data(currentData.copyWith(isLoadingMore: true));

    try {
      final response = await _draftsRepository.getDrafts(
        page: currentData.page + 1,
        status: _filterState.selectedStatus?.toQueryParam(),
        startDate: _formatDate(_filterState.selectedStartDate),
        endDate: _formatDate(_filterState.selectedEndDate),
      );
      final newItems = [...currentData.items, ...response.items];
      final newPagination = currentData.copyWith(
        isLoadingMore: false,
        total: response.total,
        page: response.page,
        pageSize: response.pageSize,
        totalPages: response.totalPages,
        items: newItems,
      );
      state = AsyncValue.data(newPagination);
    } catch (e) {
      state = AsyncValue.data(currentData.copyWith(isLoadingMore: false));
    } finally {
      _isLoading = false;
    }
  }
}
