// Stack(
// children: [
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Container(
// color: Color(0xffFAFAFA),
// width: 2000,
// child: Padding(
// padding: const EdgeInsets.only(left: 100.0, bottom: 50,top: 100),
// child: Text('Our Products and Services', style: TextStyle(fontSize: 70, color: Colors.black,)),
// ),
// ),
// Container(
// color: Color(0xffFAFAFA),
// width: 2000,
// key: navItems[2].key,
// child: Column(
// children: [
// // Container(
// //   width: 1500,
// //   child: CustomCardWidget(
// //     title: 'Banking Technology',
// //     description: 'Our secure, scalable SaaS banking solutions enable financial institutions to modernize their operations, enhance efficiency, and expand their outreach —delivering world-class banking experiences through real-time data, streamlined field processes, and third-party integration. These tools support inclusive finance while ensuring compliance, data privacy, and service excellence.',
// //     buttonLabels: ['Mobile Collection','Web Collection','Core Banking System'],
// //     onButtonPressed: [
// //     ], imagePath: 'assets/images/banking-tech.png',
// //
// //   ),
// // ),
// Container(
// width: 1500,
// child: CustomCardWidget(
// title: 'Banking Technology',
// description:
// 'Our secure, scalable SaaS banking solutions enable financial institutions to modernize their operations, enhance efficiency, and expand their outreach —delivering world-class banking experiences through real-time data, streamlined field processes, and third-party integration. These tools support inclusive finance while ensuring compliance, data privacy, and service excellence.',
// buttonLabels: ['Mobile Collection', 'Web Collection', 'Core Banking System'],
// imagePath: 'assets/images/banking-tech.png',
// // onMainActionPressed: (){
// //   Navigator.pushReplacementNamed(context, FinTechPage.route);
// // },
// onMainActionPressed: () {
// final context = navItems[2].key.currentContext;
// if (context != null) {
// Scrollable.ensureVisible(
// context,
// duration: const Duration(milliseconds: 500),
// curve: Curves.easeInOut,
// );
// }
// // Navigator.pushReplacementNamed(context!, FinTechPage.route);
// Navigator.pushNamed(context!, '/Fintech');
// },
//
// ),
// ),
//
// SizedBox(height: 10,),
// Container(
// width: 1500,
// child: CustomCardWidget(
// title: 'Alternative Deliveries Solution',
// description: 'We provide mobile apps, digital wallets, and self-service tools that make banking more accessible, especially in underserved areas. These reliable, user-friendly channels enable seamless transactions, real-time account access, and broader financial inclusion.',
// buttonLabels: ['Kplus','Konek2CARD','ATM Switch','DCM'],
// onButtonPressed: [
// ], imagePath: 'assets/images/alternative-deliveries-solution.png',
// onMainActionPressed: () {
// final context = navItems[2].key.currentContext;
// if (context != null) {
// Scrollable.ensureVisible(
// context,
// duration: const Duration(milliseconds: 500),
// curve: Curves.easeInOut,
// );
// }
// // Navigator.pushReplacementNamed(context!, FinTechPage.route);
// Navigator.pushNamed(context!, '/ADS');
// },
// ),
// ),
// SizedBox(height: 10,),
// Container(
// width: 1500,
// child: CustomCardWidget(
// title: 'Regulatory and Services',
// description: 'Our security solutions ensure compliance and protect against fraud and cyber threats. With AML tools and risk intelligence systems like World-Check, institutions can operate with transparency, safeguard data, and maintain client trust.',
// buttonLabels: ['Cyber Security','Fraud Detection','ATM'],
// onButtonPressed: [
//
// ], imagePath: 'assets/images/regulatory-and-services.png',
// ),
// ),
// ],
// ),
// ),
//
// Container(
// key: navItems[3].key,
// child: ClientsList(),
// )
// ],
// ),
//
// ],
// ),

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../shared/widgets/products_and _services_v2.dart';

class ProductsAndServicesV2 extends StatefulWidget {
  static const String route = '/PAS';
  const ProductsAndServicesV2({Key? key}) : super(key: key);

  @override
  State<ProductsAndServicesV2> createState() => _ProductsAndServicesV2State();
}

class _ProductsAndServicesV2State extends State<ProductsAndServicesV2> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final maxContentWidth = 1200.0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: const Color(0xffFAFAFA),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 40, top: 80),
              child: Text(
                'Our Products and Services',
                style: TextStyle(
                  fontSize: screenWidth < 600 ? 32 : 60,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(
            color: const Color(0xffFAFAFA),
            width: double.infinity,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxContentWidth),
                child: Column(
                  children: [
                    CustomCardWidget(
                      title: 'Banking Technology',
                      description:
                      'Our secure, scalable SaaS banking solutions enable financial institutions to modernize their operations...',
                      buttonLabels: [
                        'Mobile Collection',
                        'Web Collection',
                        'Core Banking System'
                      ],
                      imagePath: 'assets/images/banking-tech.png',
                      onMainActionPressed: () {
                        Navigator.pushNamed(context, '/Fintech');
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomCardWidget(
                      title: 'Alternative Deliveries Solution',
                      description:
                      'We provide mobile apps, digital wallets, and self-service tools...',
                      buttonLabels: [
                        'Kplus',
                        'Konek2CARD',
                        'ATM Switch',
                        'DCM'
                      ],
                      imagePath: 'assets/images/alternative-deliveries-solution.png',
                      onMainActionPressed: () {
                        Navigator.pushNamed(context, '/ADS');
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomCardWidget(
                      title: 'Regulatory and Services',
                      description:
                      'Our security solutions ensure compliance and protect against fraud...',
                      buttonLabels: [
                        'Cyber Security',
                        'Fraud Detection',
                        'ATM'
                      ],
                      imagePath: 'assets/images/regulatory-and-services.png',
                      onMainActionPressed: () {
                        Navigator.pushNamed(context, '/MfisPage');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

