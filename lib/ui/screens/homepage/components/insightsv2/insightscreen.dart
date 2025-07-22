import 'package:flutter/material.dart';
import '../../../shared/utils/responsive.dart';
import '../../../shared/widgets/buttons/footer.dart';
import '../header_section.dart';
import '../responsive_navigation/nav_section_mobile.dart';
import '../side_menu.dart';

class InsightPage extends StatelessWidget {
  static const String route = '/Insights';

  const InsightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      drawer: screenWidth < 1024 ? const SideMenu() : null,
      body: Column(
        children: [
          // Header - Responsive Navigation
          ResponsiveLayout(
            mobile: NavSectionMobile(scaffoldKey: GlobalKey()),
            tablet: NavSectionMobile(scaffoldKey: GlobalKey()),
            desktop: const HeaderSection(),
          ),

          // Page content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  // const Text(
                  //   'Insights',
                  //   style: TextStyle(
                  //     fontSize: 40,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.black87,
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Image(image: AssetImage('assets/images/org_chart.png'))
                  ),

                  // Footer
                  const FooterSectionv2(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}