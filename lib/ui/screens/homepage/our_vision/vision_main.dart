import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/our_mission/mission_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/header_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_builder/responsive_builder.dart';

class VisionMain extends StatefulWidget {
  const VisionMain({Key? key}) : super(key: key);

  @override
  State<VisionMain> createState() => _VisionMainState();
}

class _VisionMainState extends State<VisionMain> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool isFabVisible = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = heightOfScreen(context);
    double spacerHeight = screenHeight * 0.19;
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
                  return NavSectionMobile(scaffoldKey: _scaffoldKey);
                } else {
                  return HeaderSection();
                }
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MissionSection(),
                    SizedBoxH10(),
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
