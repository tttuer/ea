import 'package:flutter/material.dart';
import 'package:electronic_approval/drafts/model/drafts.dart';

class CustomFilter extends StatelessWidget {
  const CustomFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 48,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Wrap(spacing: 8, children: [])),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => _FilterScreen(),
                isScrollControlled: true,
                useSafeArea: true,
              );
            },
            icon: Icon(Icons.tune),
          ),
        ],
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
