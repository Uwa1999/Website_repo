// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/clients/clients_main.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/clients/components/banking_technology.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/about/about_section.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_responsive_section/header_responsive.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/our_location_section.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/our_team_section.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_web.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/our_mission/mission_section.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/insights_section.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/product_services_section.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/products_and_services_v2/products_and_servicesv2.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/functions.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/NavItemData_global.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/buttons/footer.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nav_item.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:responsive_builder/responsive_builder.dart';
// import 'package:visibility_detector/visibility_detector.dart';
//
// import 'components/leading_partners_section.dart';
//
// class HomepageScreen extends StatefulWidget {
//   static const String route = '/Homepage';
//   @override
//   _HomepageScreenState createState() => _HomepageScreenState();
// }
//
// class _HomepageScreenState extends State<HomepageScreen> {
//   bool isFabVisible = false;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//   final ScrollController _scrollController = ScrollController();
//
//
//   @override
//   void initState() {
//     super.initState();
//
//     _scrollController.addListener(_onScroll);
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (ScrollTarget.targetKey != null) {
//         scrollToSection(ScrollTarget.targetKey!);
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _scrollController.removeListener(_onScroll); // Clean up
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//
//   // void scrollToSection(BuildContext context) {
//   //   final RenderBox? box = context.findRenderObject() as RenderBox?;
//   //   if (box != null && box.hasSize) {
//   //     Scrollable.ensureVisible(
//   //       context,
//   //       duration: const Duration(milliseconds: 500),
//   //       curve: Curves.easeInOut,
//   //     );
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = heightOfScreen(context);
//     double spacerHeight = screenHeight * 0.19;
//
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       key: _scaffoldKey,
//       drawer: ResponsiveBuilder(
//         refinedBreakpoints: RefinedBreakpoints(),
//         builder: (context, sizingInformation) {
//           double screenWidth = sizingInformation.screenSize.width;
//           if (screenWidth < RefinedBreakpoints().desktopSmall) {
//             return SideMenu();
//           } else {
//             return Container();
//           }
//         },
//       ),
//       floatingActionButton: Visibility(
//         visible: isFabVisible,
//         child: FloatingActionButton(
//           backgroundColor: AppColors.maroon08,
//           child: Icon(
//             Icons.expand_less,
//             size: Sizes.ICON_SIZE_18,
//             color: AppColors.white,
//           ),
//           onPressed: () {
//             scrollToSection(navItems[0].key!);
//           },
//         ),
//       ),
//       body: NotificationListener<UserScrollNotification>(
//         onNotification: (notification) {
//           if (notification.direction == ScrollDirection.forward) {
//             if (!isFabVisible) setState(() => isFabVisible = true);
//           } else if (notification.direction == ScrollDirection.reverse) {
//             if (isFabVisible) setState(() => isFabVisible = false);
//           }
//           return true;
//         },
//         child: Column(
//           children: [
//             ResponsiveBuilder(
//               refinedBreakpoints: RefinedBreakpoints(),
//               builder: (context, sizingInformation) {
//                 double screenWidth = sizingInformation.screenSize.width;
//                 if (screenWidth < RefinedBreakpoints().desktopSmall) {
//                   return NavSectionMobile(
//                     scaffoldKey: _scaffoldKey,
//                   );
//                 } else {
//                   ///old
//                   // return NavSectionWeb(
//                   //   navItems: navItems,
//                   // );
//                   ///new added as of may 15,2025
//                   return NavSectionWeb(
//                     navItems: navItems,
//                     // onNavItemSelected: (key) {
//                     //   if (key.currentContext != null) {
//                     //     scrollToSection(key.currentContext!);
//                     //   }
//                     // },
//                     onNavItemSelected: (key) {
//                       WidgetsBinding.instance.addPostFrameCallback((_) {
//                         if (key.currentContext != null) {
//                           scrollToSection(key);
//                         }
//                       });
//                     },
//
//                   );
//
//                 }
//               },
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 controller: _scrollController,
//                 child: Column(
//                   children: [
//                     Stack(
//                       children: [
//                         Column(
//                           children: [
//
//                             HeaderResponsive(
//                               key: navItems[0].key,
//                             ),
//
//                             Stack(
//                               clipBehavior: Clip.none,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       key: navItems[1].key,
//                                       child: ProductsAndServicesV2(),
//                                     ),
//                                     Container(
//                                       key: navItems[2].key,
//                                       child: ClientsList(),
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//
//                             Stack(
//                               children: [
//                                 Column(
//                                   children: [
//                                     LeadingBankingPartnerSection(),
//                                     // Container(
//                                     //   key: navItems[3].key,
//                                     //   child: InsightSection(),
//                                     // ),
//                                     LayoutBuilder(
//                                       builder: (context, constraints) {
//                                         // final isMobile = constraints.maxWidth < 800;
//                                         final double totalWidth = constraints.maxWidth;
//                                         final double contactFormWidth = 850; // Estimated width of your form
//                                         final double sidePadding = 40;
//                                         final double remainingWidth = totalWidth - contactFormWidth - sidePadding * 4;
//
//                                         return Stack(
//                                           children: [
//                                             Container(
//
//                                               key: navItems[5].key,
//                                               child: ContactUsPage(),
//                                             ),
//                                               Positioned(
//                                                 top: 40,
//                                                 left: contactFormWidth + sidePadding,
//                                                 child: const OurLocationSection(),
//                                               ),
//                                           ],
//                                         );
//                                       },
//                                     ),
//
//                                     //FooterSection(),
//                                     FooterSectionv2()
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         Positioned(
//                           top: MediaQuery.of(context).size.height * 0.45,
//                           left: (MediaQuery.of(context).size.width - 1300) /2 ,
//                           child: Center(
//                             child: Image.asset(
//                               'assets/images/phone-web.png',
//                               width: 1300,
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     //       SizedBox(height: spacerHeight),
//
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   void _onScroll() {
//     for (var item in navItems) {
//       final context = item.key?.currentContext;
//       if (context != null) {
//         final box = context.findRenderObject() as RenderBox;
//         final position = box.localToGlobal(Offset.zero).dy;
//
//         // Adjust the visible range to suit your needs
//         if (position >= 0 && position < MediaQuery.of(context).size.height / 2) {
//           if (!item.isSelected) {
//             setState(() {
//               updateSelectedNavItem(item.name);
//             });
//           }
//           break;
//         }
//       }
//     }
//   }
//
// }

// Modified HomepageScreen with updated responsive layout and container-styled buttons

import 'package:FDS_ASYA_PHILIPPINES/ui/screens/clients/clients_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/about/about_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_responsive_section/header_responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_responsive_section/header_responsive_web.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/our_location_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_web.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/product_services_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/products_and_services_v2/products_and_servicesv2.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/functions.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/keys.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/NavItemData_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../clients/components/alternative_deliveries_solution.dart';
import '../shared/widgets/buttons/footer.dart';
import 'components/insightsv2/main_features.dart';
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
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ScrollTarget.targetKey != null) {
        scrollToSection(ScrollTarget.targetKey!);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.of(context).size.width;
    final imageAspectRatio = 3 / 1;
    final imageHeight = imageWidth / imageAspectRatio;
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: _scaffoldKey,
      drawer: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          return sizingInformation.screenSize.width < 900
              ? SideMenu()
              : Container();
        },
      ),
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: FloatingActionButton(
          backgroundColor: AppColors.maroon08,
          child: Icon(Icons.expand_less,
              size: Sizes.ICON_SIZE_18, color: AppColors.white),
          onPressed: () => scrollToSection(homeKey!),
        ),
      ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward &&
              !isFabVisible) {
            setState(() => isFabVisible = true);
          } else if (notification.direction == ScrollDirection.reverse &&
              isFabVisible) {
            setState(() => isFabVisible = false);
          }
          return true;
        },
        child: Column(
          children: [
            ResponsiveBuilder(
              builder: (context, sizingInfo) {
                return sizingInfo.screenSize.width < 900
                    ? NavSectionMobile(scaffoldKey: _scaffoldKey)
                    : NavSectionWeb(
                        navItems: navItems,
                        onNavItemSelected: (key) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (key.currentContext != null)
                              scrollToSection(key);
                          });
                        },
                      );
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
                            HeaderResponsiveWeb(key: homeKey),
                            imageWidth <= 800
                                ? SizedBox(height: imageHeight)
                                : SizedBox(height: imageHeight * 0.20),
                            Column(
                              children: [
                                Container(
                                  key: servicesKey,
                                  child: AlternativeDeliveriesSolution(),
                                ),
                                // Container(
                                //   key: insightsKey,
                                //   child: MainFeaturedSection(),
                                // ),
                                SizedBox(height: 100),
                                // const MainFeaturedSection(),  // Add this line
                                Container(
                                  key: clientKey,
                                  child: ClientsList(),
                                ),
                              ],
                            ),
                            LeadingBankingPartnerSection(),
                            // Container(
                            //   key: insightsKey,
                            //   child: MainFeaturedSection(),
                            // ),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                final totalWidth = constraints.maxWidth;
                                final isDesktop = totalWidth > 1100;
                                final contactFormWidth = 850.0;
                                final sidePadding = 40.0;

                                if (isDesktop) {
                                  // Desktop layout: side by side using Row
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40.0, vertical: 40.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          key: contactKey,
                                          width: contactFormWidth,
                                          child: ContactUsPage(),
                                        ),
                                        const SizedBox(
                                            width:
                                                40), // space between form and location
                                        Expanded(
                                          child: OurLocationSection(),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  // Mobile layout: stacked
                                  return Column(
                                    children: [
                                      Container(
                                        key: contactKey,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: ContactUsPage(),
                                      ),
                                      const SizedBox(height: 20),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: OurLocationSection(),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                            FooterSectionv2(),
                          ],
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.17,
                          left: (MediaQuery.of(context).size.width - 1130) / 2,
                          child: Center(
                            child: Image.asset(
                              'assets/images/phone-web.png',
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.95,
                              fit: BoxFit.contain,
                            ),
                          ),
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

  ///old changed june 09, 2025
  // void _onScroll() {
  //   for (var item in navItems) {
  //     final context = item.key?.currentContext;
  //     if (context != null) {
  //       final box = context.findRenderObject() as RenderBox;
  //       final position = box.localToGlobal(Offset.zero).dy;
  //       if (position >= 0 && position < MediaQuery.of(context).size.height / 2) {
  //         if (!item.isSelected) {
  //           setState(() {
  //             updateSelectedNavItem(item.name);
  //           });
  //         }
  //         break;
  //       }
  //     }
  //   }
  // }
  void _onScroll() {
    for (var item in navItems) {
      final context = item.key?.currentContext;
      if (context != null) {
        try {
          final box = context.findRenderObject() as RenderBox;
          final position = box.localToGlobal(Offset.zero).dy;
          if (position >= 0 &&
              position < MediaQuery.of(context).size.height / 2) {
            if (!item.isSelected) {
              setState(() {
                updateSelectedNavItem(item.name);
              });
            }
            break;
          }
        } catch (_) {}
      }
    }
  }
}
