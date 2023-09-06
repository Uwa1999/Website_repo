import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/alternative_solution/atm_switch/atm_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/alternative_solution/chatbot/chatbot_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/alternative_solution/dcm/dcm_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/alternative_solution/k2c/k2c_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/alternative_solution/kplus/kplus_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/alternative_solution/sbs/sbs_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AlternativeSolutionMain extends StatefulWidget {
  static const String route = '/AlternativeSolution';
  const AlternativeSolutionMain({Key? key}) : super(key: key);

  @override
  State<AlternativeSolutionMain> createState() => _AlternativeSolutionMainState();
}

class _AlternativeSolutionMainState extends State<AlternativeSolutionMain> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool isFabVisible = false;

  @override
  Widget build(BuildContext context) {
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
                  return HeaderSection();
                }
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBoxH60(),
                    KplusSection(),
                    SizedBoxH50(),
                    ChatbotSection(),
                    SizedBoxH40(),
                    K2cSection(),
                    SizedBoxH40(),
                    DcmSection(),
                    SizedBoxH40(),
                    SbsSection(),
                    SizedBoxH40(),
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
