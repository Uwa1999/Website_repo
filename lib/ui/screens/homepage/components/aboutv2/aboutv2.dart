import 'package:flutter/material.dart';

import '../../../shared/widgets/NavItemData_global.dart';

class AboutUsSection extends StatelessWidget {
  static const String route = '/AboutUsSec';
  const AboutUsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // Main content column
        Column(
          children: [
            // White section (About Us text)
            Container(
              key: navItems[2].key, // Assuming navItems is globally available
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.only(top: 80, bottom: 250),
              child: Column(
                children: [
                  const Text(
                    'About us',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      '''FDS ASYA PHILIPPINES INC. (FDSAP) is a leader in digital services, whose success is also attributed to the support of an international alliance with our holding, FORTRESS DATA SERVICES INDONESIA (FDSI). With a deep understanding of local businesses, we have played a vital role since 2015 in facilitating the digitalization journeys of CARD Bank, CARD RBI, and CARD SME.

Throughout the years, we have become one of Southeast Asia’s leading IT companies and continue to be a trustworthy and reliable partner in the financial industry.''',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Black section (bottom quote text)
            Container(
              width: double.infinity,
              color: Colors.black,
              padding: const EdgeInsets.only(top: 200, bottom: 60),
              child: const Text(
                'Listening is where the care begins.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),

        // Group photo positioned overlapping both sections
        Positioned(
          top: MediaQuery.of(context).size.height * 0.36,
          child: Image.asset(
            'assets/images/aboutUS.png', // Adjust this path as needed
            width: MediaQuery.of(context).size.width * 0.85,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
