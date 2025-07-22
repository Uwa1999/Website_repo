// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/buttons/footer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import '../../homepage/components/header_section.dart';
// import '../../shared/utils/responsive.dart';
// import '../../shared/widgets/animation.dart';
// import '../../shared/widgets/customCard.dart';
//
// class AlternativeDeliveriesSolution extends StatefulWidget {
//   static const String route = '/ADS';
//   const AlternativeDeliveriesSolution({Key? key}) : super(key: key);
//
//   @override
//   State<AlternativeDeliveriesSolution> createState() => _AlternativeDeliveriesSolutionState();
// }
//
// class _AlternativeDeliveriesSolutionState extends State<AlternativeDeliveriesSolution> with TickerProviderStateMixin {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     )..repeat(reverse: true);
//
//     _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       key: _scaffoldKey,
//       drawer: MediaQuery.of(context).size.width < 1024 ? const SideMenu() : null,
//       body: Column(
//         children: [
//           ResponsiveLayout(
//             mobile: NavSectionMobile(scaffoldKey: _scaffoldKey),
//             desktop: const HeaderSection(), tablet: Container(),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 30),
//                   Center(
//                     child: AnimatedGradientText(
//                       animation: _animation,
//                       text: "Alternative Deliveries Solution",
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Wrap(
//                     alignment: WrapAlignment.center,
//                     spacing: 20,
//                     runSpacing: 20,
//                     children: List.generate(
//                       5,
//                           (index) => CustomCardWidgetv2(
//                         description:
//                         'FinCloud Platform empowers financial institutions to seamlessly transition to a digital-first model. It offers a unified, API-driven solution that is easy to implement.',
//                         imagePath: 'assets/images/mono-temenos.png',
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 100),
//                   const FooterSectionv2(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/textwidget.dart';
// import 'package:flutter/material.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_section.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/animation.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/customCard.dart';
//
// import '../../shared/utils/responsive.dart';
// import '../../shared/widgets/buttons/footer.dart'; // Custom layout
//
// import 'package:flutter/material.dart';
//
// // Main widget
// class BankingTechnology extends StatelessWidget {
//   static const String route = '/bankingtechnology';
//   final double? cardWidth;
//
//   const BankingTechnology({Key? key, this.cardWidth}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final List<BankingService> services = [
//       BankingService(
//         title: 'FinCloud',
//         description:
//         'FinCloud Platform empowers financial institutions to seamlessly transition to a digital-first model. It offers a unified, API-driven solution that is easy to implement.',
//         imagePath: 'assets/images/fincloud1.png',
//       ),
//       BankingService(
//         title: 'Temenos',
//         description: 'Core Banking System specialize in localizing core banking systems.',
//         imagePath: 'assets/images/temenos1.png',
//       ),
//       BankingService(
//         title: 'MobCol',
//         description:
//         'The Mobile Collection System streamlines Account Officers’ monitoring by tracking locations, validating transactions, and handling cash receipts to enhance data accuracy, service delivery, and field performance.',
//         imagePath: 'assets/images/mobcol1.png',
//       ),
//       BankingService(
//         title: 'WebCol',
//         description:
//         'The Web Collection System compiles data and integrates with the Mobile Collection System to enable real-time monitoring and management of collection activities and field operations.',
//         imagePath: 'assets/images/webcol1.png',
//       ),
//       BankingService(
//         title: 'Open API',
//         description:
//         'Open banking uses APIs to securely share financial data with authorized third parties, enabling innovation while ensuring customer consent, privacy, and control.',
//         imagePath: 'assets/images/openapi1.png',
//       ),
//     ];
//
//     return Column(
//       children: [
//         const SizedBox(height: 60),
//         Center(child: GradientText(text: 'Banking Technology', gradient: LinearGradient(colors: [ Colors.black, Colors.redAccent, Colors.red], ),
//           style: const TextStyle(
//             fontSize: 50,
//
//             fontWeight: FontWeight.normal,
//             decoration: TextDecoration.none,
//             backgroundColor: Colors.transparent,
//           ),
//         ),
//         ),
//         const SizedBox(height: 10),
//         Container(
//           width: 150,
//           height: 40,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             border: Border.all(),
//           ),
//           child: const Center(
//             child: Text("5 services offered",
//               style: const TextStyle(
//               fontSize: 14,
//               color: Colors.black87,
//               fontWeight: FontWeight.normal,
//               decoration: TextDecoration.none,
//               backgroundColor: Colors.transparent,
//             ),),
//           ),
//         ),
//         const SizedBox(height: 30),
//         Expanded(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//             child: Center(
//               child: Wrap(
//                 alignment: WrapAlignment.center,
//                 spacing: 20,
//                 runSpacing: 20,
//                 children: services.map((service) {
//                   return CustomCardWidgetv2(
//                     title: service.title,
//                     description: service.description,
//                     imagePath: service.imagePath,
//                     maxWidth: cardWidth,
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // Animated gradient title
// // Card model
// class BankingService {
//   final String title;
//   final String description;
//   final String imagePath;
//
//   BankingService({
//     required this.title,
//     required this.description,
//     required this.imagePath,
//   });
// }
//
// // Card widget
// class CustomCardWidgetv2 extends StatelessWidget {
//   final String title;
//   final String description;
//   final String imagePath;
//   final double? maxWidth;
//
//   const CustomCardWidgetv2({
//     required this.title,
//     required this.description,
//     required this.imagePath,
//     this.maxWidth,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double width = maxWidth ?? (screenWidth > 800 ? 700 : screenWidth * 0.9);
//     final bool isMobile = width < 600;
//
//     // Define a clean, neutral TextStyle to avoid style inheritance
//     const TextStyle descriptionTextStyle = TextStyle(
//       fontSize: 14,
//       color: Colors.black87,
//       fontWeight: FontWeight.normal,
//       decoration: TextDecoration.none,
//       backgroundColor: Colors.transparent,
//     );
//
//     const TextStyle titleTextStyle = TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: 18,
//       color: Colors.black,
//       decoration: TextDecoration.none,
//       backgroundColor: Colors.transparent,
//     );
//
//     return Container(
//       width: width,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(16),
//         color: Colors.white,
//         boxShadow: const [
//           BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
//         ],
//       ),
//       child: isMobile
//           ? Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Center(child: Image.asset(imagePath, width: 50, height: 50)),
//           const SizedBox(height: 10),
//           Text(title, style: titleTextStyle),
//           const SizedBox(height: 10),
//           Text(description, style: descriptionTextStyle),
//         ],
//       )
//           : Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Column(
//             children: [
//               Image.asset(imagePath, width: 50, height: 50),
//               const SizedBox(height: 10),
//               Text(title, style: titleTextStyle),
//             ],
//           ),
//           const SizedBox(width: 40),
//           Expanded(child: Text(description, style: descriptionTextStyle)),
//         ],
//       ),
//     );
//   }
// }

