import 'package:flutter/material.dart';
import 'package:electronic_approval/drafts/model/drafts.dart';
import 'package:electronic_approval/common/view/custom_filter_button.dart';

class CustomFilter extends StatelessWidget {
  const CustomFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustomFilterButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => _FilterScreen(),
          );
        },
        activeFilters: [],
      ),
    );
  }
}

class _FilterScreen extends StatefulWidget {
  const _FilterScreen({super.key});

  @override
  State<_FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<_FilterScreen> {
  DocumentStatus? selectedStatus;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [Text('Status'), Text('StartDate'), Text('EndDate')],
            ),
          ),
        ],
      ),
    );
  }
}
