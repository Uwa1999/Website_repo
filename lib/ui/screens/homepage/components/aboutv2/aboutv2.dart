import 'dart:convert';

import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/aboutv2/components/mission_vision_page.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/textwidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../shared/widgets/NavItemData_global.dart';
import '../../../shared/widgets/buttons/footer.dart';
import '../../../shared/utils/responsive.dart';
import '../../../shared/widgets/nav_item.dart';
import '../../homepage_screen.dart';
import '../header_section.dart';
import '../responsive_navigation/nav_section_mobile.dart';
import '../responsive_navigation/nav_section_web.dart';
import '../side_menu.dart';
import 'package:http/http.dart' as http;

class AboutUsSectionv2 extends StatefulWidget {
  static const String route = '/AboutUsSec';

  final List<NavItemData> navItems;

  const AboutUsSectionv2({Key? key, required this.navItems}) : super(key: key);

  @override
  State<AboutUsSectionv2> createState() => _AboutUsSectionv2State();
}
class _AboutUsSectionv2State extends State<AboutUsSectionv2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  bool isFabVisible = false;
  String? _aboutUsImage;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchImage();

    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;

      if (currentScroll >= maxScroll - 50) {
        if (!isFabVisible) {
          setState(() => isFabVisible = true);
        }
      } else {
        if (isFabVisible) {
          setState(() => isFabVisible = false);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> fetchImage() async {
    try {
      final response = await http.get(
          Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/images/index'),
        headers: {
            'Content-Type' : 'application/json; charset=UTF-8',
        }
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> imageData = jsonResponse['data'];
        final aboutUsImage  = imageData.firstWhere(
            (image) => image['name'] == 'about-us',
          orElse: ()=> null,
        );

        if (aboutUsImage != null) {
          final imageUrl = aboutUsImage['image_path'];
          if(mounted) {
            setState(() {
              _aboutUsImage = imageUrl;
              _isLoading = false;
            });
            precacheImage(CachedNetworkImageProvider(imageUrl), context);
          }
        } else {
          print('Image with name "about-us" not found.');
          if (mounted) setState(() => _isLoading = false);
        }
      } else {
        print('Failed to load images: ${response.statusCode}');
        if (mounted) setState(() => _isLoading = false);
      }
    } catch (e) {
      print('Error fetching images: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: FloatingActionButton(
          backgroundColor: AppColors.maroon08,
          child: Icon(
            Icons.expand_less,
            color: AppColors.white,
          ),
          onPressed: scrollToTop,
        ),
      ),
      drawer: ResponsiveBuilder(
        builder: (context, sizingInformation) {
          double screenWidth = sizingInformation.screenSize.width;
          return screenWidth < 900
              ? SideMenu()
              : Container();
        },
      ),
      body: Column(
        children: [
          ResponsiveBuilder(
            builder: (context, sizingInfo) {
              return sizingInfo.screenSize.width < 900
                  ? NavSectionMobile(scaffoldKey: _scaffoldKey)
                  : NavSectionWeb(
                navItems: widget.navItems,
                onNavItemSelected: (key) {
                  Navigator.pushNamed(context, HomepageScreen.route,
                      arguments: key);
                },
              );
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Container(
                    key: widget.navItems[4].key,
                    width: double.infinity,
                    height: 750,
                    padding: const EdgeInsets.only(top: 70, bottom: 70),
                    child: Column(
                      children: [
                        GradientText(
                          text: 'About Us',
                          gradient: LinearGradient(
                            colors: [AppColors.black, AppColors.maroon02, Colors.white, Colors.black],
                          ),
                          style: const TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: SizedBox(
                            width: 800,
                            child: Text(
                              '''FDS ASYA PHILIPPINES INC. (FDSAP) is a leader in digital services, whose success is also attributed to the support of an international alliance with our holding, FORTRESS DATA SERVICES INDONESIA FDSI). With a deep understanding of local businesses, we have played a vital role since 2015 in facilitating the digitalization journeys of CARD Bank, CARD RBI, and CARD SME. Throughout the years, we have become one of Southeast Asia's leading IT companies and continues to be a trustworthy and reliable partner in the financial industry.''',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  blackSpaceWithImage(context, imageUrl: _aboutUsImage),
                  Image(image: AssetImage('assets/images/org_chart.png')),
                  const FooterSectionv2(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget blackSpaceWithImage(BuildContext context, {String? imageUrl}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  final imageWidth = screenWidth + 100;

  final imageAspectRatio = 3 / 1;
  final imageHeight = imageWidth / imageAspectRatio;

  final isMobile = screenWidth < 600;

  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: double.infinity,
        color: Colors.black,
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            double textFontSize = (screenWidth * 0.03).clamp(30.0, 70.0);
            double bodyFontSize = (screenWidth * 0.02).clamp(14.0, 20.0);
            double imageWidth = (screenWidth * 0.3).clamp(200, 400);
            double rightPadding = screenWidth <= 600 ? 25 : 80;
            double leftPadding = screenWidth <= 600 ? 16 : 80;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/Frame 5588.png',
                      width: isMobile ? screenWidth : screenWidth * 0.8,
                      fit: isMobile ? BoxFit.contain : BoxFit.cover,
                    ),
                    Positioned(
                      bottom: isMobile ? 120 : 500,
                      left: 0,
                      right: 0,
                      child: Text(
                        'Listening is where the care begins.',
                        style: TextStyle(
                          fontSize: (screenWidth * 0.05).clamp(30.0, 50.0),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 150),
                // Mission Section
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(leftPadding, 0, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'With our Mission',
                                style: TextStyle(
                                  fontSize: textFontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 50),
                              Container(
                                width: 800,
                                child: Text(
                                  'To enable customers to enter digitalization with world-class solutions, at an unprecedented speed to market and affordable cost.',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/mission.png',
                        width: imageWidth,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
                // Vision Section
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/_new2.png',
                        width: imageWidth,
                        fit: BoxFit.contain,
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 50, rightPadding, 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'and a vision to',
                                style: TextStyle(
                                  fontSize: textFontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                'A leading banking partner transforming the regional economy and community through co-creation of value and innovation in the banking ecosystem.',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      Positioned(
        top: -imageHeight * .77,
        left: (screenWidth - imageWidth) / 20,
        child: (imageUrl != null && imageUrl.isNotEmpty)
            ? CachedNetworkImage(
          imageUrl: imageUrl,
          width: imageWidth - 100,
          fit: BoxFit.contain,
        )
            : Container(
          width: imageWidth - 100,
          height: (imageWidth - 100) * 0.5,
          color: Colors.grey[300],
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    ],
  );
}

// class _AboutUsSectionv2State extends State<AboutUsSectionv2> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//   bool isFabVisible = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Colors.transparent,
//       floatingActionButton: Visibility(
//         visible: isFabVisible,
//         child: FloatingActionButton(
//           backgroundColor: AppColors.maroon08,
//           child: Icon(
//             Icons.expand_more,
//             color: AppColors.white,
//           ),
//           onPressed: () {},
//         ),
//       ),
//       drawer: ResponsiveBuilder(
//         refinedBreakpoints: RefinedBreakpoints(),
//         builder: (context, sizingInformation) {
//           double screenWidth = sizingInformation.screenSize.width;
//           if (screenWidth < RefinedBreakpoints().desktopSmall) {
//             return const SideMenu();
//           } else {
//             return Container();
//           }
//         },
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
//         child: Column(
//           children: [
//             ResponsiveBuilder(
//               refinedBreakpoints: RefinedBreakpoints(),
//               builder: (context, sizingInformation) {
//                 double screenWidth = sizingInformation.screenSize.width;
//                 if (screenWidth < RefinedBreakpoints().desktopSmall) {
//                   return NavSectionMobile(scaffoldKey: _scaffoldKey);
//                 } else {
//                   return const HeaderSection();
//                 }
//               },
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       key: navItems[4].key,
//                       width: double.infinity,
//                       height: 750,
//                       padding: const EdgeInsets.only(top: 80, bottom: 80),
//                       child: Column(
//                         children: [
//                           GradientText(
//                             text: 'About Us',
//                             gradient: LinearGradient(
//                               colors: [AppColors.black, AppColors.maroon02, Colors.white, Colors.black],
//                             ),
//                             style: const TextStyle(
//                               fontSize: 60,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 24),
//                           const Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 32),
//                             child: SizedBox(
//                               width: 800,
//                               child: Text(
//                                 '''FDS ASYA PHILIPPINES INC. (FDSAP) is a leader in digital services, whose success is also attributed to the support of an international alliance with our holding, FORTRESS DATA SERVICES INDONESIA FDSI). With a deep understanding of local businesses, we have played a vital role since 2015 in facilitating the digitalization journeys of CARD Bank, CARD RBI, and CARD SME. Throughout the years, we have become one of Southeast Asia's leading IT companies and continues to be a trustworthy and reliable partner in the financial industry.''',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey,
//                                   height: 1.6,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     blackSpaceWithImage(context),
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 40),
//                       child: Image(image: AssetImage('assets/images/org_chart.png')),
//                     ),
//                     const FooterSectionv2(),
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