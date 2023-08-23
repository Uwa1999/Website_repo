import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_web.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/alternative_solution/atm_switch/atm_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/alternative_solution/chatbot/chatbot_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/alternative_solution/dcm/dcm_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/alternative_solution/k2c/k2c_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/alternative_solution/kplus/kplus_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/alternative_solution/sbs/sbs_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nav_item.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AlternativeSolutionMain extends StatefulWidget {
  const AlternativeSolutionMain({Key? key}) : super(key: key);

  @override
  State<AlternativeSolutionMain> createState() => _AlternativeSolutionMainState();
}

class _AlternativeSolutionMainState extends State<AlternativeSolutionMain> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  final List<NavItemData> navItems = [
    NavItemData(name: StringConst.HOME, key: GlobalKey(), isSelected: true),
    NavItemData(name: StringConst.ABOUT, key: GlobalKey()),
    NavItemData(name: StringConst.SERVICES, key: GlobalKey()),
    NavItemData(name: StringConst.INSIGHTS, key: GlobalKey()),
  ];
  bool isFabVisible = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.white,
      key: _scaffoldKey,
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: FloatingActionButton(
          backgroundColor: AppColors.maroon08,
          child: Icon(
            Icons.expand_more,
            size: Sizes.ICON_SIZE_18,
            color: AppColors.white,
          ),
          onPressed: () {},
        ),
      ),
      drawer: ResponsiveBuilder(
        refinedBreakpoints: RefinedBreakpoints(),
        builder: (context, sizingInformation) {
          double screenWidth = sizingInformation.screenSize.width;
          if (screenWidth < RefinedBreakpoints().desktopSmall) {
            return SideMenu();
          } else {
            return Container();
          }
        },
      ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.reverse) {
            if (!isFabVisible) setState(() => isFabVisible = true);
          } else if (notification.direction == ScrollDirection.forward) {
            if (isFabVisible) setState(() => isFabVisible = false);
          }
          return true;
        },
        child: Column(
          children: [
            ResponsiveBuilder(
              refinedBreakpoints: RefinedBreakpoints(),
              builder: (context, sizingInformation) {
                double screenWidth = sizingInformation.screenSize.width;
                if (screenWidth < RefinedBreakpoints().desktopSmall) {
                  return NavSectionMobile(
                    scaffoldKey: _scaffoldKey,
                  );
                } else {
                  return NavSectionWeb(
                    navItems: navItems,
                  );
                }
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KplusSection(),
                    ChatbotSection(),
                    K2cSection(),
                    DcmSection(),
                    SbsSection(),
                    AtmSection(),
                    SizedBoxH100(),
                    FooterSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//   late final AnimationController _controller = AnimationController(
//     duration: const Duration(milliseconds: 300),
//     vsync: this,
//   );
//   late final Animation<double> _animation = CurvedAnimation(
//     parent: _controller,
//     curve: Curves.easeInOut,
//   );
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//
//   final ScrollController _scrollController = ScrollController();
//   bool isFabVisible = false;
//   @override
//   void dispose() {
//     _controller.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels < 100) {
//         _controller.reverse();
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = heightOfScreen(context);
//     double spacerHeight = screenHeight * 0.19;
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       key: _scaffoldKey,
//       floatingActionButton: Visibility(
//         visible: isFabVisible,
//         child: FloatingActionButton(
//           backgroundColor: AppColors.maroon08,
//           child: Icon(
//             Icons.expand_more,
//             size: Sizes.ICON_SIZE_18,
//             color: AppColors.white,
//           ),
//           onPressed: () {},
//         ),
//       ),
//       body: NotificationListener<UserScrollNotification>(
//         onNotification: (notification) {
//           if (notification.direction == ScrollDirection.reverse) {
//             if (!isFabVisible) setState(() => isFabVisible = true);
//           } else if (notification.direction == ScrollDirection.forward) {
//             if (isFabVisible) setState(() => isFabVisible = false);
//           }
//           return true;
//         },
//         // floatingActionButton: FloatingActionButton(
//         //   onPressed: () {},
//         //   child: Icon(
//         //     FontAwesomeIcons.arrowDown,
//         //     size: Sizes.ICON_SIZE_18,
//         //     color: AppColors.white,
//         //   ),
//         // ),
//         child: Column(
//           children: [
//             ResponsiveBuilder(
//               refinedBreakpoints: RefinedBreakpoints(),
//               builder: (context, sizingInformation) {
//                 double screenWidth = sizingInformation.screenSize.width;
//                 if (screenWidth < RefinedBreakpoints().desktopSmall) {
//                   return NavSectionMobile(scaffoldKey: _scaffoldKey);
//                 } else {
//                   return HeaderSection();
//                 }
//               },
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 controller: _scrollController,
//                 child: Column(
//                   children: [
//                     KplusSection(),
//                     ChatbotSection(),
//                     K2cSection(),
//                     DcmSection(),
//                     SbsSection(),
//                     AtmSection(),
//                     SizedBoxH100(),
//                     FooterSection(),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
