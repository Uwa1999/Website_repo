import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/productservices_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/header_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProductServicesMain extends StatefulWidget {
  const ProductServicesMain({Key? key}) : super(key: key);

  @override
  State<ProductServicesMain> createState() => _ProductServicesMainState();
}

class _ProductServicesMainState extends State<ProductServicesMain> {
  // late final AnimationController _controller = AnimationController(
  //   duration: const Duration(milliseconds: 300),
  //   vsync: this,
  // );
  // late final Animation<double> _animation = CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.easeInOut,
  // );
  // bool isFabVisible = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   _scrollController.dispose();
  //   super.dispose();
  // }
  //
  // @override
  // void initState() {
  //   _scrollController.addListener(() {
  //     if (_scrollController.position.pixels < 100) {
  //       _controller.reverse();
  //     }
  //   });
  //   super.initState();
  // }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = heightOfScreen(context);
//     double spacerHeight = screenHeight * 0.19;
//     return
//       Scaffold(
//       key: _scaffoldKey,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Scroll to header section
//           //  scrollToSection(navItems[0].key.currentContext!);
//         },
//         child: Icon(
//           FontAwesomeIcons.arrowUp,
//           size: Sizes.ICON_SIZE_18,
//           color: AppColors.white,
//         ),
//       ),
//       body: Column(
//         children: [
//           ResponsiveBuilder(
//             refinedBreakpoints: RefinedBreakpoints(),
//             builder: (context, sizingInformation) {
//               double screenWidth = sizingInformation.screenSize.width;
//               if (screenWidth < RefinedBreakpoints().desktopSmall) {
//                 return NavSectionMobile(scaffoldKey: _scaffoldKey);
//               } else {
//                 return HeaderSection();
//               }
//             },
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               controller: _scrollController,
//               child: Column(
//                 children: [
//                   ProductServicesSection(),
//                   SizedBoxH100(),
//                   FooterSection(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          ResponsiveBuilder(
            refinedBreakpoints: RefinedBreakpoints(),
            builder: (context, sizingInformation) {
              double screenWidth = sizingInformation.screenSize.width;
              if (screenWidth < RefinedBreakpoints().desktopSmall) {
                return NavSectionMobile(scaffoldKey: _scaffoldKey);
              } else {
                return HeaderSection();
              }
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  ProductServicesSection(),
                  SizedBoxH100(),
                  FooterSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
