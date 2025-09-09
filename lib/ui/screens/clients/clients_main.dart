import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/insights_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../shared/utils/dataModel.dart';
import '../shared/widgets/animation.dart';
import '../shared/widgets/buttons/textandimage_widget.dart';
import '../shared/widgets/photoClients.dart';
///old
// class ClientsList extends StatelessWidget {
//   static const String route = '/ClientsList';
//   const ClientsList({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//   color: Colors.black,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             alignment: Alignment.centerLeft,
//             children: [
//               const Text(
//                 'Come and Join us using our',
//                 style: TextStyle(
//                   fontSize: 50,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w400,
//                   height: 1.4,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 370.0, top: 60.0),
//                 child: AnimatedGradientText(
//                   animation: _animation,
//                   text: "all in one",
//                 ),
//               ),
//             ],
//           ),
//
//           Text('all-in-one banking tech solution.', style: TextStyle(
//             fontSize: 50,
//             color: Colors.white,
//             fontWeight: FontWeight.w400,
//             height: 1.4,
//           ),),
//           const SizedBox(height: 40),
//           // TitleWithImageList(
//           //   title: 'Fintech',
//           //   imagePaths: [
//           //     'assets/images/ag-bank-emoney.png',
//           //     'assets/images/ag-bank-emoney.png',
//           //     'assets/images/ag-bank-emoney.png',
//           //     'assets/images/ag-bank-emoney.png',
//           //     'assets/images/ag-bank-emoney.png',
//           //     'assets/images/ag-bank-emoney.png',
//           //   ],
//           // ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//             Text('Fintect',style: TextStyle(color: Colors.white,fontSize: 40, fontWeight: FontWeight.bold),),
//             Padding(
//               padding: const EdgeInsets.only(left: 120, right: 120),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                           width: 150,
//                           height: 150,
//                           child: Image(image: AssetImage('assets/images/ag-bank-emoney.png'))),
//                       Spacer(),
//                       Container(
//                           width: 190,
//                           height: 190,
//                           child: Image(image: AssetImage('assets/images/bank-bpd-bali-emoney.png'))),
//                       Spacer(),
//                       Container(
//                           width: 150,
//                           height: 150,
//                           child: Image(image: AssetImage('assets/images/bank-kalsel-emoney.png'))),
//                       Spacer(),
//                       Container(
//                           width: 150,
//                           height: 150,
//                           child: Image(image: AssetImage('assets/images/bank-sahabat.png'))),
//                       Spacer(),
//                       Container(
//                           width: 150,
//                           height: 150,
//                           child: Image(image: AssetImage('assets/images/banking-tech.png'))),
//                       Spacer(),
//                       Container(
//                           width: 150,
//                           height: 150,
//                           child: Image(image: AssetImage('assets/images/IMkas.png'))),
//                       Spacer(),
//                       Container(
//                           width: 150,
//                           height: 150,
//                           child: Image(image: AssetImage('assets/images/ottocash.png'))),
//                     ],
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                           width: 150,
//                           height: 150,
//                           child: Image(image: AssetImage('assets/images/ottokonek.png'))),
//                       SizedBox(width: 60,),
//                       Container(
//                           width: 200,
//                           height: 200,
//                           child: Image(image: AssetImage('assets/images/ottopayv2.png'))),
//                      SizedBox(width: 60,),
//                       Container(
//                           width: 150,
//                           height: 150,
//                           child: Image(image: AssetImage('assets/images/pac-cash.png'))),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//
//             ],
//           ),
//
//           TitleWithImageList(
//             title: 'Financial Inclusion',
//             imagePaths: [
//             'assets/images/ag-bank-emoney.png',
//             'assets/images/ag-bank-emoney.png',
//             'assets/images/ag-bank-emoney.png',
//             'assets/images/ag-bank-emoney.png',
//             'assets/images/ag-bank-emoney.png',
//             'assets/images/ag-bank-emoney.png',
//               // 'assets/logos/fas_cash.png',
//               // 'assets/logos/ottopay.png',
//               // 'assets/logos/ottocash.png',
//               // 'assets/logos/bank_ag.png',
//               // 'assets/logos/sobatku.png',
//               // 'assets/logos/bank_kalsel.png',
//             ],
//           ),
//
//           TitleWithImageList(
//             title: 'MFIs',
//             imagePaths: [
//               'assets/images/ag-bank-emoney.png',
//               'assets/images/ag-bank-emoney.png',
//               'assets/images/ag-bank-emoney.png',
//               'assets/images/ag-bank-emoney.png',
//               'assets/images/ag-bank-emoney.png',
//               'assets/images/ag-bank-emoney.png',
//               // 'assets/logos/fas_cash.png',
//               // 'assets/logos/ottopay.png',
//               // 'assets/logos/ottocash.png',
//               // 'assets/logos/bank_ag.png',
//               // 'assets/logos/sobatku.png',
//               // 'assets/logos/bank_kalsel.png',
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//

