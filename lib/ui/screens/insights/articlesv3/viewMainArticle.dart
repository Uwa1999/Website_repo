import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../shared/widgets/buttons/footer.dart';

class MainArticle extends StatelessWidget {
  static const String route = '/article';
  final String id;
  final String imgPath;
  final String publishedAt;
  final Map<String, dynamic> articleData;

  const MainArticle({
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
                    'By co-creating value and empowering financial institutions with solutions designed for the digital era, FDS ASYA PHILIPPINES INC. (FDSAP) drives growth, enhances operational efficiency, and delivers exceptional customer experiences. With a commitment to collaboration, harnessing technological advancements, and building lasting partnerships, FDSAP remains at the forefront of regional transformation, playing a crucial role in shaping the future of banking. FDSAP is a company owned of PT Sarana Pactindo formerly FDS. It is the result of a joint venture between two industry-leading companies, CARD MRI and Fortress Data Services Indonesia. While FDS offers top-notch banking applications to Indonesian banks and financial services, CARD MRI is a group of institutions dedicated to eradicating poverty in the Philippines. Both FDSAP and CARD MRI Holdings, Inc. are member-institutions of CARD Mutually Reinforcing Institutions (CARD MRI).',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'FDSAP is a company owned of PT Sarana Pactindo formerly FDS. It is the result of a joint venture between two industry-leading companies, CARD MRI and Fortress Data Services Indonesia. While FDS offers top-notch banking applications to Indonesian banks and financial services, CARD MRI is a group of institutions dedicated to eradicating poverty in the Philippines. Both FDSAP and CARD MRI Holdings, Inc. are member-institutions of CARD Mutually Reinforcing Institutions (CARD MRI).',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Enabling Success in the Digital Era:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'As technology rapidly evolves, the banking landscape is undergoing a profound shift. FDSAP recognizes this paradigm change and plays a pivotal role in equipping financial institutions with the tools and strategies required to navigate the digital era successfully. By embracing innovation and leveraging cutting-edge technologies, FDSAP empowers banks to stay ahead of the curve, enhance operational efficiency, and deliver unparalleled customer experiences.',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Co-creating Value:',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'FDSAP understands that true success is achieved by working hand in hand with financial institutions to co-create value. By fostering deep relationships, actively listening to clients; needs, and tailoring solutions accordingly, FDSAP ensures that the provided services are aligned with the specific goals and objectives of its partners. This collaborative approach not only fosters growth and profitability for financial institutions but also contributes to the overall development of the regional economy and community.',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Harnessing Technological Advancements:',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'FDSAP stays at the forefront of technological advancements, leveraging them to deliver cutting-edge solutions. With expertise in areas such as core banking, mobile banking, and digital financial ecosystems, FDSAP equips financial institutions with scalable and flexible architectures that can accommodate businesses of all sizes. By harnessing emerging technologies such as artificial intelligence, blockchain, and data analytics, FDSAP enables financial institutions to drive innovation, enhance security, and unlock new opportunities for growth.',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'A Trusted Partner:',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Throughout its journey, FDSAP has built a reputation as a trusted and reliable partner for financial institutions.. With its deep industry knowledge, extensive experience, and a track record of successful implementations, FDSAP has garnered the trust of its clients. Financial institutions recognize FDSAP as a partner that understands their unique challenges and provides tailored solutions to address their specific needs, ultimately positioning them for long-term success in the digital era.',
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