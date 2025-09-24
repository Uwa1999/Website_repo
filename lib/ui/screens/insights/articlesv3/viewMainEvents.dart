import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../shared/widgets/buttons/footer.dart';

class MainEvents extends StatelessWidget {
  static const String route = '/events';
  final String id;
  final String imgPath;
  final String publishedAt;
  final Map<String, dynamic> articleData;

  const MainEvents({
    super.key,
    required this.id,
    required this.imgPath,
    required this.publishedAt,
    required this.articleData,
  });

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return '';
    }
    try {
      final dateTime = DateTime.parse(dateString);
      final formatter = DateFormat('MMMM d, yyyy : h:mm a');

      return formatter.format(dateTime);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = _formatDate(publishedAt);
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth > 800;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80.0 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text(
                      articleData['remarks'] ?? '',
                      style: const TextStyle(
                        fontFamily: 'Robotothin',
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // The title text
                  Text(
                    articleData['title'] ?? 'No Title',
                    style: const TextStyle(
                      fontSize: 50,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Published on ${formattedDate}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: Image.network(
                      imgPath,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'FDSAP hosted the Tech Update 2025 as part of our 9th Anniversary Celebration on August 14, 2025, a day filled with knowledge, collaboration, and innovation.',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Thanks to our supportive sponsors and the presence of participants from our partner universities and CARD MRI Institutions, the event was a testament to what we can achieve when we come together with one vision.',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Here`s to shaping the future through technology, education, and partnership!',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const FooterSectionv2(),
          ],
        ),
      ),
    );
  }
}