class ClientsList extends StatefulWidget {
  static const String route = '/ClientsList';
  const ClientsList({Key? key}) : super(key: key);

  @override
  State<ClientsList> createState() => _ClientsListState();
}

class _ClientsListState extends State<ClientsList> with SingleTickerProviderStateMixin {
  late Future<List<ClientSection>> _clientSectionsFuture;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _clientSectionsFuture = fetchClientData();
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

  Future<List<ClientSection>> fetchClientData() async {
    try {
      final response = await http.get(
        Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/images/sections'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> sectionsJson = data['data'] as List<dynamic>;
        return sectionsJson.map((json) => ClientSection.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Failed to load client data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the API: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: FutureBuilder<List<ClientSection>>(
        future: _clientSectionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No client data available.', style: TextStyle(color: Colors.white)));
          } else {
            final clientSections = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderSection(),
                    const SizedBox(height: 40),
                    ...clientSections.map((section) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: _buildCategorySection(
                          title: section.sectionName,
                          logos: section.logos,
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildHeaderSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final fontSize = isMobile ? 30.0 : 50.0;

    final baseTextStyle = TextStyle(
      fontSize: fontSize,
      color: Colors.white,
      fontWeight: FontWeight.w400,
      height: 1.4,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobileLayout = width < 600;

        if (isMobileLayout) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Come and Join us', style: baseTextStyle),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('using our ', style: baseTextStyle),
                  // Assuming AnimatedGradientText is a valid widget
                  // AnimatedGradientText(
                  //   animation: _animation,
                  //   text: 'all-in-one',
                  //   fontSize: fontSize,
                  // ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset('assets/images/twinkling2.png'),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('banking tech solution.', style: baseTextStyle),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset('assets/images/twinkling1.png'),
                  ),
                ],
              ),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 4,
                children: [
                  Text('Come and Join us using our', style: baseTextStyle),
                  // AnimatedGradientText(
                  //   animation: _animation,
                  //   text: 'all-in-one',
                  //   fontSize: fontSize,
                  // ),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset('assets/images/twinkling2.png'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 4,
                children: [
                  Text('banking tech solution.', style: baseTextStyle),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset('assets/images/twinkling1.png'),
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildCategorySection({
    required String title,
    required List<String> logos,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        isMobile
        // Restored the AutoScrollWidgetScroller for mobile view
            ? AutoScrollWidgetScroller(
          height: 100,
          itemWidth: 120,
          spacing: 24,
          scrollDelay: const Duration(seconds: 2),
          scrollDuration: const Duration(milliseconds: 800),
          items: logos.map((logo) {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Image.network(
                  logo,
                  fit: BoxFit.contain,
                  height: 80,
                  width: 120,
                ),
              ),
            );
          }).toList(),
        )
            : Wrap(
          spacing: 30,
          runSpacing: 20,
          children: logos.map((logo) {
            double logoSize = 120;
            // Dynamic sizing based on a specific image name, if necessary
            // if (logo.contains('bank-bpd-bali-emoney.png')) logoSize = 100;
            // if (logo.contains('ottopayv2.png')) logoSize = 100;
            // if (logo.contains('card-bank.png')) logoSize = 100;

            return SizedBox(
              width: logoSize,
              height: logoSize,
              child: Image.network(logo, fit: BoxFit.contain),
            );
          }).toList(),
        ),
      ],
    );
  }
}




// class ClientsList extends StatelessWidget {
//     static const String route = '/ClientsList';
//   const ClientsList({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 1000,
//       height: 1000,
//       color: Colors.red,
//     );
//   }
// }