import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/animation.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/customCard.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/buttons/footer.dart';

import '../../shared/utils/responsive.dart';

class AlternativeDeliveriesSolution extends StatefulWidget {
  static const String route = '/ADS';
  final double? cardWidth;

  const AlternativeDeliveriesSolution({Key? key, this.cardWidth}) : super(key: key);

  @override
  State<AlternativeDeliveriesSolution> createState() => _AlternativeDeliveriesSolutionState();
}

class _AlternativeDeliveriesSolutionState extends State<AlternativeDeliveriesSolution> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<BankingService> services = [
    BankingService(
      title: 'Kplus',
      description:
      'FinCloud Platform empowers financial institutions to seamlessly transition to a digital-first model. It offers a unified, API-driven solution that is easy to implement.',
      imagePath: 'assets/images/kplus1.png',
    ),
    BankingService(
      title: 'DCM',
      description: 'Within the CM software, users can initiate self-service withdrawals through a Digital Cash Machine (DCM) using a QR code generated by the app.',
      imagePath: 'assets/images/dcm1.png',
    ),
    BankingService(
      title: 'Konek2CARD',
      description:
      'The konek2CARD mobile app offers convenient, user-friendly banking for all users. Clients can easily monitor savings, transfer funds, repay loans, check transactions, and access mini statements anytime, anywhere.',
      imagePath: 'assets/images/konek2CARD1.png',
    ),
    BankingService(
      title: 'ATM Switch',
      description:
      'The FDSAP ATM Switch is designed to efficiently route and process ATM transactions by virtually connecting input and output ports.',
      imagePath: 'assets/images/atmswitch1.png',
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
                      text: 'Alternative Deliveries Solution',
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