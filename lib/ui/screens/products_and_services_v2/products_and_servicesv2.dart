import 'package:flutter/material.dart';
import '../shared/utils/responsive.dart';
import '../shared/widgets/customCard.dart';

class ProductsAndServicesV2 extends StatefulWidget {
  static const String route = '/PAS';
  const ProductsAndServicesV2({Key? key}) : super(key: key);

  @override
  State<ProductsAndServicesV2> createState() => _ProductsAndServicesV2State();
}

class _ProductsAndServicesV2State extends State<ProductsAndServicesV2> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    // Adjust image width
    final imageWidth = isMobile ? 800.0 : screenWidth * 0.8;

    // Image aspect ratio (adjust based on your image)
    final imageAspectRatio = 3 / 1; // Example: 3 width : 1 height
    final imageHeight = imageWidth / imageAspectRatio;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ResponsiveLayout(
          mobile: _buildMobileLayout(),
          tablet: _buildTabletLayout(),
          desktop: _buildDesktopLayout(),
        ),
        Positioned(
          top: -imageHeight * 1.25,
          left: (MediaQuery.of(context).size.width - imageWidth) / 2,
          child: Center(
            child: Image.asset(
              'assets/images/phone-web.png',
              width: imageWidth,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(textSize: 70, paddingLeft: 100),
        _buildCardsLayout(width: 1500),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(textSize: 50, paddingLeft: 40),
          _buildCardsLayout(width: 800),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(textSize: 30, paddingLeft: 20),
          _buildCardsLayout(width: double.infinity, isMobile: true),
        ],
      ),
    );
  }

  Widget _buildHeader({required double textSize, required double paddingLeft}) {
    return Container(
      color: const Color(0xffFAFAFA),
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(left: paddingLeft, bottom: 50, top: 100),
        child: Text(
          'Our Products and Services',
          style: TextStyle(fontSize: textSize, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildCardsLayout({required double width, bool isMobile = false}) {
    return Container(
      color: const Color(0xffFAFAFA),
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            width: width,
            // height: 400,
            child: CustomCardWidget(
              title: 'Banking Technology',
              description: isMobile
                  ? 'Our secure, scalable SaaS banking solutions enable financial institutions to modernize their operations, enhance efficiency, and expand their outreach —delivering world-class banking experiences through real-time data, streamlined field processes, and third-party integration. These tools support inclusive finance while ensuring compliance, data privacy, and service excellence.'
                  : 'Our secure, scalable SaaS banking solutions enable financial institutions to modernize their operations, enhance efficiency, and expand their outreach —delivering world-class banking experiences through real-time data, streamlined field processes, and third-party integration. These tools support inclusive finance while ensuring compliance, data privacy, and service excellence.',
              buttonLabels: ['FinCloud', 'Temenos', 'Mobile Collection', 'We Collection','Open API'],
              imagePath: 'assets/images/banking-tech.png',
              onMainActionPressed: () => Navigator.pushNamed(context, '/bankingtechnology'),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: width,
            child: CustomCardWidget(
              title: 'Alternative Deliveries Solution',
              description: isMobile
                  ? 'We provide mobile apps, digital wallets, and self-service tools that make banking more accessible, especially in underserved areas. These reliable, user-friendly channels enable seamless transactions, real-time account access, and broader financial inclusion.'
                  : 'We provide mobile apps, digital wallets, and self-service tools that make banking more accessible, especially in underserved areas. These reliable, user-friendly channels enable seamless transactions, real-time account access, and broader financial inclusion.',
              buttonLabels: ['Kplus', 'Konek2CARD', 'ATM Switch', 'DCM'],
              imagePath: 'assets/images/alternative-deliveries-solution.png',
              onMainActionPressed: () => Navigator.pushNamed(context, '/ADS'),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: width,
            child: CustomCardWidget(
              title: 'Regulatory and Services',
              description: isMobile
                  ? 'Our security solutions ensure compliance and protect against fraud and cyber threats. With AML tools and risk intelligence systems like World-Check, institutions can operate with transparency, safeguard data, and maintain client trust.'
                  : 'Our security solutions ensure compliance and protect against fraud and cyber threats. With AML tools and risk intelligence systems like World-Check, institutions can operate with transparency, safeguard data, and maintain client trust.',
              buttonLabels: ['Cyber Security', 'Fraud Detection', 'ATM'],
              imagePath: 'assets/images/regulatory-and-services.png',
              onMainActionPressed: () => Navigator.pushNamed(context, '/MfisPage'),
            ),
          ),
        ],
      ),
    );
  }
}