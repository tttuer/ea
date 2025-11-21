import 'package:flutter/material.dart';

class CustomFilterButton extends StatelessWidget {
  final VoidCallback onPressed;
  final int filterCount;
  const CustomFilterButton({
    super.key,
    required this.onPressed,
    required this.filterCount,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasActiveFilters = filterCount > 0;

    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 14, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey.shade400),
              foregroundColor: hasActiveFilters ? Colors.white : Colors.black,
              backgroundColor: hasActiveFilters ? Colors.blue : Colors.white,
            ),
            onPressed: onPressed,
            label: Text(
              hasActiveFilters ? '필터 $filterCount' : '필터',
              style: TextStyle(
                fontSize: 14,
                color: hasActiveFilters ? Colors.white : Colors.black,
              ),
            ),
            icon: Icon(Icons.tune, size: 20),
          ),
        ],
      ),
    );
  }
}
