import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/content_area.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/fds_tagline_card.dart';
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

class _AboutSectionState extends State<AboutSection> {
  late AnimationController _scaleController;
  late AnimationController _fadeInController;

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
    double contentAreaWidthLg = screenWidth * 0.5;
    return VisibilityDetector(
      key: Key('about-section'),
      onVisibilityChanged: (visibilityInfo) {
        double visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 25) {}
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
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: ContentArea(
                      width: contentAreaWidthSm,
                      child: _buildAboutUs(
                        width: contentAreaWidthSm,
                      ),
                    ),
                  ),
                  SizedBoxH40(),
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
                        ),
                      ),
                    ],
                  ),
                  SizedBoxH20(),
                  FDSTaglineSection(),
                  SizedBoxH150(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildFdsapLogo({required double width, required double height}) {
    return Stack(
      children: [
        Image.asset(
          ImagePath.FDSAP_LOGO_MAROON,
          width: width * 0.70,
        ),
      ],
    );
  }

  Widget _buildAboutUs({
    required double width,
  }) {
    return Stack(
      children: [
        ResponsiveBuilder(
          refinedBreakpoints: RefinedBreakpoints(),
          builder: (context, sizingInformation) {
            double screenWidth = sizingInformation.screenSize.width;
            if (screenWidth < (RefinedBreakpoints().tabletNormal)) {
              return nimbusInfoSectionSm(
                width: width,
              );
            } else {
              return Container(
                width: width * 0.90,
                child: nimbusInfoSectionLg(),
              );
            }
          },
        ),
      ],
    );
  }

  Widget nimbusInfoSectionLg() {
    return NimbusInfoAboutSection(
      title1: StringConst.ABOUT,
      body: StringConst.ABOUT_US_DESC,
      body2: StringConst.ABOUT_US_DESC2,
      body3: StringConst.ABOUT_US_DESC3,
      title1Style: GoogleFonts.poppins(
        fontSize: Sizes.TEXT_SIZE_35,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
    );
  }

  Widget nimbusInfoSectionSm({required double width}) {
    return NimbusInfoAboutSection(
      title1: StringConst.ABOUT,
      body: StringConst.ABOUT_US_DESC,
      body2: StringConst.ABOUT_US_DESC2,
      body3: StringConst.ABOUT_US_DESC3,
      title1Style: GoogleFonts.poppins(
        fontSize: Sizes.TEXT_SIZE_18,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
    );
  }
}
