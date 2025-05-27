import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_responsive_section/widgets.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/content_area.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/gradientcustomtext.dart';


const double bodyTextSizeLg = 16.0;
const double bodyTextSizeSm = 14.0;
const double socialTextSizeLg = 18.0;
const double socialTextSizeSm = 14.0;



class HeaderResponsiveWeb extends StatefulWidget {
  const HeaderResponsiveWeb({Key? key}) : super(key: key);

  @override
  _HeaderResponsiveWebState createState() => _HeaderResponsiveWebState();
}

class _HeaderResponsiveWebState extends State<HeaderResponsiveWeb> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContentArea(
      height: MediaQuery.of(context).size.height,
      child: _buildDesktopHeader(context),
    );
  }

  Widget _buildDesktopHeader(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    final textAlign = isMobile ? TextAlign.center : TextAlign.justify;

    final textItems = [
      'Providing world class core banking software in the regional economy and community with short',
      'Implementation time, tailor-made services, and redefining the holistic customer experiences.',
    ];

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double screenWidth = constraints.maxWidth;

                  // Adjust this formula as needed for your layout
                  double dynamicFontSize = (screenWidth * 0.08).clamp(50.0, 100.0);

                  return GradientCustomText(
                    text: 'Trusted partner on your Digitalization Journey.',
                    style: TextStyle(
                      fontSize: dynamicFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    gradient: linearGradient,
                  );
                },
              ),
            ),
            isMobile ? SizedBox(height: 20) : SizedBox(height: 300),
            Center(
              child: Container(
                // color: Colors.teal,
                width: screenWidth * 0.9,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Flex(
                  direction: isMobile ? Axis.vertical : Axis.horizontal,
                  mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                  children: textItems.map((text) => textBox(text, textAlign)).toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget textBox(String text, TextAlign textAlign) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: 300,
      child: Text(
        text,
        textAlign: textAlign,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
//   Widget buildTabletHeader() {
//     return Column(
//       children: [
//         const SizedBox(height: 60),
//         Image.asset('assets/images/main-text-landing-page.png', width: 600),
//         const SizedBox(height: 30),
//         Image.asset('assets/images/phone-web.png', width: 600),
//         const Padding(
//           padding: EdgeInsets.all(20.0),
//           child: Text(
//             'Banking software solutions for the regional economy and community.',
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ],
//     );
//   }
//
// }

  // You can put these in separate files or in the same file.

