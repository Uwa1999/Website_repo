import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/animation.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/customCard.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/buttons/footer.dart';

import '../../shared/utils/responsive.dart';

class MFIPage extends StatefulWidget {
  static const String route = '/MfisPage';
  final double? cardWidth;

  const MFIPage({Key? key, this.cardWidth}) : super(key: key);

  @override
  State<MFIPage> createState() => _MFIPageState();
}

class _MFIPageState extends State<MFIPage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<BankingService> services = [
    BankingService(
      title: 'Cyber Security',
      description:
      'Computer security, or information security, protects systems, networks, and data from cyber threats to ensure confidentiality, integrity, and availability in the digital space.',
      imagePath: 'assets/images/cybersecurity1.png',
    ),
    BankingService(
      title: 'Fraud Detection',
      description: 'Fraud detection is the process of identifying and preventing fraudulent activities or transactions to safeguard individuals, businesses, and financial institutions from financial loss and reputational harm.',
      imagePath: 'assets/images/frauddetection1.png',
    ),
    BankingService(
      title: 'Ati Money Laundering',
      description:
      'CARD MRI’s banking and non-banking institutions utilize our Anti-Money Laundering (AMLA) software to analyze customer data and identify suspicious transactions.',
      imagePath: 'assets/images/aml1.png',
    ),
    BankingService(
      title: 'World Check',
      description:
      'World-Check is a risk intelligence database used for financial compliance. It helps identify potentially high-risk individuals, organizations, and countries associated with money laundering, terrorism, and other illicit activities.',
      imagePath: 'assets/images/worldcheck1.png',
    ),
  ];

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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      drawer: MediaQuery.of(context).size.width < 1024 ? const SideMenu() : null,
      body: Column(
        children: [
          ResponsiveLayout(
            mobile: NavSectionMobile(scaffoldKey: _scaffoldKey),
            tablet: Container(),
            desktop: const HeaderSection(),
          ),
          Expanded(
            child: SingleChildScrollView(
              // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: GradientText(
                      text: 'Regulatory and Services',
                      gradient: LinearGradient(colors: [Colors.black, Colors.redAccent, Colors.red]),
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(),
                    ),
                    child: const Center(
                      child: Text(
                        "4 services offered",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: services.map((service) {
                      return CustomCardWidgetv1(
                        title: service.title,
                        description: service.description,
                        imagePath: service.imagePath,
                        maxWidth: widget.cardWidth,
                      );
                    }).toList(),
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

class CustomCardWidgetv1 extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final double? maxWidth;

  const CustomCardWidgetv1({
    required this.title,
    required this.description,
    required this.imagePath,
    this.maxWidth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double width = maxWidth ?? (screenWidth > 800 ? 700 : screenWidth * 0.9);
    final bool isMobile = width < 600;

    // Define a clean, neutral TextStyle to avoid style inheritance
    const TextStyle descriptionTextStyle = TextStyle(
      fontSize: 14,
      color: Colors.black87,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none,
      backgroundColor: Colors.transparent,
    );

    const TextStyle titleTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.black,
      decoration: TextDecoration.none,
      backgroundColor: Colors.transparent,
    );

    return Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: isMobile
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset(imagePath, width: 50, height: 50)),
          const SizedBox(height: 10),
          Text(title, style: titleTextStyle),
          const SizedBox(height: 10),
          Text(description, style: descriptionTextStyle),
        ],
      )
          : Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Image.asset(imagePath, width: 50, height: 50),
              const SizedBox(height: 10),
              Text(title, style: titleTextStyle),
            ],
          ),
          const SizedBox(width: 40),
          Expanded(child: Text(description, style: descriptionTextStyle)),
        ],
      ),
    );
  }
}

// Card model
class BankingService {
  final String title;
  final String description;
  final String imagePath;

  BankingService({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}