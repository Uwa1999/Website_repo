import 'package:flutter/material.dart';

class ArticleItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String date;
  final String remarks;
  final int visits;
  final bool isMain;
  final bool selected;
  final ValueChanged<bool?> onChanged;

  const ArticleItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.date,
    required this.remarks,
    required this.visits,
    required this.isMain,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Format the date
    final formattedDate = DateTime.parse(date).toLocal();
    final dateString = '${formattedDate.day}/${formattedDate.month}/${formattedDate.year}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Checkbox(
              value: selected,
              onChanged: onChanged,
              activeColor: const Color(0xFF630606), // Background when checked
              checkColor: Colors.white, // Color of the checkmark
              fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.selected)) {
                  return const Color(0xFF630606); // Checked
                }
                return Colors.grey.shade300; // Unchecked
              }),
            ),

          ),
          // Title + Thumbnail
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Image.network(
                  'https://dev-api-janus.fortress-asya.com:18043$imagePath', // Full URL
                  height: 48,
                  width: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image, size: 48),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        dateString,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Date
          Expanded(flex: 3, child: Text(dateString)),

          // Status
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isMain ? const Color(0xFF4A0D0D) : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                remarks,
                style: TextStyle(
                  fontSize: 12,
                  color: isMain ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),

          // Visits
          Expanded(flex: 2, child: Text("$visits")),

          // Actions
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: () {
                  // Handle edit
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20),
                onPressed: () {
                  // Handle delete
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}