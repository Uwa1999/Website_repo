import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleDescSection extends StatefulWidget {
  const ArticleDescSection({Key? key}) : super(key: key);

  @override
  State<ArticleDescSection> createState() => _ArticleDescSectionState();
}

class _ArticleDescSectionState extends State<ArticleDescSection> {
  @override
  Widget build(BuildContext context) {
    return (!isMobile(context)) == (!isTab(context)) ? DesktopArticleDescScreenInsidev2() : MobileArticleDescScreenInsidev2();
  }
}

class DesktopArticleDescScreenInsidev2 extends StatelessWidget {
  const DesktopArticleDescScreenInsidev2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      width: double.infinity,
      child: Stack(
        children: [

          // Background image
          Positioned.fill(
            child: Image.asset(
              ImagePath.ARTICLE_HEADERv2,
              fit: BoxFit.cover,
            ),
          ),

          // Gradient overlay
          Positioned.fill(
          child: Container(
          decoration: BoxDecoration(
          gradient: LinearGradient(
          colors: [
            AppColors.maroon03.withOpacity(0.6),
          Colors.transparent,

          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          ),
          ),
          ),
          ),

          // Content
          Positioned(
            top: 500,
            left: 100,

            child: NimbusInfoInsightTitle(
              title1: "Meet the team:",
              title2: "Project Management Office",
              hasTitle2: true,
              body: StringConst.ARTICLE_DESC_SUBTITLE1,
              title1Style: GoogleFonts.poppins(
                fontSize: 50,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
              title2Style: GoogleFonts.poppins(
    fontSize: 50,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    ),
              onTap: () {
                Navigator.pushNamed(context, '/Article1');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MobileArticleDescScreenInsidev2 extends StatelessWidget {
  const MobileArticleDescScreenInsidev2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            // Background image
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.asset(
                ImagePath.ARTICLE_HEADERv2,
                fit: BoxFit.cover,
              ),
            ),

            // Gradient overlay
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.maroon03, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            // Content
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: NimbusInfoInsightTitle(
                title1: "Meet the team:",
                title2: "Project Management Office",
                hasTitle2: true,
                body: StringConst.ARTICLE_DESC_SUBTITLE1,
                title1Style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/Article1');
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

//
// //Desktop Screen
// class DesktopArticleDescScreenInsidev2 extends StatefulWidget {
//   const DesktopArticleDescScreenInsidev2({Key? key}) : super(key: key);
//
//   @override
//   State<DesktopArticleDescScreenInsidev2> createState() => _DesktopArticleDescScreenInsidev2State();
// }
//
// class _DesktopArticleDescScreenInsidev2State extends State<DesktopArticleDescScreenInsidev2> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: EdgeInsets.only(
//             left: Sizes.PADDING_100,
//             right: Sizes.PADDING_150,
//           ),
//           height: MediaQuery.of(context).size.height * 0.9,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               fit: BoxFit.cover,
//               image: AssetImage(
//                 ImagePath.ARTICLE_HEADERv2,
//               ),
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBoxH190(),
//                   SizedBoxH190(),
//                   NimbusInfoInsightTitle(
//                     title1: StringConst.ARTICLE_DESC_TITLE,
//                     hasTitle2: false,
//                     body: StringConst.ARTICLE_DESC_SUBTITLE1,
//                     title1Style: GoogleFonts.poppins(
//                       fontSize: Sizes.TEXT_SIZE_50,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.white,
//                     ),
//                     onTap: (){
//                       Navigator.pushNamed(context, '/Article1');
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// //Mobile Screen
// class MobileArticleDescScreenInsidev2 extends StatelessWidget {
//   const MobileArticleDescScreenInsidev2({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Background image section
//           Container(
//             height: 300,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: AssetImage(ImagePath.ARTICLE_HEADERv2),
//               ),
//             ),
//             // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//             alignment: Alignment.bottomLeft,
//             child: NimbusInfoInsightTitle(
//               title1: "Meet the team:",
//               title2: "Project Management Office",
//               hasTitle2: true,
//               body: StringConst.ARTICLE_DESC_SUBTITLE1,
//               title1Style: GoogleFonts.poppins(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w700,
//                 color: AppColors.white,
//               ),
//               onTap: () {
//                 Navigator.pushNamed(context, '/Article1');
//               },
//             ),
//           ),
//
//           const SizedBox(height: 20),
//
//           // Text content
//           // Padding(
//           //   padding: const EdgeInsets.symmetric(horizontal: 20),
//           //   child: Text(
//           //     "FDS ASYA PHILIPPINES INC. (FDSAP) is a leader in digital services, whose success is also attributed to the support of an international alliance with our holding, FORTRESS DATA SERVICES INDONESIA (FDSI). "
//           //         "With a deep understanding of local businesses, we have played a vital role since 2015 in facilitating the digitalization journeys of CARD Bank, CARD RBI, and CARD SME. "
//           //         "Throughout the years, we have become one of Southeast Asia’s leading IT companies and continue to be a trustworthy and reliable partner in the financial industry.",
//           //     style: GoogleFonts.inter(
//           //       fontSize: 14,
//           //       height: 1.6,
//           //       color: Colors.black87,
//           //     ),
//           //     textAlign: TextAlign.justify,
//           //   ),
//           // ),
//
//           const SizedBox(height: 30),
//         ],
//       ),
//     );
//   }
// }
