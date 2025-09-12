// ... (all existing imports)

import 'package:FDS_ASYA_PHILIPPINES/ui/screens/clients/clients_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_responsive_section/header_responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_responsive_section/header_responsive_web.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/our_location_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_web.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
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
import 'components/aboutv2/aboutv2.dart';
import 'components/insightsv2/main_features.dart';
import 'components/leading_partners_section.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      final GlobalKey? targetKey = ModalRoute.of(context)?.settings.arguments as GlobalKey?;
      if (targetKey != null) {
        scrollToSection(targetKey);
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
          if (notification.direction == ScrollDirection.forward && !isFabVisible) {
            setState(() => isFabVisible = true);
          } else if (notification.direction == ScrollDirection.reverse && isFabVisible) {
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
                      if (key.currentContext != null) scrollToSection(key);
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
                    HeaderResponsiveWeb(key: homeKey),
                    Container(
                      key: servicesKey,
                      child: AlternativeDeliveriesSolution(),
                    ),
                    SizedBox(height: 100),
                    Container(
                      key: clientKey,
                      child: ClientsList(),
                    ),
                    LeadingBankingPartnerSection(),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final totalWidth = constraints.maxWidth;
                        final isDesktop = totalWidth > 1100;
                        final contactFormWidth = 850.0;
                        final sidePadding = 40.0;

                        if (isDesktop) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 40.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  key: contactKey,
                                  width: contactFormWidth,
                                  child: ContactUsPage(),
                                ),
                                const SizedBox(width: 40),
                                Expanded(
                                  child: OurLocationSection(),
                                ),
                              ],
                            ),
                          );
                        } else {
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onScroll() {
    for (var item in navItems) {
      final context = item.key?.currentContext;
      if (context != null) {
        try {
          final box = context.findRenderObject() as RenderBox;
          final position = box.localToGlobal(Offset.zero).dy;
          if (position >= 0 && position < MediaQuery.of(context).size.height / 2) {
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