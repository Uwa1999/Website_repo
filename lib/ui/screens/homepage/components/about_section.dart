import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_responsive_section/widgets.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/data.dart';
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

const double kSpacingSm = 40.0;
const double kRunSpacingSm = 24.0;
const double kSpacingLg = 24.0;
const double kRunSpacingLg = 16.0;

class AboutSection extends StatefulWidget {
  AboutSection({Key? key});
  @override
  _AboutSectionState createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
// with TickerProviderStateMixin
{
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
    double screenWidth = widthOfScreen(context) - getSidePadding(context);
    double screenHeight = heightOfScreen(context);
    double contentAreaWidthSm = screenWidth * 1.0;
    double contentAreaHeightSm = screenHeight * 0.6;
    double contentAreaWidthLg = screenWidth * 0.5;
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
                  ContentArea(
                    width: contentAreaWidthSm,
                    child: _buildAboutUs(
                      width: contentAreaWidthSm,
                      height: screenHeight,
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBoxH50(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ContentArea(
                        width: contentAreaWidthLg,
                        child: _buildFdsapLogo(
                          width: contentAreaWidthLg,
                          height: screenHeight,
                        ),
                      ),
                      ContentArea(
                        width: contentAreaWidthLg,
                        child: _buildAboutUs(
                          width: contentAreaWidthLg,
                          height: screenHeight,
                        ),
                      ),
                    ],
                  ),
                  SizedBoxH10(),
                  ContentArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ...buildCardRow(
                          context: context,
                          data: Data.fdsTagLineCardData,
                          width: contentAreaWidth / 3.8,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildFdsapLogo({required double width, required double height}) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double fontSize = responsiveSize(context, 60, 72, md: 64);
    TextStyle? titleStyle = textTheme.bodySmall?.merge(
      Styles.customTextStyle3(fontSize: fontSize, height: 1.25),
    );

    return Stack(
      children: [
        Image.asset(
          ImagePath.LOGO_FDSAP,
          width: width * 0.70,
        ),
        // ScaleTransition(
        //   scale: _scaleAnimation,
        //   child: Image.asset(
        //     ImagePath.LOGO_FDSAP,
        //     width: width * 0.70,
        //   ),
        // ),
      ],
    );
  }

  Widget _buildAboutUs({
    required double width,
    required double height,
  }) {
    return Stack(
      children: [
        //positions blob on the far right of the section
        //based on the calculation only 10% of blob is showing
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
                child: NimbusInfoSection6(
                  title1: StringConst.ABOUT,
                  body: StringConst.ABOUT_ME_DESC,
                  body2: StringConst.ABOUT_ME_DESC2,
                  body3: StringConst.ABOUT_ME_DESC3,
                  title1Style: GoogleFonts.poppins(
                    fontSize: Sizes.TEXT_SIZE_35,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
              ),
              // Expanded(
              //   child: Container(
              //     // margin: EdgeInsets.only(left: (sizeOfBlobSm * 0.35)),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         ...buildCardRow(
              //           context: context,
              //           data: Data.nimbusCardData,
              //           width: double.infinity,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
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
                child: NimbusInfoSection6(
                  title1: StringConst.ABOUT,
                  body: StringConst.ABOUT_ME_DESC,
                  body2: StringConst.ABOUT_ME_DESC2,
                  body3: StringConst.ABOUT_ME_DESC3,
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
