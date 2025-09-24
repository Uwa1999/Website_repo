import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../shared/widgets/buttons/footer.dart';

class MainNews extends StatelessWidget {
  static const String route = '/news';
  final String id;
  final String imgPath;
  final String publishedAt;
  final Map<String, dynamic> articleData;

  const MainNews({
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
                    'On May 23, 2022, FDS ASYA PHILIPPINES INC. (FDSAP) and Pamantasan ng Lungsod ng San Pablo (PLSP) signed a Memorandum of Agreement (MOA) for an On- the-Job Training program for Information Technology (IT) students. The collaboration aims to provide PLSP students with practical experience in the field of digital banking, microfinancing services, and other Information Technology operations-related services.',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'The MOA signing took place at Pamantasan ng Lungsod ng San Pablo and was attended by representatives from FDSAP, including its president, Mr. Roderick G. Mercado, along with Mr. Arnel Mendoza, Mr. Raymond Villapando, Ms. Irish Vhernela Emralino, and Ms. Queenie Ricablanca. Representatives from PLSP, including Concurrent University President Engineer Arthur B. Almario, PLSP Executive Vice President for Administration and Finance Dr. Sigfredo C. Adajar, PLSP Vice President for External Affairs and Linkages Prof. Arceli C. Adajar, and PLSP Acting Dean College of Computer Studies and Technology Prof. Sherwin D. Quizon, were also present. CARD MRI Founder and Chairman Emeritus Dr. Aristotle B. Alip, CARD MRI Information Technology (CMIT) President Edgar V. Cauyan, CMIT Vice President for Technical Services Maricar Lopez, CMIT Chief Information Security Officer Arman B. Peñafiel, and Director for RM/Partnership/IG Ms. Jean Pauline B. Landicho virtually joined the event.',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'During the signing ceremony, Mr. Mercado emphasized the importance of the agreement, stating, "Since CARD MRI began its operations in San Pablo, Laguna, we also aim to give back to this community we call home. As part of our mission of providing opportunities for the members of this town, we hope to generate employment, especially for students who have the potential to contribute to our vision of a poverty-free country through the use of technology."',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'In response, Engr. Almario expressed, "This collaboration with FDSAP will help our students enhance and develop their skills, opening up better opportunities for them in the future, especially as we adapt to the era of modernization where information technology is highly in demand. The joint forces of PLSP and FDSAP will have a significant impact not only on the San Pablo community but also on the country economy, especially amid the effects of the pandemic."',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Moreover, CARD MRI envisions extending the On-the-Job training program to include not only IT students but also students from other professional fields such as business administration and accountancy. This initial partnership paves the way for further opportunities for fresh graduates to undergo fruitful training and secure employment prospects.',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '"The joint forces of PLSP and FDSAP will have a significant impact not only on the San Pablo community but also on the country`s economy, especially amid the effects of the pandemic."',
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