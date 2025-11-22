import 'package:flutter/material.dart';
import 'package:electronic_approval/common/view/filter_components.dart';
import 'package:electronic_approval/drafts/model/drafts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/drafts/provider/drafts_provider.dart';
import 'package:electronic_approval/drafts/provider/drafts_filter_provider.dart';

class DraftsFilterScreen extends ConsumerStatefulWidget {
  const DraftsFilterScreen({super.key});

  @override
  ConsumerState<DraftsFilterScreen> createState() => _DraftsFilterScreenState();
}

class _DraftsFilterScreenState extends ConsumerState<DraftsFilterScreen> {
  @override
  Widget build(BuildContext context) {
    final filterState = ref.watch(draftsFilterNotifierProvider);
    final filterNotifier = ref.read(draftsFilterNotifierProvider.notifier);
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                            selected: filterState.selectedStatus == status,
                            backgroundColor: Colors.white,
                            selectedColor: Colors.blue,
                            labelStyle: TextStyle(
                              color: filterState.selectedStatus == status
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            checkmarkColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onSelected: (selected) {
                              filterNotifier.setStatus(
                                selected ? status : null,
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
                                    filterState.selectedStartDate ??
                                    DateTime.now(),
                                firstDate: DateTime(2001),
                                lastDate: DateTime.now(),
                              );
                              if (date != null) {
                                filterNotifier.setStartDate(date);
                              }
                            },
                            child: Text(
                              filterState.selectedStartDate == null
                                  ? '시작일'
                                  : '${filterState.selectedStartDate!.year}-${filterState.selectedStartDate!.month}-${filterState.selectedStartDate!.day}',
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
                                initialDate:
                                    filterState.selectedEndDate ??
                                    DateTime.now(),
                                firstDate: DateTime(2001),
                                lastDate: DateTime.now(),
                              );
                              if (date != null) {
                                filterNotifier.setEndDate(date);
                              }
                            },
                            child: Text(
                              filterState.selectedEndDate == null
                                  ? '종료일'
                                  : '${filterState.selectedEndDate!.year}-${filterState.selectedEndDate!.month}-${filterState.selectedEndDate!.day}',
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
                filterNotifier.reset();
              },
              onApply: () {
                if (filterState.selectedEndDate != null &&
                    filterState.selectedStartDate != null &&
                    filterState.selectedEndDate!.isBefore(
                      filterState.selectedStartDate!,
                    )) {
                  SnackBar snackBar = SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text('종료일이 시작일보다 이전일 수 없습니다.'),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  return;
                }

                ref.read(draftsListNotifierProvider.notifier).getDrafts();
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
