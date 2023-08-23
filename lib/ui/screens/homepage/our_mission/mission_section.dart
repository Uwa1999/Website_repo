import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/styles.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/content_area.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MissionSection extends StatefulWidget {
  const MissionSection({Key? key}) : super(key: key);

  @override
  State<MissionSection> createState() => _MissionSectionState();
}

class _MissionSectionState extends State<MissionSection> with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late AnimationController _fadeInController;
  late Animation<double> _fadeInAnimation;

  // @override
  // void initState() {
  //   super.initState();
  //   _scaleController = AnimationController(
  //     duration: const Duration(milliseconds: 750),
  //     vsync: this,
  //   );
  //   _fadeInController = AnimationController(
  //     duration: const Duration(seconds: 1),
  //     vsync: this,
  //   );
  //   _scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
  //     CurvedAnimation(
  //       parent: _scaleController,
  //       curve: Curves.fastOutSlowIn,
  //     ),
  //   );
  //   _fadeInAnimation = Tween(begin: 0.0, end: 1.0).animate(
  //     CurvedAnimation(
  //       parent: _fadeInController,
  //       curve: Curves.fastOutSlowIn,
  //     ),
  //   );
  //
  //   _scaleController.addStatusListener((status) {
  //     if (status == AnimationStatus.completed) {
  //       _fadeInController.forward();
  //     }
  //   });
  // }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = widthOfScreen(context) - getSidePadding(context) * 2;
    double screenHeight = heightOfScreen(context);
    double contentAreaWidthSm = screenWidth * 1.1;
    double contentAreaHeightSm = screenHeight * 0.6;
    double contentAreaWidthLg = screenWidth * 1.0;
    double contentAreaWidth = screenWidth;
    return VisibilityDetector(
      key: Key('about-section'),
      onVisibilityChanged: (visibilityInfo) {
        double visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 25) {
          // _scaleController.forward();
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: getSidePadding(context)),
        child: ResponsiveBuilder(
          refinedBreakpoints: RefinedBreakpoints(),
          builder: (context, sizingInformation) {
            double screenWidth = sizingInformation.screenSize.width;
            if (screenWidth < (RefinedBreakpoints().tabletLarge)) {
              return Column(
                children: [
                  // ContentArea(
                  //   width: contentAreaWidthSm,
                  //   child: _buildFdsapLogo(
                  //     width: contentAreaWidthSm,
                  //     height: contentAreaHeightSm,
                  //   ),
                  // ),
                  // SizedBoxH10(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ContentArea(
                      width: contentAreaWidthSm,
                      child: _buildAboutUs(
                        width: contentAreaWidthSm,
                        height: screenHeight,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBoxH80(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ContentArea(
                      //   width: contentAreaWidthLg,
                      //   child: _buildMissionVisionLogo(
                      //     width: contentAreaWidthLg,
                      //     height: screenHeight,
                      //   ),
                      // ),
                      ContentArea(
                        width: contentAreaWidthLg,
                        child: _buildAboutUs(
                          width: contentAreaWidthLg,
                          height: screenHeight,
                        ),
                      ),
                    ],
                  ),
                  SizedBoxH80(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildMissionVisionLogo({required double width, required double height}) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double fontSize = responsiveSize(context, 60, 72, md: 64);
    TextStyle? titleStyle = textTheme.bodySmall?.merge(
      Styles.customTextStyle3(fontSize: fontSize, height: 1.25),
    );

    return Stack(
      children: [
        Image.asset(
          ImagePath.FDSAP_MISSION_VISION,
          width: width * 0.70,
        ),
      ],
    );
  }

  Widget _buildAboutUs({
    required double width,
    required double height,
  }) {
    return Stack(
      children: [
        ResponsiveBuilder(
          refinedBreakpoints: RefinedBreakpoints(),
          builder: (context, sizingInformation) {
            double screenWidth = sizingInformation.screenSize.width;
            if (screenWidth < (RefinedBreakpoints().tabletNormal)) {
              return nimbusInfoSectionSm(width: width);
            } else {
              return Container(
                width: width * 0.80,
                child: nimbusInfoSectionLg(),
              );
            }
          },
        ),
      ],
    );
  }

  Widget nimbusInfoSectionLg() {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: !isMobile(context) ? 15 : 0),
                child: NimbusInfoSection2(
                  title1: StringConst.FDSAP_VISION_TITLE,
                  body: StringConst.FDSAP_VISION_DESC,
                  title1Style: GoogleFonts.poppins(
                    fontSize: Sizes.TEXT_SIZE_35,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
              ),
              SizedBoxH40(),
              Padding(
                padding: EdgeInsets.only(right: !isMobile(context) ? 15 : 0),
                child: NimbusInfoSection2(
                  title1: StringConst.FDSAP_MISSION_TITLE,
                  body: StringConst.FDSAP_MISSION_DESC,
                  title1Style: GoogleFonts.poppins(
                    fontSize: Sizes.TEXT_SIZE_35,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget nimbusInfoSectionSm({required double width}) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: !isMobile(context) ? 15 : 0),
                child: NimbusInfoSection2(
                  title1: StringConst.FDSAP_VISION_TITLE,
                  body: StringConst.FDSAP_VISION_DESC,
                  title1Style: GoogleFonts.poppins(
                    fontSize: Sizes.TEXT_SIZE_18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: !isMobile(context) ? 15 : 0),
                child: NimbusInfoSection2(
                  title1: StringConst.FDSAP_MISSION_TITLE,
                  body: StringConst.FDSAP_MISSION_DESC,
                  title1Style: GoogleFonts.poppins(
                    fontSize: Sizes.TEXT_SIZE_18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}