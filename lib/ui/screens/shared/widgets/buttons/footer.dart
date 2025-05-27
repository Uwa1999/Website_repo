///v1
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// class FooterSectionv2 extends StatelessWidget {
//   const FooterSectionv2({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black,
//       padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Logos
//           Wrap(
//             alignment: WrapAlignment.center,
//             spacing: 30,
//             runSpacing: 20,
//             children: const [
//               FlutterLogo(size: 40),
//               FlutterLogo(size: 40),
//               FlutterLogo(size: 40),
//               ///images o logo
//             ],
//           ),
//           const SizedBox(height: 40),
//           // Links Row
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: const [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Privacy Policy", style: TextStyle(color: Colors.white, decoration: TextDecoration.underline)),
//                   SizedBox(height: 8),
//                   Text("Manage Cookies", style: TextStyle(color: Colors.white, decoration: TextDecoration.underline)),
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text("Back to Top ↑", style: TextStyle(color: Colors.white, decoration: TextDecoration.underline)),
//                   SizedBox(height: 8),
//                   Text("Terms and Conditions", style: TextStyle(color: Colors.white, decoration: TextDecoration.underline)),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 40),
//           // Central Message
//           const Center(
//             child: Text(
//               "We Listen.\nWe Anticipate.\nWe Deliver.",
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.white, fontSize: 24, height: 1.5),
//             ),
//           ),
//           const SizedBox(height: 40),
//           // White Bottom Container with curved edges
//           Container(
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Contact Info
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Row(
//                           children: [
//                             Icon(Icons.phone, size: 16),
//                             SizedBox(width: 8),
//                             Text('+63 919 098 6970'),
//                           ],
//                         ),
//                         SizedBox(height: 12),
//                         Row(
//                           children: [
//                             Icon(FontAwesomeIcons.facebook, size: 16),
//                             SizedBox(width: 8),
//                             Text('FDS Asya Philippines Inc.'),
//                           ],
//                         ),
//                         SizedBox(height: 12),
//                         Row(
//                           children: [
//                             Icon(FontAwesomeIcons.linkedin, size: 16),
//                             SizedBox(width: 8),
//                             Text('FDS Asya Philippines Inc.'),
//                           ],
//                         ),
//                       ],
//                     ),
//                     // Address
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: const [
//                         Text('G/F 1519 D. Oliman St., Valenzuela, Makati City'),
//                         Text('G/F 1519 D. Oliman St., Valenzuela, Makati City'),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 30),
//                 const Text("©FDSAP 2025", style: TextStyle(fontSize: 12)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


///v2
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// class FooterSectionv2 extends StatelessWidget {
//   const FooterSectionv2({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     const whiteText = TextStyle(color: Colors.white, fontSize: 14);
//     const linkText = TextStyle(
//       color: Colors.white,
//       decoration: TextDecoration.underline,
//       fontSize: 14,
//     );
//
//     return Column(
//       children: [
//         // Black background section
//         Container(
//           color: Colors.black,
//           padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // Logos row
//               Wrap(
//                 alignment: WrapAlignment.center,
//                 spacing: 30,
//                 runSpacing: 20,
//                 children: [
//                   _buildLogoPlaceholder(),
//                   _buildLogoPlaceholder(),
//                   _buildLogoPlaceholder(),
//                   _buildTextLogo("OTTOTPAY"),
//                   _buildTextLogo("AG\nBank Artha Graha"),
//                   _buildTextLogo("SOBATKU\nSimpanan Online Sahabatku"),
//                   _buildTextLogo("Bank Kalsel\nSetia Melayani, Melaju Bersama"),
//                   _buildTextLogo("OTTOCASH"),
//                 ],
//               ),
//               const SizedBox(height: 40),
//               // Links row
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Privacy Policy', style: linkText),
//                       SizedBox(height: 8),
//                       Text('Manage Cookies', style: linkText),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text('Back to Top ↑', style: linkText),
//                       SizedBox(height: 8),
//                       Text('Terms and Conditions', style: linkText),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 40),
//               // Center text
//               const Text(
//                 'We Listen.\nWe Anticipate.\nWe Deliver.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   height: 1.6,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//
//         // White bottom section
//         Container(
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Contact and Address
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Contact section
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       _ContactRow(
//                         icon: Icons.phone,
//                         text: '+63 919 098 6970',
//                       ),
//                       SizedBox(height: 12),
//                       _ContactRow(
//                         icon: FontAwesomeIcons.facebookF,
//                         text: 'FDS Asya Philippines Inc.',
//                       ),
//                       SizedBox(height: 12),
//                       _ContactRow(
//                         icon: FontAwesomeIcons.linkedinIn,
//                         text: 'FDS Asya Philippines Inc.',
//                       ),
//                     ],
//                   ),
//                   // Address
//                   const Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text('G/F 1519 D. Oliman St., Valenzuela, Makati City'),
//                       SizedBox(height: 8),
//                       Text('G/F 1519 D. Oliman St., Valenzuela, Makati City'),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 30),
//               const Center(
//                 child: Text(
//                   '©FDSAP 2025',
//                   style: TextStyle(fontSize: 12, color: Colors.black54),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   // Placeholder widget for logos
//   Widget _buildLogoPlaceholder() {
//     return Container(
//       width: 48,
//       height: 48,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: const Center(
//         child: Icon(Icons.image, size: 24),
//       ),
//     );
//   }
//
//   // Text logo block
//   Widget _buildTextLogo(String text) {
//     return Text(
//       text,
//       textAlign: TextAlign.center,
//       style: const TextStyle(color: Colors.white, fontSize: 12),
//     );
//   }
// }
//
// class _ContactRow extends StatelessWidget {
//   final IconData icon;
//   final String text;
//
//   const _ContactRow({required this.icon, required this.text});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon, size: 14, color: Colors.black),
//         const SizedBox(width: 8),
//         Text(text, style: const TextStyle(fontSize: 14)),
//       ],
//     );
//   }
// }
//

///v3
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui_web' as ui;

import '../photoClients.dart';
//
// class FooterSectionv2 extends StatelessWidget {
//   const FooterSectionv2({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     const whiteText = TextStyle(color: Colors.white, fontSize: 14);
//     const linkText = TextStyle(
//       color: Colors.white,
//       decoration: TextDecoration.underline,
//       fontSize: 20,
//     );
//     return Stack(
//       children: [
//         // Black background section
//         Container(
//           color: Colors.black,
//           // padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // Logos row
//               const SizedBox(height: 40),
//               AutoScrollWidgetScroller(
//                 height: 80,
//                 itemWidth: 120,
//                 spacing: 24,
//                 scrollDelay: const Duration(seconds: 2),
//                 scrollDuration: const Duration(milliseconds: 800),
//                 items: [
//                   Image.asset('assets/images/bank-kalsel-emoney.png'),
//                   Image.asset('assets/images/ag-bank-emoney.png'),
//                   Image.asset('assets/images/bank-bpd-bali-emoney.png'),
//                   Image.asset('assets/images/bank-sahabat.png'),
//                   Image.asset('assets/images/banking-tech.png'),
//                   Image.asset('assets/images/IMkas.png'),
//                   Image.asset('assets/images/ottocash.png'),
//                   Image.asset('assets/images/ottokonek.png'),
//                   Image.asset('assets/images/ottopayv2.png'),
//                   Image.asset('assets/images/pac-cash.png'),
//                   Image.asset('assets/images/bank-bpd-bali-emoney.png'),
//                   Image.asset('assets/images/bank-ina.png'),
//                   Image.asset('assets/images/bank-jambi.png'),
//                   Image.asset('assets/images/bank-kalsel-emoney.png'),
//                   //
//                   Image.asset('assets/images/bank-kalsel-emoney.png'),
//                   Image.asset('assets/images/ag-bank-emoney.png'),
//                   Image.asset('assets/images/bank-bpd-bali-emoney.png'),
//                   Image.asset('assets/images/bank-sahabat.png'),
//                   Image.asset('assets/images/banking-tech.png'),
//                   Image.asset('assets/images/IMkas.png'),
//                   Image.asset('assets/images/ottocash.png'),
//                   Image.asset('assets/images/ottokonek.png'),
//                   Image.asset('assets/images/ottopayv2.png'),
//                   Image.asset('assets/images/pac-cash.png'),
//                   Image.asset('assets/images/bank-bpd-bali-emoney.png'),
//                   Image.asset('assets/images/bank-ina.png'),
//                   Image.asset('assets/images/bank-jambi.png'),
//                   Image.asset('assets/images/bank-kalsel-emoney.png'),
//
//                 ].map((logo) {
//                   return Center(
//                     child: Container(
//                       padding: const EdgeInsets.all(8),
//                       child: logo,
//                     ),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 40),
//               // Links row
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.center,
//               //   children:  [
//               //     Center(child: Image(image: AssetImage('assets/images/fdsap_logo_white.png', ),width: 100, height: 100,)),
//               //     Padding(
//               //       padding: EdgeInsets.only(left: 1000),
//               //         child: Text('Privacy Policy', style: linkText)),
//               //     SizedBox(height: 8),
//               //     Text('Manage Cookies', style: linkText),
//               //     Column(
//               //       crossAxisAlignment: CrossAxisAlignment.end,
//               //       children: [
//               //         // Text('Back to Top ↑', style: linkText),
//               //         SizedBox(height: 8),
//               //         Text('Terms and Conditions', style: linkText),
//               //       ],
//               //     ),
//               //   ],
//               // ),
//               Stack(
//                   children:[
//                     Padding(
//                       padding: const EdgeInsets.only(left: 100, top: 100),
//                       child: Column(
//                         children: [
//                           Text('Privacy Policy',style: linkText),
//                           Text('Manage Cookies', style: linkText),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 1250, top: 100),
//                       child: Text('Terms and Conditions', style: linkText),
//                     ),
//                     Center(
//                       child: Container(
//                         child: Image.asset(
//                           'assets/images/fdsap_logo_white.png',
//                           width: 200,
//                           fit: BoxFit.contain,
//                           // height: 1000,
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(height: 40),
//
//                     // Center text
//                     // Padding(
//                     //   padding: const EdgeInsets.only(top: 250),
//                     //   child: Center(
//                     //     child: const Text(
//                     //       'We Listen.\nWe Anticipate.\nWe Deliver.',
//                     //       textAlign: TextAlign.center,
//                     //       style: TextStyle(
//                     //         color: Colors.white,
//                     //         fontSize: 24,
//                     //         height: 1.6,
//                     //         fontWeight: FontWeight.w500,
//                     //       ),
//                     //     ),
//                     //   ),
//                     // ),
//                     Stack(
//                       children: [
//                         ClipPath(
//                           clipper: NotchedClipper(),
//                           child: Container(
//                             height: 200,
//                             color: Color(0xffffffff),
//                           ),
//                         ),
//                         Positioned(
//                           top: 30, // Adjust to center vertically inside the notch
//                           left: 0,
//                           right: 0,
//                           child: Center(
//                             child: Text(
//                               'We Listen.\nWe Anticipate.\nWe Deliver.',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//
//                   ]
//               ),
//
//             ],
//           ),
//         ),
//
//         // Curved white top section (custom painter)
//         // Padding(
//         //   padding: const EdgeInsets.only(top: 500),
//         //   child: SizedBox(
//         //     height: 500,
//         //     width: double.infinity,
//         //     child: ClipPath(
//         //       clipper: NotchedClipper(),
//         //       child: Container(
//         //         color: Colors.grey.shade300,
//         //       height: 60,
//         //       // decoration: BoxDecoration(
//         //       // // borderRadius: const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
//         //       //
//         //       // ),
//         //       ),
//         //     ),
//         //   ),
//         // ),
//
//         // White content
//         // Container(
//         //   width: double.infinity,
//         //   color: Colors.white,
//         //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
//         //   child: Column(
//         //     crossAxisAlignment: CrossAxisAlignment.start,
//         //     children: [
//         //       // Contact and Address
//         //       Row(
//         //         crossAxisAlignment: CrossAxisAlignment.start,
//         //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //         children: [
//         //           // Contact section
//         //           Column(
//         //             crossAxisAlignment: CrossAxisAlignment.start,
//         //             children: const [
//         //               _ContactRow(
//         //                 icon: Icons.phone,
//         //                 text: '+63 919 098 6970',
//         //               ),
//         //               SizedBox(height: 12),
//         //               _ContactRow(
//         //                 icon: FontAwesomeIcons.facebookF,
//         //                 text: 'FDS Asya Philippines Inc.',
//         //               ),
//         //               SizedBox(height: 12),
//         //               _ContactRow(
//         //                 icon: FontAwesomeIcons.linkedinIn,
//         //                 text: 'FDS Asya Philippines Inc.',
//         //               ),
//         //             ],
//         //           ),
//         //           // Address
//         //           const Column(
//         //             crossAxisAlignment: CrossAxisAlignment.end,
//         //             children: [
//         //               Text('G/F 1519 D. Oliman St., Valenzuela, Makati City'),
//         //               SizedBox(height: 8),
//         //               Text('G/F 1519 D. Oliman St., Valenzuela, Makati City'),
//         //             ],
//         //           ),
//         //         ],
//         //       ),
//         //       const SizedBox(height: 30),
//         //       const Center(
//         //         child: Text(
//         //           '©FDSAP 2025',
//         //           style: TextStyle(fontSize: 12, color: Colors.black54),
//         //         ),
//         //       ),
//         //     ],
//         //   ),
//         // ),
//       ],
//     );
//   }
//
//   // Placeholder widget for logos
//   Widget _buildLogoPlaceholder() {
//     return Container(
//       width: 48,
//       height: 48,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: const Center(
//         child: Icon(Icons.image, size: 24),
//       ),
//     );
//   }
//
//   // Text logo block
//   Widget _buildTextLogo(String text) {
//     return Text(
//       text,
//       textAlign: TextAlign.center,
//       style: const TextStyle(color: Colors.white, fontSize: 12),
//     );
//   }
// }
class FooterSectionv2 extends StatelessWidget {
  const FooterSectionv2({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     const whiteText = TextStyle(color: Colors.white, fontSize: 14);
//     final double footerHeight = 250;
//     const linkText = TextStyle(
//       color: Colors.white,
//       decoration: TextDecoration.underline,
//       fontSize: 14,
//     );
//
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         Column(
//           children: [
//             // Top Black Section
//             Container(
//               color: Colors.black,
//               width: double.infinity,
//               height: 600,
//               padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // Logos row
//                   AutoScrollWidgetScroller(
// height: 80,
// itemWidth: 120,
// spacing: 24,
// scrollDelay: const Duration(seconds: 2),
// scrollDuration: const Duration(milliseconds: 800),
// items: [
// Image.asset('assets/images/bank-kalsel-emoney.png'),
// Image.asset('assets/images/ag-bank-emoney.png'),
// Image.asset('assets/images/bank-bpd-bali-emoney.png'),
// Image.asset('assets/images/bank-sahabat.png'),
// Image.asset('assets/images/banking-tech.png'),
// Image.asset('assets/images/IMkas.png'),
// Image.asset('assets/images/ottocash.png'),
// Image.asset('assets/images/ottokonek.png'),
// Image.asset('assets/images/ottopayv2.png'),
// Image.asset('assets/images/pac-cash.png'),
// Image.asset('assets/images/bank-bpd-bali-emoney.png'),
// Image.asset('assets/images/bank-ina.png'),
// Image.asset('assets/images/bank-jambi.png'),
// Image.asset('assets/images/bank-kalsel-emoney.png'),
// //
// Image.asset('assets/images/bank-kalsel-emoney.png'),
// Image.asset('assets/images/ag-bank-emoney.png'),
// Image.asset('assets/images/bank-bpd-bali-emoney.png'),
// Image.asset('assets/images/bank-sahabat.png'),
// Image.asset('assets/images/banking-tech.png'),
// Image.asset('assets/images/IMkas.png'),
// Image.asset('assets/images/ottocash.png'),
// Image.asset('assets/images/ottokonek.png'),
// Image.asset('assets/images/ottopayv2.png'),
// Image.asset('assets/images/pac-cash.png'),
// Image.asset('assets/images/bank-bpd-bali-emoney.png'),
// Image.asset('assets/images/bank-ina.png'),
// Image.asset('assets/images/bank-jambi.png'),
// Image.asset('assets/images/bank-kalsel-emoney.png'),
//
// ].map((logo) {
// return Center(
// child: Container(
// padding: const EdgeInsets.all(8),
// child: logo,
// ),
// );
// }).toList(),
// ),
//
//
//                   // Legal Links and Logo
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Privacy Policy', style: linkText),
//                           SizedBox(height: 8),
//                           Text('Manage Cookies', style: linkText),
//                         ],
//                       ),
//                       Image(
//                         image: AssetImage('assets/images/fdsap_logo_white.png'),
//                         width: 150,
//                         height: 150,
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           // Text('Back to Top ↑', style: linkText),
//                           SizedBox(height: 8),
//                           Text('Terms and Conditions', style: linkText),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 40),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         Positioned(
//           bottom: 0,
//           right: 0,
//           child: Stack(
//             clipBehavior: Clip.none,
//             children: [
//               // Dynamically positioned text
//               Positioned(
//                 bottom: footerHeight - 60, // Adjust offset from notch top
//                 left: 0,
//                 right: 0,
//                 child: Text(
//                   'We Listen.\nWe Anticipate.\nWe Deliver.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     height: 1.6,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//
//               // Notch background container
//               ClipPath(
//                 clipper: NotchedClipper(),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: footerHeight,
//                   padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
//                   color: Colors.white,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Contact Info Row
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: const [
//                               _ContactRow(
//                                 icon: Icons.phone,
//                                 text: '+63 919 098 6970',
//                               ),
//                               SizedBox(height: 12),
//                               _ContactRow(
//                                 icon: FontAwesomeIcons.facebookF,
//                                 text: 'FDS Asya Philippines Inc.',
//                               ),
//                               SizedBox(height: 12),
//                               Padding(
//                                 padding: EdgeInsets.only(bottom: 50),
//                                 child: _ContactRow(
//                                   icon: FontAwesomeIcons.linkedinIn,
//                                   text: 'FDS Asya Philippines Inc.',
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text('G/F 1519 D. Oliman St., Valenzuela, Makati City'),
//                               SizedBox(height: 8),
//                               Text('G/F 1519 D. Oliman St., Valenzuela, Makati City'),
//                             ],
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                       const Center(
//                         child: Text(
//                           '©FDSAP 2025',
//                           style: TextStyle(fontSize: 12, color: Colors.black54),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
  @override
  Widget build(BuildContext context) {
    const whiteText = TextStyle(color: Colors.white, fontSize: 14);
    const linkText = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.underline,
      fontSize: 14,
    );
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    final double footerHeight = 250;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            // Top Black Section
            Container(
              color: Colors.black,
              width: double.infinity,
              height: 650,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logos row
                  AutoScrollWidgetScroller(
                    height: 80,
                    itemWidth: 120,
                    spacing: 24,
                    scrollDelay: const Duration(seconds: 2),
                    scrollDuration: const Duration(milliseconds: 800),
                    items: [
                      Image.asset('assets/images/pac-cash.png'),
                      Image.asset('assets/images/bank-bpd-bali-emoney.png'),
                      Image.asset('assets/images/ottopayv2.png'),
                      Image.asset('assets/images/ottokonek.png'),
                      Image.asset('assets/images/ag-bank-emoney.png'),
                      Image.asset('assets/images/fintech_sobatku.png'),
                      Image.asset('assets/images/bank-kalsel-emoney.png'),
                      Image.asset('assets/images/bank-sahabat.png'),
                      Image.asset('assets/images/ottocash.png'),
                      Image.asset('assets/images/IMkas.png'),
                      Image.asset('assets/images/fi_card_bank.png'),
                      Image.asset('assets/images/fi_card_rbi.png'),
                      Image.asset('assets/images/fi_bank_ina.png'),
                      Image.asset('assets/images/fi_nrb_global_bank.png'),
                      Image.asset('assets/images/fi_bank_sulsebar.png'),
                      Image.asset('assets/images/fi_card_sme.png'),
                      Image.asset('assets/images/fi_bank_jambi.png'),
                      Image.asset('assets/images/fi_bank_mas.png'),
                      Image.asset('assets/images/fi_bank_bpd_bali.png'),
                      Image.asset('assets/images/fi_bank_kalsel.png'),
                      Image.asset('assets/images/fi_bank_ntt.png'),
                      Image.asset('assets/images/mfi1.png'),
                      Image.asset('assets/images/mfi_BPR_KS.png'),
                      Image.asset('assets/images/mfi_bpr_sejahtera_batam.png'),
                      Image.asset('assets/images/mfi_bpr_supra.png'),
                      Image.asset('assets/images/mfi_credit_union_bonaventura.png'),
                      Image.asset('assets/images/mfi_credit_union_cindelaras_tumangkar.png'),
                      Image.asset('assets/images/mfi_credit_union_femung_pebaya.png'),
                      Image.asset('assets/images/mfi_credit_union_gerbang_kasih.png'),
                      Image.asset('assets/images/mfi_credit_union_hati_amboina.png'),
                      Image.asset('assets/images/mfi_credit_union_jembatan_kasih.png'),
                      Image.asset('assets/images/mfi_credit_union_kridha.png'),
                      Image.asset('assets/images/mfi_credit_union_mekar_kasih.png'),
                      Image.asset('assets/images/mfi_credit_union_mosinggani_palu.png'),
                      Image.asset('assets/images/mfi_credit_union_ndar_sesepok.png'),
                      Image.asset('assets/images/mfi_credit_union_pelita_sejahtera.png'),
                      Image.asset('assets/images/mfi_credit_union_semangat_warga.png'),
                      Image.asset('assets/images/mfi_credit_union_sumber_kasih_sejahtera.png'),
                      Image.asset('assets/images/mfi_credit_union_usaha_kita.png'),
                      Image.asset('assets/images/mfi_cu_angudi_laras.png'),
                      Image.asset('assets/images/mfi_cu_bahtera_sejahtera.png'),
                      Image.asset('assets/images/mfi_cu_deus_providebit.png'),
                      Image.asset('assets/images/mfi_cu_likku_aba.png'),
                      Image.asset('assets/images/mfi_cu_mototabian.png'),
                      Image.asset('assets/images/mfi_cu_prima.png'),
                      Image.asset('assets/images/mfi_cu_sari_intugin.png'),
                      Image.asset('assets/images/mfi_cu_sohagaini.png'),
                      Image.asset('assets/images/mfi_cu_stella_maris.png'),
                      Image.asset('assets/images/mfi_cu_tilung_jaya.png'),
                      Image.asset('assets/images/mfi_cu_tunas_mekar.png'),
                      Image.asset('assets/images/mfi_cusinar_saron.png'),
                      Image.asset('assets/images/mfi_cusr_ampah.png'),
                      Image.asset('assets/images/mfi_ksp_credit_union_daya_lestari.png'),
                      Image.asset('assets/images/mfi_ksp_cu_kusapa.png'),
                      Image.asset('assets/images/mfi_ksp_cu_sejahtera_makmur_bersama.png'),
                      Image.asset('assets/images/mfi_ksp_multi_artha_utama.png'),
                      Image.asset('assets/images/mfi_kspcu_pangudi.png'),
                      Image.asset('assets/images/mfi_prima_danarta.png'),
                      Image.asset('assets/images/mfi_pusat_koperasi_credit_union.png'),
                      Image.asset('assets/images/mfi_sejarah_berdirinya_credit_union.png'),
                      Image.asset('assets/images/mfi_talita_kum.png'),
                    ].map((logo) {
                      return Center(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: logo,
                        ),
                      );
                    }).toList(),
                  ),


                  // Legal Links and Logo
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Privacy Policy', style: linkText),
                          SizedBox(height: 8),
                          FittedBox(fit: BoxFit.scaleDown, child: Text('Manage Cookies', style: linkText)),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 30),
                        margin: EdgeInsets.only(right: 10, left: 10),
                        child: Image(
                          image: AssetImage('assets/images/fdsap_logo_white.png'),
                          width: 150,
                          height: 150,
                        ),
                      ),
                      Flexible(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.end,
                          alignment: WrapAlignment.end,
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Text(
                              'Terms and Condition',
                              style: linkText,
                              maxLines: 2,
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
///old
        // Bottom clipped section
        // Positioned(
        //   bottom: 0,
        //   right: 0,
        //   child: Stack(
        //     clipBehavior: Clip.none,
        //     children: [
        //       Positioned(
        //         bottom: footerHeight - 60,
        //         left: 0,
        //         right: 0,
        //         child: Text(
        //           'We Listen.\nWe Anticipate.\nWe Deliver.',
        //           textAlign: TextAlign.center,
        //           style: const TextStyle(
        //             color: Colors.white,
        //             fontSize: 24,
        //             height: 1.6,
        //             fontWeight: FontWeight.w500,
        //           ),
        //         ),
        //       ),
        //
        //       // Notched bottom white section
        //       ClipPath(
        //         clipper: NotchedClipper(),
        //         child: Container(
        //           width: screenWidth,
        //           height: footerHeight,
        //           padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        //           color: Colors.white,
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               isMobile
        //                   ? Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: const [
        //                   _ContactRow(icon: Icons.phone, text: '+63 919 098 6970'),
        //                   SizedBox(height: 12),
        //                   _ContactRow(icon: FontAwesomeIcons.facebookF, text: 'FDS Asya Philippines Inc.'),
        //                   SizedBox(height: 12),
        //                   _ContactRow(icon: FontAwesomeIcons.linkedinIn, text: 'FDS Asya Philippines Inc.'),
        //                   SizedBox(height: 12),
        //                   SizedBox(height: 20),
        //                   Text('G/F 1519 D. Oliman St., Valenzuela, Makati City'),
        //                 ],
        //               )
        //                   : Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: const [
        //                       _ContactRow(icon: Icons.phone, text: '+63 919 098 6970'),
        //                       SizedBox(height: 12),
        //                       _ContactRow(icon: FontAwesomeIcons.facebookF, text: 'FDS Asya Philippines Inc.'),
        //                       SizedBox(height: 12),
        //                       _ContactRow(icon: FontAwesomeIcons.linkedinIn, text: 'FDS Asya Philippines Inc.'),
        //                     ],
        //                   ),
        //                   const Column(
        //                     crossAxisAlignment: CrossAxisAlignment.end,
        //                     children: [
        //                       Text('G/F 1519 D. Oliman St., Valenzuela, Makati City'),
        //                       SizedBox(height: 8),
        //                       Text('G/F 1519 D. Oliman St., Valenzuela, Makati City'),
        //                     ],
        //                   ),
        //                 ],
        //               ),
        //               const SizedBox(height: 10),
        //               const Center(
        //                 child: Text(
        //                   '©FDSAP 2025',
        //                   style: TextStyle(fontSize: 12, color: Colors.black54),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: footerHeight - 60,
                left: 0,
                right: 0,
                child: Text(
                  'We Listen.\nWe Anticipate.\nWe Deliver.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: (MediaQuery.sizeOf(context).width * 0.025).clamp(18, 24),
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // Notched bottom white section
              ClipPath(
                clipper: NotchedClipper(MediaQuery.of(context).size.width),
                child: Container(
                  width: screenWidth,
                  height: footerHeight,
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // isMobile
                      //     ? Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: const [
                      //           _ContactRow(icon: Icons.phone, text: '+63 919 098 6970'),
                      //           SizedBox(height: 12),
                      //           _ContactRow(icon: FontAwesomeIcons.facebookF, text: 'FDS Asya Philippines Inc.'),
                      //           SizedBox(height: 12),
                      //           _ContactRow(icon: FontAwesomeIcons.linkedinIn, text: 'FDS Asya Philippines Inc.'),
                      //           SizedBox(height: 12),
                      //           SizedBox(height: 20),
                      //           Text('G/F 1519 D. Oliman St., Valenzuela, Makati City'),
                      //         ],
                      //       )
                      //     :
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              _ContactRow(icon: Icons.phone, text: '+63 919 098 6970'),
                              SizedBox(height: 12),
                              _ContactRow(icon: FontAwesomeIcons.facebookF, text: 'FDS Asya Philippines Inc.'),
                              SizedBox(height: 12),
                              _ContactRow(icon: FontAwesomeIcons.linkedinIn, text: 'FDS Asya Philippines Inc.'),
                            ],
                          ),
                          Spacer(),
                          Flexible(
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.end,
                              alignment: WrapAlignment.end,
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                Text(
                                  'G/F 1519 D. Oliman St., Valenzuela, Makati City',
                                  style: TextStyle(fontSize: (MediaQuery.sizeOf(context).width * 0.02).clamp(8, 14)),
                                  maxLines: 2,
                                  textAlign: TextAlign.right,
                                ),
                                Text(
                                  'G/F 1519 D. Oliman St., Valenzuela, Makati City',
                                  style: TextStyle(fontSize: (MediaQuery.sizeOf(context).width * 0.02).clamp(8, 14)),
                                  maxLines: 2,
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          '©FDSAP 2025',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildLogoPlaceholder() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Icon(Icons.image, size: 24),
      ),
    );
  }

  Widget _buildTextLogo(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, fontSize: 12),
    );
  }
}



// Contact row widget
class _ContactRow extends StatelessWidget {
  final IconData? icon;
  final String text;

  const _ContactRow({this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) Icon(icon, size: 14, color: Colors.black),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: (MediaQuery.sizeOf(context).width * 0.02).clamp(8, 14))),
      ],
    );
  }
}
//custom clipper
///old
// class NotchedClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final double notchWidth = 300.0;
//     final double notchHeight = 100.0;
//     final double cornerRadius = 20.0;
//
//     final double center = size.width / 2;
//     final double left = center - (notchWidth / 2);
//     final double right = center + (notchWidth / 2);
//
//     Path path = Path()
//       ..moveTo(0, 0)
//       ..lineTo(left - cornerRadius, 0)
//
//     // Top-left curve into slanted edge
//       ..quadraticBezierTo(
//         left,
//         0,
//         left + cornerRadius / 2,
//         cornerRadius / 2,
//       )
//
//     // Slanted line down to bottom-left curve start
//       ..lineTo(left + 40, notchHeight - cornerRadius / 2)
//
//     // Bottom-left curve into bottom edge
//       ..quadraticBezierTo(
//         left + 50,
//         notchHeight,
//         left + 60,
//         notchHeight,
//       )
//
//     // Bottom straight section (center)
//       ..lineTo(right - 60, notchHeight)
//
//     // Bottom-right curve out of bottom edge (mirrored)
//       ..quadraticBezierTo(
//         right - 50,
//         notchHeight,
//         right - 40,
//         notchHeight - cornerRadius / 2,
//       )
//
//     // Slanted line up to top-right curve start (mirrored)
//       ..lineTo(right - cornerRadius / 2, cornerRadius / 2)
//
//     // Top-right curve out of slanted edge (mirrored)
//       ..quadraticBezierTo(
//         right,
//         0,
//         right + cornerRadius,
//         0,
//       )
//       ..lineTo(size.width, 0)
//       ..lineTo(size.width, size.height)
//       ..lineTo(0, size.height)
//       ..close();
//
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

class NotchedClipper extends CustomClipper<Path> {
  final double screenWidth;
  NotchedClipper(this.screenWidth);

  @override
  Path getClip(Size size) {
    final double notchWidth = screenWidth <= 600 ? 200 : 300.0;
    final double notchHeight = screenWidth <= 600 ? 80 : 100.0;
    final double cornerRadius = 20.0;

    final double center = size.width / 2;
    final double left = center - (notchWidth / 2);
    final double right = center + (notchWidth / 2);

    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(left - cornerRadius, 0)

    // Top-left curve into slanted edge
      ..quadraticBezierTo(
        left,
        0,
        left + cornerRadius / 2,
        cornerRadius / 2,
      )

    // Slanted line down to bottom-left curve start
      ..lineTo(left + 40, notchHeight - cornerRadius / 2)

    // Bottom-left curve into bottom edge
      ..quadraticBezierTo(
        left + 50,
        notchHeight,
        left + 60,
        notchHeight,
      )

    // Bottom straight section (center)
      ..lineTo(right - 60, notchHeight)

    // Bottom-right curve out of bottom edge (mirrored)
      ..quadraticBezierTo(
        right - 50,
        notchHeight,
        right - 40,
        notchHeight - cornerRadius / 2,
      )

    // Slanted line up to top-right curve start (mirrored)
      ..lineTo(right - cornerRadius / 2, cornerRadius / 2)

    // Top-right curve out of slanted edge (mirrored)
      ..quadraticBezierTo(
        right,
        0,
        right + cornerRadius,
        0,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


