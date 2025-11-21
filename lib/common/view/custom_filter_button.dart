import 'package:flutter/material.dart';

class CustomFilterButton extends StatelessWidget {
  final VoidCallback onPressed;
  final List<Widget> activeFilters;
  const CustomFilterButton({
    super.key,
    required this.onPressed,
    required this.activeFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: activeFilters.isEmpty
                ? SizedBox.shrink()
                : Wrap(spacing: 8, runSpacing: 8, children: activeFilters),
          ),
          OutlinedButton.icon(
            onPressed: onPressed,
            label: Text('필터', style: TextStyle(fontSize: 14)),
            icon: Icon(Icons.tune, size: 20),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey.shade400),
              foregroundColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
