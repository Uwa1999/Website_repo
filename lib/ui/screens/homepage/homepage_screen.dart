import 'package:FDS_ASYA_PHILIPPINES/ui/screens/clients/clients_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/clients/components/fintech.dart';
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
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/products_and_services_v2/products_and_servicesv2.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/functions.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/NavItemData_global.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/buttons/footer.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nav_item.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'components/leading_partners_section.dart';

class HomepageScreen extends StatefulWidget {
  static const String route = '/Homepage';
  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  bool isFabVisible = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ScrollTarget.targetKey != null) {
        scrollToSection(ScrollTarget.targetKey!);
      }
    });
  }


  // void scrollToSection(BuildContext context) {
  //   final RenderBox? box = context.findRenderObject() as RenderBox?;
  //   if (box != null && box.hasSize) {
  //     Scrollable.ensureVisible(
  //       context,
  //       duration: const Duration(milliseconds: 500),
  //       curve: Curves.easeInOut,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight = heightOfScreen(context);
    double spacerHeight = screenHeight * 0.19;

    return Scaffold(
      backgroundColor: Colors.transparent,
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
            scrollToSection(navItems[0].key!);
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
                  ///old
                  // return NavSectionWeb(
                  //   navItems: navItems,
                  // );
                  ///new added as of may 15,2025
                  return NavSectionWeb(
                    navItems: navItems,
                    // onNavItemSelected: (key) {
                    //   if (key.currentContext != null) {
                    //     scrollToSection(key.currentContext!);
                    //   }
                    // },
                    onNavItemSelected: (key) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (key.currentContext != null) {
                          scrollToSection(key);
                        }
                      });
                    },

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
                            SizedBoxH50(),
                            // VisibilityDetector(
                            //   key: Key("about"),
                            //   onVisibilityChanged: (visibilityInfo) {
                            //     double visiblePercentage = visibilityInfo.visibleFraction * 100;
                            //     if (visiblePercentage > 10) {
                            //       // _controller.forward();
                            //     }
                            //   },
                            //   child: Stack(
                            //     children: [
                            //       // Column(
                            //       //   children: [
                            //       //     Container(
                            //       //       key: navItems[1].key,
                            //       //       child: AboutSection(),
                            //       //     ),
                            //       //     MissionSection(),
                            //       //     OurTeamSection(),
                            //       //   ],
                            //       // ),
                            //     ],
                            //   ),
                            // ),
                            Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Container(
                                    //   color: Color(0xffFAFAFA),
                                    //   width: 2000,
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.only(left: 100.0, bottom: 50,top: 100),
                                    //     child: Text('Our Products and Services', style: TextStyle(fontSize: 70, color: Colors.black,)),
                                    //   ),
                                    // ),
                                    // Container(
                                    //   color: Color(0xffFAFAFA),
                                    //   width: 2000,
                                    //   key: navItems[2].key,
                                    //   child: Column(
                                    //     children: [
                                    //       // Container(
                                    //       //   width: 1500,
                                    //       //   child: CustomCardWidget(
                                    //       //     title: 'Banking Technology',
                                    //       //     description: 'Our secure, scalable SaaS banking solutions enable financial institutions to modernize their operations, enhance efficiency, and expand their outreach —delivering world-class banking experiences through real-time data, streamlined field processes, and third-party integration. These tools support inclusive finance while ensuring compliance, data privacy, and service excellence.',
                                    //       //     buttonLabels: ['Mobile Collection','Web Collection','Core Banking System'],
                                    //       //     onButtonPressed: [
                                    //       //     ], imagePath: 'assets/images/banking-tech.png',
                                    //       //
                                    //       //   ),
                                    //       // ),
                                    //       Container(
                                    //         width: 1500,
                                    //         child: CustomCardWidget(
                                    //           title: 'Banking Technology',
                                    //           description:
                                    //           'Our secure, scalable SaaS banking solutions enable financial institutions to modernize their operations, enhance efficiency, and expand their outreach —delivering world-class banking experiences through real-time data, streamlined field processes, and third-party integration. These tools support inclusive finance while ensuring compliance, data privacy, and service excellence.',
                                    //           buttonLabels: ['Mobile Collection', 'Web Collection', 'Core Banking System'],
                                    //           imagePath: 'assets/images/banking-tech.png',
                                    //           // onMainActionPressed: (){
                                    //           //   Navigator.pushReplacementNamed(context, FinTechPage.route);
                                    //           // },
                                    //           onMainActionPressed: () {
                                    //             final context = navItems[2].key.currentContext;
                                    //             if (context != null) {
                                    //               Scrollable.ensureVisible(
                                    //                 context,
                                    //                 duration: const Duration(milliseconds: 500),
                                    //                 curve: Curves.easeInOut,
                                    //               );
                                    //             }
                                    //             // Navigator.pushReplacementNamed(context!, FinTechPage.route);
                                    //             Navigator.pushNamed(context!, '/Fintech');
                                    //           },
                                    //
                                    //         ),
                                    //       ),
                                    //
                                    //       SizedBox(height: 10,),
                                    //       Container(
                                    //         width: 1500,
                                    //         child: CustomCardWidget(
                                    //           title: 'Alternative Deliveries Solution',
                                    //           description: 'We provide mobile apps, digital wallets, and self-service tools that make banking more accessible, especially in underserved areas. These reliable, user-friendly channels enable seamless transactions, real-time account access, and broader financial inclusion.',
                                    //           buttonLabels: ['Kplus','Konek2CARD','ATM Switch','DCM'],
                                    //           onButtonPressed: [
                                    //           ], imagePath: 'assets/images/alternative-deliveries-solution.png',
                                    //           onMainActionPressed: () {
                                    //             final context = navItems[2].key.currentContext;
                                    //             if (context != null) {
                                    //               Scrollable.ensureVisible(
                                    //                 context,
                                    //                 duration: const Duration(milliseconds: 500),
                                    //                 curve: Curves.easeInOut,
                                    //               );
                                    //             }
                                    //             // Navigator.pushReplacementNamed(context!, FinTechPage.route);
                                    //             Navigator.pushNamed(context!, '/ADS');
                                    //           },
                                    //         ),
                                    //       ),
                                    //       SizedBox(height: 10,),
                                    //       Container(
                                    //         width: 1500,
                                    //         child: CustomCardWidget(
                                    //           title: 'Regulatory and Services',
                                    //           description: 'Our security solutions ensure compliance and protect against fraud and cyber threats. With AML tools and risk intelligence systems like World-Check, institutions can operate with transparency, safeguard data, and maintain client trust.',
                                    //           buttonLabels: ['Cyber Security','Fraud Detection','ATM'],
                                    //           onButtonPressed: [
                                    //
                                    //           ], imagePath: 'assets/images/regulatory-and-services.png',
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    Container(
                                      key: navItems[1].key,
                                      child: ProductsAndServicesV2(),
                                    ),

                                    Container(
                                      key: navItems[3].key,
                                      child: ClientsList(),
                                    )
                                  ],
                                ),

                              ],
                            ),
                            Stack(
                              children: [
                                Column(
                                  children: [
                                    LeadingBankingPartnerSection(),
                                    Container(
                                      key: navItems[4].key,
                                      child: InsightSection(),
                                    ),
                                    // Stack(
                                    //   children:[
                                    //
                                    //     Container(
                                    //         key: contactUsKey, // <-- This enables scrolling to work
                                    //         child: ContactUsPage()),
                                    //     Padding(
                                    //       padding: const EdgeInsets.only(left: 900, top: 40),
                                    //       child: Container(
                                    //         color: Colors.deepOrange,
                                    //           width: 300,
                                    //           height: 200,
                                    //           child: const OurLocationSection()),
                                    //     ),
                                    //   ]
                                    // ),
                                    LayoutBuilder(
                                      builder: (context, constraints) {
                                        // final isMobile = constraints.maxWidth < 800;
                                        final double totalWidth = constraints.maxWidth;
                                        final double contactFormWidth = 850; // Estimated width of your form
                                        final double sidePadding = 40;
                                        final double remainingWidth = totalWidth - contactFormWidth - sidePadding * 4;

                                        return Stack(
                                          children: [
                                            Container(

                                              key: navItems[5].key,
                                              child: ContactUsPage(),
                                            ),
                                              Positioned(
                                                top: 40,
                                                left: contactFormWidth + sidePadding,
                                                child: const OurLocationSection(),
                                              ),
                                          ],
                                        );
                                      },
                                    ),


                                    //FooterSection(),
                                    FooterSectionv2()
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    //       SizedBox(height: spacerHeight),

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
