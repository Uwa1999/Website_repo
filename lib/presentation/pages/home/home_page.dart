import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:FDS_ASYA_PHILIPPINES/presentation/layout/adaptive.dart';
import 'package:FDS_ASYA_PHILIPPINES/presentation/pages/home/sections/about_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/presentation/pages/home/sections/insights_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/presentation/pages/home/sections/footer_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/presentation/pages/home/sections/header_section/header_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/presentation/pages/home/sections/nav_section/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/presentation/pages/home/sections/nav_section/nav_section_web.dart';
import 'package:FDS_ASYA_PHILIPPINES/presentation/pages/home/sections/productservices_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/presentation/pages/home/sections/partners_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/presentation/pages/home/sections/statistics_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/presentation/widgets/app_drawer.dart';
import 'package:FDS_ASYA_PHILIPPINES/presentation/widgets/nav_item.dart';
import 'package:FDS_ASYA_PHILIPPINES/utils/functions.dart';
import 'package:FDS_ASYA_PHILIPPINES/values/values.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
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
    // NavItemData(name: StringConst.PARTNERS, key: GlobalKey()),
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
    double spacerHeight = screenHeight * 0.10;

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
                          HeaderSection(
                            key: navItems[0].key,
                          ),
                          SizedBox(height: spacerHeight),
                          VisibilityDetector(
                            key: Key("about"),
                            onVisibilityChanged: (visibilityInfo) {
                              double visiblePercentage =
                                  visibilityInfo.visibleFraction * 100;
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
                      )
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
                          SizedBox(height: spacerHeight),
                          StatisticsSection(),
                          // SizedBox(height: spacerHeight),
                          // Container(
                          //   key: navItems[3].key,
                          //   child: PartnerSection(),
                          // ),
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
                            key: navItems[3].key,
                            child: InsightSection(),
                          ),
                          FooterSection(),
                        ],
                      )
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
