import 'package:flutter/material.dart';

class InsightsFilterButton extends StatefulWidget {
  final Function(String) onFilterChanged;

  const InsightsFilterButton({
    super.key,
    required this.onFilterChanged,
  });

  @override
  State<InsightsFilterButton> createState() => _InsightsFilterButtonState();
}

class _InsightsFilterButtonState extends State<InsightsFilterButton> {
  String _selectedFilter = 'All';

  final List<String> _filterOptions = [
    'All',
    'Announcements',
    'Events',
    'News',
    'Main',
    'Sub'
  ];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF630606), // Set your background color here
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.filter_alt_outlined, size: 18, color: Colors.white), // icon color
            const SizedBox(width: 8),
            Text(
              _selectedFilter,
              style: const TextStyle(color: Colors.white), // text color
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_drop_down, size: 18, color: Colors.white), // icon color
          ],
        ),
      ),

      onSelected: (String value) {
        setState(() {
          _selectedFilter = value;
        });
        widget.onFilterChanged(value);
      },
      itemBuilder: (BuildContext context) {
        return _filterOptions.map((String option) {
          return PopupMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList();
      },
    );
  }
}