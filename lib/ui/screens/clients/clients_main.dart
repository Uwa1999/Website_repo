import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/insights_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../shared/widgets/animation.dart';
import '../shared/widgets/buttons/textandimage_widget.dart';
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
    return Container(
      color: Colors.black,
      child: SingleChildScrollView(  // Add scrolling to avoid overflow on smaller screens
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                const Text(
                  'Come and Join us using our',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 730.0, top: 5.0),
                  child: AnimatedGradientText(
                    animation: _animation,
                    text: "all in one",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:940.0, bottom: 40.0),
                  child: Container(width:30, height:30,child: Image(image: AssetImage('assets/images/twinkling2.png')))
                ),
                Padding(
                    padding: const EdgeInsets.only(left:740.0, top: 80.0),
                    child: Container(width:30, height:30,child: Image(image: AssetImage('assets/images/twinkling1.png')))
                ),
              ],
            ),
            // const SizedBox(height: ),
            const Text(
              'banking tech solution.',
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
            
            const SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fintect',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _imageContainer('assets/images/ag-bank-emoney.png', 100, 100),
                          const Spacer(),
                          _imageContainer('assets/images/bank-bpd-bali-emoney.png', 190, 190),
                          const Spacer(),
                          _imageContainer('assets/images/bank-kalsel-emoney.png', 150, 150),
                          const Spacer(),
                          _imageContainer('assets/images/bank-sahabat.png', 150, 150),
                          const Spacer(),
                          _imageContainer('assets/images/banking-tech.png', 150, 150),
                          const Spacer(),
                          _imageContainer('assets/images/IMkas.png', 150, 150),
                          const Spacer(),
                          _imageContainer('assets/images/ottocash.png', 150, 150),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _imageContainer('assets/images/ottokonek.png', 150, 150),
                          const SizedBox(width: 60),
                          _imageContainer('assets/images/ottopayv2.png', 200, 200),
                          const SizedBox(width: 60),
                          _imageContainer('assets/images/pac-cash.png', 150, 150),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Financial Inclusion',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _imageContainer('assets/images/bank-bpd-bali-emoney.png', 190, 190),
                          const Spacer(),
                          _imageContainer('assets/images/bank-ina.png', 150, 150),
                          const Spacer(),
                          _imageContainer('assets/images/bank-jambi.png', 150, 150),
                          const Spacer(),
                          _imageContainer('assets/images/bank-kalsel-emoney.png', 150, 150),
                          const Spacer(),
                          _imageContainer('assets/images/bank-mas.png', 150, 150),
                          const Spacer(),
                          _imageContainer('assets/images/bank-ntt.png', 150, 150),
                        ],
                      ),
                      // const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _imageContainer('assets/images/bank-sulsebar.png', 150, 150),
                          const SizedBox(width: 60),
                          _imageContainer('assets/images/card-bank.png', 200, 200),
                          const SizedBox(width: 60),
                          _imageContainer('assets/images/card-rbi.png', 150, 150),
                          const SizedBox(width: 60),
                          _imageContainer('assets/images/card-sme.png', 150, 150),
                          //nrb-global-bank
                          const SizedBox(width: 60),
                          _imageContainer('assets/images/nrb-global-bank.png', 150, 150),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'MFIs',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _imageContainer('assets/images/bank-bpd-bali-emoney.png', 190, 190),
                          const Spacer(),
                          _imageContainer('assets/images/bank-ina.png', 150, 150),
                          const Spacer(),
                          _imageContainer('assets/images/bank-jambi.png', 150, 150),
                          const Spacer(),
                          _imageContainer('assets/images/bank-kalsel-emoney.png', 150, 150),
                          const Spacer(),
                          _imageContainer('assets/images/bank-mas.png', 150, 150),
                          const Spacer(),
                          _imageContainer('assets/images/bank-ntt.png', 150, 150),
                        ],
                      ),
                      // const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _imageContainer('assets/images/bank-sulsebar.png', 150, 150),
                          const SizedBox(width: 60),
                          _imageContainer('assets/images/card-bank.png', 200, 200),
                          const SizedBox(width: 60),
                          _imageContainer('assets/images/card-rbi.png', 150, 150),
                          const SizedBox(width: 60),
                          _imageContainer('assets/images/card-sme.png', 150, 150),
                          //nrb-global-bank
                          const SizedBox(width: 60),
                          _imageContainer('assets/images/nrb-global-bank.png', 150, 150),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageContainer(String assetPath, double width, double height) {
    return Container(
      width: width,
      height: height,
      child: Image.asset(assetPath),
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
