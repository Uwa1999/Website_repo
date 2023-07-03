import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/about_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_responsive_section/header_responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/insights_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/our_location_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/productservices_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_web.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/functions.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/app_drawer.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nav_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'components/statistics_section.dart';

class HomepageScreen extends StatefulWidget {
  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );
  // bool isFabVisible = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();

  final List<NavItemData> navItems = [
    NavItemData(name: StringConst.HOME, key: GlobalKey(), isSelected: true),
    NavItemData(name: StringConst.ABOUT, key: GlobalKey()),
    NavItemData(name: StringConst.SERVICES, key: GlobalKey()),
    NavItemData(name: StringConst.INSIGHTS, key: GlobalKey()),
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels < 100) {
        _controller.reverse();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = heightOfScreen(context);
    double spacerHeight = screenHeight * 0.19;

    return Scaffold(
      key: _scaffoldKey,
      drawer: ResponsiveBuilder(
        refinedBreakpoints: RefinedBreakpoints(),
        builder: (context, sizingInformation) {
          double screenWidth = sizingInformation.screenSize.width;
          if (screenWidth < RefinedBreakpoints().desktopSmall) {
            return AppDrawer(
              menuList: navItems,
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: ScaleTransition(
        scale: _animation,
        child: FloatingActionButton(
          onPressed: () {
            // Scroll to header section
            scrollToSection(navItems[0].key.currentContext!);
          },
          child: Icon(
            FontAwesomeIcons.arrowUp,
            size: Sizes.ICON_SIZE_18,
            color: AppColors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          ResponsiveBuilder(
            refinedBreakpoints: RefinedBreakpoints(),
            builder: (context, sizingInformation) {
              double screenWidth = sizingInformation.screenSize.width;
              if (screenWidth < RefinedBreakpoints().desktopSmall) {
                return NavSectionMobile(scaffoldKey: _scaffoldKey);
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
                                _controller.forward();
                              }
                            },
                            child: Container(
                              key: navItems[1].key,
                              child: AboutSection(),
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
                            child: ProductServicesSection(),
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
                          LeadingBankingPartnerSection(),
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
    );
  }
}
