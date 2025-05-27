import 'package:flutter/material.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/animation.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/customCard.dart';

import '../../shared/utils/responsive.dart';
import '../../shared/widgets/buttons/footer.dart'; // Custom layout

class BankingTechnology extends StatefulWidget {
  static const String route = '/bankingtechnology';

  const BankingTechnology({Key? key}) : super(key: key);

  @override
  State<BankingTechnology> createState() => _BankingTechnologyState();
}

class _BankingTechnologyState extends State<BankingTechnology> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      key: _scaffoldKey,
      drawer: screenWidth < 1024 ? const SideMenu() : null,
      body: Column(
        children: [
          ResponsiveLayout(
            mobile: NavSectionMobile(scaffoldKey: _scaffoldKey),
            tablet: NavSectionMobile(scaffoldKey: _scaffoldKey),
            desktop: const HeaderSection(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: AnimatedGradientText(
                      animation: _animation,
                      text: "Banking Technology",
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: List.generate(
                      5,
                          (index) => CustomCardWidgetv2(
                        description:
                        'FinCloud Platform empowers financial institutions to seamlessly transition to a digital-first model. It offers a unified, API-driven solution that is easy to implement.',
                        imagePath: 'assets/images/mono-temenos.png',
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
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


