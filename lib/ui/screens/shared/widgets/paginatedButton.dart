import 'package:flutter/material.dart';

class PaginatedButtons extends StatefulWidget {
  final int totalRecords;
  final int totalPages;
  final Function onPageChanged;
  final int currentPage;
  final String name;

  const PaginatedButtons({
    Key? key,
    required this.totalRecords,
    required this.totalPages,
    required this.onPageChanged,
    required this.currentPage,
    required this.name,
  }) : super(key: key);

  @override
  State<PaginatedButtons> createState() => _PaginatedButtonsState();
}

class _PaginatedButtonsState extends State<PaginatedButtons> {
  void nextPage() {
    if (widget.currentPage < widget.totalPages) {
      widget.onPageChanged(widget.currentPage + 1);
    }
  }

  void previousPage() {
    if (widget.currentPage > 1) {
      widget.onPageChanged(widget.currentPage - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 25,
              decoration: const BoxDecoration(
                color: const Color(0xFF4B0C0C),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B0C0C),
                ),
                onPressed: previousPage, // Call previousPage
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back_rounded, color: Colors.white, size: 15),
                    SizedBox(width: 5),
                    Text('Prev', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  'PAGE ${widget.currentPage} OF ${widget.totalPages}', // Use widget.currentPage here
                  style: const TextStyle(
                    color: const Color(0xFF4B0C0C),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  'TOTAL NUMBER OF ${widget.name}: ${widget.totalRecords}',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            Container(
              height: 25,
              decoration: const BoxDecoration(
                color:  Color(0xFF4B0C0C),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B0C0C),
                ),
                onPressed: nextPage, // Call nextPage
                child: const Row(
                  children: [
                    Text('Next', style: TextStyle(color: Colors.white, fontSize: 12)),
                    SizedBox(width: 5),
                    Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 15),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
