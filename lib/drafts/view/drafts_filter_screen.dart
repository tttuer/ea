import 'package:flutter/material.dart';
import 'package:electronic_approval/common/view/filter_components.dart';
import 'package:electronic_approval/drafts/model/drafts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/drafts/provider/drafts_provider.dart';

class DraftsFilterScreen extends ConsumerStatefulWidget {
  const DraftsFilterScreen({super.key});

  @override
  ConsumerState<DraftsFilterScreen> createState() => _DraftsFilterScreenState();
}

class _DraftsFilterScreenState extends ConsumerState<DraftsFilterScreen> {
  DocumentStatus? selectedStatus;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  @override
  void initState() {
    super.initState();
    final draftsListNotifier = ref.read(draftsListNotifierProvider.notifier);
    selectedStatus = ref
        .read(draftsListNotifierProvider.notifier)
        .selectedStatus;
    selectedStartDate = ref
        .read(draftsListNotifierProvider.notifier)
        .selectedStartDate;
    selectedEndDate = ref
        .read(draftsListNotifierProvider.notifier)
        .selectedEndDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  '필터',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade300),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FilterSectionTitle(title: '상태'),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ...DocumentStatus.values.map(
                          (status) => ChoiceChip(
                            label: Text(status.statusText),
                            selected: selectedStatus == status,
                            backgroundColor: Colors.white,
                            selectedColor: Colors.blue,
                            labelStyle: TextStyle(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onSelected: (selected) {
                              ref
                                  .read(draftsListNotifierProvider.notifier)
                                  .setFilter(
                                    selectedStatus,
                                    selectedStartDate,
                                    selectedEndDate,
                                  );
                            },
                          ),
                        ),
                      ],
                    ),
                    FilterSectionTitle(title: '날짜'),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade300),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              foregroundColor: Colors.black,
                            ),
                            onPressed: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate:
                                    selectedStartDate ?? DateTime.now(),
                                firstDate: DateTime(2001),
                                lastDate: DateTime.now(),
                              );
                              if (date != null) {
                                selectedStartDate = date;
                                ref
                                    .read(draftsListNotifierProvider.notifier)
                                    .setFilter(
                                      selectedStatus,
                                      selectedStartDate,
                                      selectedEndDate,
                                    );
                              }
                            },
                            child: Text(
                              selectedStartDate == null
                                  ? '시작일'
                                  : '${selectedStartDate!.year}-${selectedStartDate!.month}-${selectedStartDate!.day}',
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text('~'),
                        SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade300),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              foregroundColor: Colors.black,
                            ),

                            onPressed: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: selectedEndDate ?? DateTime.now(),
                                firstDate: DateTime(2001),
                                lastDate: DateTime.now(),
                              );
                              if (date != null) {
                                selectedEndDate = date;
                                ref
                                    .read(draftsListNotifierProvider.notifier)
                                    .setFilter(
                                      selectedStatus,
                                      selectedStartDate,
                                      selectedEndDate,
                                    );
                              }
                            },
                            child: Text(
                              selectedEndDate == null
                                  ? '종료일'
                                  : '${selectedEndDate!.year}-${selectedEndDate!.month}-${selectedEndDate!.day}',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilterBottomButtons(
              onReset: () {
                ref
                    .read(draftsListNotifierProvider.notifier)
                    .setFilter(null, null, null);
              },
              onApply: () {
                if (selectedEndDate != null &&
                    selectedStartDate != null &&
                    selectedEndDate!.isBefore(selectedStartDate!)) {
                  SnackBar snackBar = SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text('종료일이 시작일보다 이전일 수 없습니다.'),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }

                ref
                    .read(draftsListNotifierProvider.notifier)
                    .setFilter(
                      selectedStatus,
                      selectedStartDate,
                      selectedEndDate,
                    );
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
