import 'package:flutter/material.dart';
import 'package:electronic_approval/common/view/filter_components.dart';
import 'package:electronic_approval/drafts/model/drafts.dart';

class DraftsFilterScreen extends StatefulWidget {
  const DraftsFilterScreen({super.key});

  @override
  State<DraftsFilterScreen> createState() => _DraftsFilterScreenState();
}

class _DraftsFilterScreenState extends State<DraftsFilterScreen> {
  DocumentStatus? selectedStatus;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

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
                              setState(() {
                                selectedStatus = selected ? status : null;
                              });
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
                                setState(() {
                                  selectedStartDate = date;
                                });
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
                                setState(() {
                                  selectedEndDate = date;
                                });
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
                setState(() {
                  selectedStatus = null;
                  selectedStartDate = null;
                  selectedEndDate = null;
                });
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
                Navigator.pop(context, {
                  'status': selectedStatus,
                  'startDate': selectedStartDate,
                  'endDate': selectedEndDate,
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
