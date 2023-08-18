// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class OurTeamScreen extends StatefulWidget {
//   const OurTeamScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OurTeamScreen> createState() => _OurTeamScreenState();
// }
//
// class _OurTeamScreenState extends State<OurTeamScreen> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     return SingleChildScrollView(
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
//         color: Colors.white,
//         child: Row(
//           children: <Widget>[
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.only(right: !isMobile(context) ? 40 : 0),
//                 child: Column(
//                   mainAxisAlignment: !isMobile(context) ? MainAxisAlignment.start : MainAxisAlignment.center,
//                   crossAxisAlignment: !isMobile(context) ? CrossAxisAlignment.start : CrossAxisAlignment.center,
//                   children: <Widget>[
//                     if (isMobile(context))
//                       Image.asset(
//                         'assets/images/login.png',
//                         height: size.height * 0.3,
//                       ),
//                     const SizedBox(height: 10),
//                     Wrap(
//                       runSpacing: 10,
//                       children: <Widget>[
//                         NimbusInfoSection1(
//                           title1: StringConst.FDSAP_VISION_TITLE,
//                           hasTitle2: false,
//                           body: StringConst.FDSAP_VISION_DESC,
//                           title1Style: GoogleFonts.poppins(
//                             fontSize: Sizes.TEXT_SIZE_35,
//                             fontWeight: FontWeight.w700,
//                             color: AppColors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             if (isDesktop(context) || isTab(context))
//               Expanded(
//                 child: Image.asset(
//                   'assets/images/login.png',
//                   height: size.height * 0.6,
//                   width: size.width * 0.6,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
