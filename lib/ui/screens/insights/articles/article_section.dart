// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class ArticleDescSection extends StatefulWidget {
//   static const String route = '/Article Inside';
//   const ArticleDescSection({Key? key}) : super(key: key);
//
//   @override
//   State<ArticleDescSection> createState() => _ArticleDescSectionState();
// }
//
// class _ArticleDescSectionState extends State<ArticleDescSection> {
//   @override
//   Widget build(BuildContext context) {
//     return (!isMobile(context)) == (!isTab(context)) ? DesktopArticleDescScreen() : MobileArticleDescScreen();
//   }
// }
//
// class DesktopArticleDescScreen extends StatefulWidget {
//   const DesktopArticleDescScreen({Key? key}) : super(key: key);
//
//   @override
//   State<DesktopArticleDescScreen> createState() => _DesktopArticleDescScreenState();
// }
//
// class _DesktopArticleDescScreenState extends State<DesktopArticleDescScreen> {
//   final ScrollController _scrollController = ScrollController();
//   bool isFabVisible = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(() {
//       final maxScroll = _scrollController.position.maxScrollExtent;
//       final currentScroll = _scrollController.position.pixels;
//
//       if (currentScroll >= maxScroll - 50) {
//         if (!isFabVisible) {
//           setState(() => isFabVisible = true);
//         }
//       } else {
//         if (isFabVisible) {
//           setState(() => isFabVisible = false);
//         }
//       }
//     });
//   }
//
//   void scrollToTop() {
//     _scrollController.animateTo(0.0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     TextStyle defaultTitleStyle = textTheme.headlineMedium?.copyWith(
//       fontSize: responsiveSize(context, 26, 36, md: 32),
//       color: AppColors.black,
//       fontWeight: FontWeight.bold,
//     ) ??
//         const TextStyle();
//
//     return Stack(
//       children: [
//         SingleChildScrollView(
//           controller: _scrollController,
//           padding: const EdgeInsets.symmetric(horizontal: 40),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 90),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Text(
//                   "Latest",
//                   style: textTheme.labelSmall?.copyWith(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               Container(
//                 width: 900,
//                 padding: const EdgeInsets.only(top: 40),
//                 child: Text(
//                   'Meet the team:\nProject Management Office',
//                   style: GoogleFonts.inter(
//                     fontSize: 42,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 40),
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.9,
//                 height: MediaQuery.of(context).size.height,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   image: const DecorationImage(
//                     image: AssetImage('assets/images/pmo1.png'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 100),
//             ],
//           ),
//         ),
//         if (isFabVisible)
//           Positioned(
//             bottom: 24,
//             right: 24,
//             child: FloatingActionButton(
//               backgroundColor: AppColors.maroon08,
//               onPressed: scrollToTop,
//               child: const Icon(Icons.expand_less, color: Colors.white),
//             ),
//           ),
//       ],
//     );
//   }
// }
// class MobileArticleDescScreen extends StatefulWidget {
//   const MobileArticleDescScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MobileArticleDescScreen> createState() => _MobileArticleDescScreenState();
// }
//
// class _MobileArticleDescScreenState extends State<MobileArticleDescScreen> {
//   final ScrollController _scrollController = ScrollController();
//   bool isFabVisible = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(() {
//       final maxScroll = _scrollController.position.maxScrollExtent;
//       final currentScroll = _scrollController.position.pixels;
//
//       if (currentScroll >= maxScroll - 50) {
//         if (!isFabVisible) {
//           setState(() => isFabVisible = true);
//         }
//       } else {
//         if (isFabVisible) {
//           setState(() => isFabVisible = false);
//         }
//       }
//     });
//   }
//
//   void scrollToTop() {
//     _scrollController.animateTo(0.0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         SingleChildScrollView(
//           controller: _scrollController,
//           child: Column(
//             children: [
//               const SizedBox(height: 30),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Text(
//                   'Meet the team:\nProject Management Office',
//                   style: GoogleFonts.inter(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.left,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.asset(
//                     'assets/images/pmo1.png',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 100),
//             ],
//           ),
//         ),
//         if (isFabVisible)
//           Positioned(
//             bottom: 24,
//             right: 24,
//             child: FloatingActionButton(
//               backgroundColor: AppColors.maroon08,
//               onPressed: scrollToTop,
//               child: const Icon(Icons.expand_less, color: Colors.white),
//             ),
//           ),
//       ],
//     );
//   }
// }
//

import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleDescSectionInside extends StatefulWidget {
  static const String route = '/Article Inside';
  const ArticleDescSectionInside({Key? key}) : super(key: key);

  @override
  State<ArticleDescSectionInside> createState() => _ArticleDescSectionInsideState();
}

class _ArticleDescSectionInsideState extends State<ArticleDescSectionInside> {
  @override
  Widget build(BuildContext context) {
    return (!isMobile(context)) == (!isTab(context))
        ? DesktopArticleDescScreen()
        : MobileArticleDescScreen();
  }
}

class DesktopArticleDescScreen extends StatefulWidget {
  const DesktopArticleDescScreen({Key? key}) : super(key: key);

  @override
  State<DesktopArticleDescScreen> createState() => _DesktopArticleDescScreenState();
}

class _DesktopArticleDescScreenState extends State<DesktopArticleDescScreen> {
  final ScrollController _scrollController = ScrollController();
  bool isFabVisible = false;

  @override
  void initState() {
    super.initState();
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

  void scrollToTop() {
    _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle defaultTitleStyle = textTheme.headlineMedium?.copyWith(
      fontSize: responsiveSize(context, 26, 36, md: 32),
      color: AppColors.black,
      fontWeight: FontWeight.bold,
    ) ??
        const TextStyle();

    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 90),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "Latest",
                  style: textTheme.labelSmall?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: 900,
                padding: const EdgeInsets.only(top: 40),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double fontSize = constraints.maxWidth * 0.045;
                    return Text(
                      'Meet the team:\nProject Management Office',
                      style: GoogleFonts.inter(
                        fontSize: fontSize.clamp(24, 48),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/pmo1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
        if (isFabVisible)
          Positioned(
            bottom: 24,
            right: 24,
            child: FloatingActionButton(
              backgroundColor: AppColors.maroon08,
              onPressed: scrollToTop,
              child: const Icon(Icons.expand_less, color: Colors.white),
            ),
          ),
      ],
    );
  }
}

class MobileArticleDescScreen extends StatefulWidget {
  const MobileArticleDescScreen({Key? key}) : super(key: key);

  @override
  State<MobileArticleDescScreen> createState() => _MobileArticleDescScreenState();
}

class _MobileArticleDescScreenState extends State<MobileArticleDescScreen> {
  final ScrollController _scrollController = ScrollController();
  bool isFabVisible = false;

  @override
  void initState() {
    super.initState();
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

  void scrollToTop() {
    _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double fontSize = constraints.maxWidth * 0.07;
                    return Text(
                      'Meet the team:\nProject Management Office',
                      style: GoogleFonts.inter(
                        fontSize: fontSize.clamp(20, 32),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/pmo1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
        if (isFabVisible)
          Positioned(
            bottom: 24,
            right: 24,
            child: FloatingActionButton(
              backgroundColor: AppColors.maroon08,
              onPressed: scrollToTop,
              child: const Icon(Icons.expand_less, color: Colors.white),
            ),
          ),
      ],
    );
  }
}
