// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/buttons/contact_us_button.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/skill_card.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:responsive_builder/responsive_builder.dart';
//
// class BrandSection extends StatelessWidget {
//   BrandSection({Key? key});
//   CarouselOptions carouselOptions({
//     bool autoPlay = true,
//     bool enlargeCenterPage = false,
//     double viewportFraction = 1.0,
//     double aspectRatio = 0.1,
//     int initialPage = 2,
//     ScrollPhysics? scrollPhysics = const NeverScrollableScrollPhysics(),
//   }) {
//     return CarouselOptions(
//       autoPlay: autoPlay,
//       enlargeCenterPage: enlargeCenterPage,
//       viewportFraction: viewportFraction,
//       aspectRatio: aspectRatio,
//       initialPage: initialPage,
//       scrollPhysics: scrollPhysics,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     double heightOfCarouselSm = assignWidth(context, 0.40);
//     double widthOfCarouselMd = assignWidth(context, 0.33);
//     double heightOfCarouselMd = widthOfCarouselMd / 2;
//     double heightOfCarouselLg = 150;
//     return Container(
//       child: Column(
//         children: [
//           Text(
//             StringConst.BRANDS_SECTION_TITLE,
//             textAlign: TextAlign.center,
//             style: textTheme.headlineMedium,
//           ),
//           SizedBoxH40(),
//           ResponsiveBuilder(
//             builder: (context, sizingInformation) {
//               double screenWidth = sizingInformation.screenSize.width;
//               if (screenWidth <= (RefinedBreakpoints().tabletSmall)) {
//                 return Container(
//                   height: heightOfCarouselSm,
//                   width: widthOfScreen(context),
//                   child: CarouselSlider.builder(
//                     itemCount: 15,
//                     itemBuilder: (
//                       BuildContext context,
//                       int itemIndex,
//                       int pageViewIndex,
//                     ) {
//                       return SkillCard(
//                         width: assignWidth(context, 0.7),
//                         height: heightOfCarouselSm,
//                         iconData: FontAwesomeIcons.twitter,
//                         title: "Brand",
//                       );
//                     },
//                     options: carouselOptions(),
//                   ),
//                 );
//               } else if (screenWidth < 1400) {
//                 return Container(
//                   height: heightOfCarouselMd,
//                   width: widthOfScreen(context),
//                   child: CarouselSlider.builder(
//                     itemCount: 15,
//                     itemBuilder: (
//                       BuildContext context,
//                       int itemIndex,
//                       int pageViewIndex,
//                     ) {
//                       return SkillCard(
//                         width: widthOfCarouselMd,
//                         height: heightOfCarouselMd,
//                         iconData: FontAwesomeIcons.twitter,
//                         title: "Brand",
//                       );
//                     },
//                     options: carouselOptions(viewportFraction: 0.2),
//                   ),
//                 );
//               } else {
//                 return Container(
//                   height: heightOfCarouselLg,
//                   width: widthOfScreen(context),
//                   child: CarouselSlider.builder(
//                     itemCount: 15,
//                     itemBuilder: (
//                       BuildContext context,
//                       int itemIndex,
//                       int pageViewIndex,
//                     ) {
//                       return SkillCard(
//                         width: 200,
//                         height: heightOfCarouselLg,
//                         iconData: FontAwesomeIcons.twitter,
//                         title: "Brand",
//                       );
//                     },
//                     options: carouselOptions(viewportFraction: 0.15),
//                   ),
//                 );
//               }
//             },
//           ),
//           SizedBoxH40(),
//           Align(
//             alignment: Alignment.center,
//             child: NimbusButton(
//               buttonTitle: StringConst.HIRE_ME,
//               buttonColor: AppColors.maroon450,
//               onPressed: () {},
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
