import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/drafts/provider/drafts_filter_state.dart';
import 'package:electronic_approval/drafts/model/drafts.dart';

class DraftsFilterNotifier extends Notifier<DraftsFilterState> {
  @override
  DraftsFilterState build() {
    return DraftsFilterState.initial();
  }

  void setStatus(DocumentStatus? status) {
    state = state.copyWith(selectedStatus: () => status);
  }

  void setStartDate(DateTime? startDate) {
    state = state.copyWith(selectedStartDate: () => startDate);
  }

  void setEndDate(DateTime? endDate) {
    state = state.copyWith(selectedEndDate: () => endDate);
  }

  void reset() {
    state = DraftsFilterState.initial();
  }

  int get filterCount {
    int filterCount = 0;
    if (state.selectedStatus != null) {
      filterCount++;
    }
    if (state.selectedStartDate != null || state.selectedEndDate != null) {
      filterCount++;
    }
    return filterCount;
  }
}

final draftsFilterNotifierProvider =
    NotifierProvider<DraftsFilterNotifier, DraftsFilterState>(
      () => DraftsFilterNotifier(),
    );