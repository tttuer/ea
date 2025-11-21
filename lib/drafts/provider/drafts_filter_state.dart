import 'package:electronic_approval/drafts/model/drafts.dart';

class DraftsFilterState {
  final DocumentStatus? selectedStatus;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;

  DraftsFilterState({
    this.selectedStatus,
    this.selectedStartDate,
    this.selectedEndDate,
  });

  DraftsFilterState copyWith({
    DocumentStatus? Function()? selectedStatus,
    DateTime? Function()? selectedStartDate,
    DateTime? Function()? selectedEndDate,
  }) {
    return DraftsFilterState(
      selectedStatus: selectedStatus != null
          ? selectedStatus()
          : this.selectedStatus,
      selectedStartDate: selectedStartDate != null
          ? selectedStartDate()
          : this.selectedStartDate,
      selectedEndDate: selectedEndDate != null
          ? selectedEndDate()
          : this.selectedEndDate,
    );
  }

  factory DraftsFilterState.initial() {
    return DraftsFilterState(
      selectedStatus: null,
      selectedStartDate: null,
      selectedEndDate: null,
    );
  }
}
