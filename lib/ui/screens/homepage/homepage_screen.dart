import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/about/about_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_responsive_section/header_responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/our_location_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/our_team_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_web.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/our_mission/mission_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/insights_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/product_services_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/functions.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nav_item.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'components/leading_partners_section.dart';

class HomepageScreen extends StatefulWidget {
  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  bool isFabVisible = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  final List<NavItemData> navItems = [
    NavItemData(name: StringConst.HOME, key: GlobalKey(), isSelected: true),
    NavItemData(name: StringConst.ABOUT, key: GlobalKey()),
    NavItemData(name: StringConst.SERVICES, key: GlobalKey()),
    NavItemData(name: StringConst.INSIGHTS, key: GlobalKey()),
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = heightOfScreen(context);
    double spacerHeight = screenHeight * 0.19;

    return Scaffold(
      backgroundColor: AppColors.white,
      key: _scaffoldKey,
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
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: FloatingActionButton(
          backgroundColor: AppColors.maroon08,
          child: Icon(
            Icons.expand_less,
            size: Sizes.ICON_SIZE_18,
            color: AppColors.white,
          ),
          onPressed: () {
            scrollToSection(navItems[0].key.currentContext!);
          },
        ),
      ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            if (!isFabVisible) setState(() => isFabVisible = true);
          } else if (notification.direction == ScrollDirection.reverse) {
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
                controller: _scrollController,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            HeaderResponsive(
                              key: navItems[0].key,
                            ),
                            SizedBox(height: spacerHeight),
                            VisibilityDetector(
                              key: Key("about"),
                              onVisibilityChanged: (visibilityInfo) {
                                double visiblePercentage = visibilityInfo.visibleFraction * 100;
                                if (visiblePercentage > 10) {
                                  // _controller.forward();
                                }
                              },
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        key: navItems[1].key,
                                        child: AboutSection(),
                                      ),
                                      SizedBoxH80(),
                                      MissionSection(),
                                      SizedBoxH100(),
                                      OurTeamSection(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spacerHeight),
                    Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              key: navItems[2].key,
                              child: ProductAndServicesSection(),
                            ),
                          ],
                        ),
                      ],
                    ),
                      SizedBox(height: spacerHeight),
                    Stack(
                      children: [
                        Column(
                          children: [
                            SizedBoxH30(),
                            LeadingBankingPartnerSection(),
                            SizedBoxH80(),
                            Container(
                              key: navItems[3].key,
                              child: InsightSection(),
                            ),
                            OurLocationSection(),
                            FooterSection(),
                          ],
                        ),
                      ],
                    ),
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
