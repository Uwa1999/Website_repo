import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articles/article_screen.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articles/article_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articlesv2/components/articlescreenv2.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articlesv2/components/aticleSectionv2.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/buttons/footer.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_builder/responsive_builder.dart';

// class ArticleDescMain extends StatefulWidget {
//   static const String route = '/ArticleInside';
//   const ArticleDescMain({Key? key}) : super(key: key);
//
//   @override
//   State<ArticleDescMain> createState() => _ArticleDescMainState();
// }
//
// class _ArticleDescMainState extends State<ArticleDescMain> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//   bool isFabVisible = false;
//
//   @override
//   Widget build(BuildContext context) {
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
//                   return NavSectionMobile(
//                     scaffoldKey: _scaffoldKey,
//                   );
//                 } else {
//                   return HeaderSection();
//                 }
//               },
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Stack(children:[
//                       Container(
//                         height: 2000,
//                           width: double.infinity,
//                           child: Column(
//                         children: [
//                           ArticleDescSectionInsidev2(),
//                           ArticleDescScreenInsidev2(),
//                         ],
//                       )
//                       ),
//                      ] ),
//
//                     SizedBoxH10(),
//                     FooterSectionv2(),
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
class ArticleDescMain extends StatefulWidget {
  static const String route = '/ArticleInside';
  const ArticleDescMain({Key? key}) : super(key: key);

  @override
  State<ArticleDescMain> createState() => _ArticleDescMainState();
}

class _ArticleDescMainState extends State<ArticleDescMain> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  bool isFabVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    // Show FAB when near bottom (or you can change to currentScroll > 300)
    if (currentScroll >= maxScroll - 100) {
      if (!isFabVisible) setState(() => isFabVisible = true);
    } else {
      if (isFabVisible) setState(() => isFabVisible = false);
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

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
            Icons.expand_less, // change from expand_more to expand_less for "scroll to top"
            size: Sizes.ICON_SIZE_18,
            color: AppColors.white,
          ),
          onPressed: _scrollToTop,
        ),
      ),
      drawer: ResponsiveBuilder(
        refinedBreakpoints: RefinedBreakpoints(),
        builder: (context, sizingInformation) {
          double screenWidth = sizingInformation.screenSize.width;
          return screenWidth < RefinedBreakpoints().desktopSmall
              ? SideMenu()
              : const SizedBox();
        },
      ),
      body: Column(
        children: [
          ResponsiveBuilder(
            refinedBreakpoints: RefinedBreakpoints(),
            builder: (context, sizingInformation) {
              double screenWidth = sizingInformation.screenSize.width;
              return screenWidth < RefinedBreakpoints().desktopSmall
                  ? NavSectionMobile(scaffoldKey: _scaffoldKey)
                  : HeaderSection();
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 2000,
                        width: double.infinity,
                        child: Column(
                          children: [
                            ArticleDescSectionInsidev2(),
                            ArticleDescScreenInsidev2(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBoxH10(),
                  FooterSectionv2(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
