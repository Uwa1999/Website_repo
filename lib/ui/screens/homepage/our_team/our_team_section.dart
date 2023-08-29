import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/styles.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/content_area.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/empty.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';

class OurTeamSection extends StatefulWidget {
  const OurTeamSection({Key? key}) : super(key: key);

  @override
  State<OurTeamSection> createState() => _OurTeamSectionState();
}

class _OurTeamSectionState extends State<OurTeamSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool text1InView = false;
  bool text2InView = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _controller.forward();
    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = widthOfScreen(context) - (getSidePadding(context));
    double screenHeight = heightOfScreen(context);
    double contentAreaWidthSm = screenWidth * 1.1;
    double screenWidthLg = screenWidth * 1.1;
    double screenHeightLg = screenWidth * 1.1;
    double contentAreaWidth = responsiveSize(
      context,
      screenWidth,
      screenWidth * 0.5,
      md: screenWidth * 0.5,
    );
    double contentAreaHeight = screenHeight * 0.9;
    return VisibilityDetector(
      key: Key('k2c-section'),
      onVisibilityChanged: (visibilityInfo) {
        double visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 50) {
          setState(() {
            text1InView = true;
          });
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBoxH50(),
          Container(
            padding: EdgeInsets.only(left: getSidePadding(context)),
            child: ResponsiveBuilder(
              refinedBreakpoints: RefinedBreakpoints(),
              builder: (context, sizingInformation) {
                double screenWidth = sizingInformation.screenSize.width;
                if (screenWidth <= 1024) {
                  return Column(
                    children: [
                      SizedBoxH50(),
                      ResponsiveBuilder(
                        builder: (context, sizingInformation) {
                          double screenWidth = sizingInformation.screenSize.width;
                          if (screenWidth < (RefinedBreakpoints().tabletSmall)) {
                            return ContentArea(
                              // width: contentAreaWidthSm,
                              child: EmptyContainer(),
                            );
                          } else {
                            return ContentArea(
                                // width: contentAreaWidth * 0.7,
                                child: EmptyContainer());
                          }
                        },
                      ),
                      ResponsiveBuilder(
                        builder: (context, sizingInformation) {
                          double screenWidth = sizingInformation.screenSize.width;
                          if (screenWidth < (RefinedBreakpoints().tabletSmall)) {
                            return Center(
                              child: _buildOrgChartImage(
                                  // width: screenWidth,
                                  // height: screenHeight * 0.4,
                                  ),
                            );
                          } else {
                            return Center(
                              child: _buildOrgChartImage(),
                            );
                          }
                        },
                      ),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Center(
                      //   child: Container(
                      //     child: _buildNimbusInfoSectionLg(),
                      //   ),
                      // ),
                      // SizedBoxH10(),
                      Center(
                        child: _buildOrgChartImage(),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNimbusInfoSectionSm() {
    return NimbusInfoTeamSection(
      title1: StringConst.FDSAP_TEAM_TITLE,
      hasTitle2: false,
      body: StringConst.FDSAP_TEAM_DESC,
      title1Style: GoogleFonts.poppins(
        fontSize: Sizes.TEXT_SIZE_18,
        fontWeight: FontWeight.w700,
        color: AppColors.maroon04,
      ),
    );
  }

  Widget _buildNimbusInfoSectionLg() {
    return NimbusInfoTeamSection(
      title1: StringConst.FDSAP_TEAM_TITLE,
      hasTitle2: false,
      body: StringConst.FDSAP_TEAM_DESC,
      title1Style: GoogleFonts.poppins(
        fontSize: Sizes.TEXT_SIZE_35,
        fontWeight: FontWeight.w700,
        color: AppColors.maroon04,
      ),
    );
  }

  Widget _buildOrgChartImage() {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? titleStyle = textTheme.bodyText1?.merge(
      Styles.customTextStyle3(
        fontSize: responsiveSize(context, 64, 80, md: 76),
        height: 1.25,
        color: AppColors.primaryColor,
      ),
    );
    double textPosition = assignWidth(context, 0.1);
    return ContentArea(
      padding: EdgeInsets.only(
        right: Sizes.PADDING_60,
      ),
      child: Stack(
        children: [
          Image.asset(
            ImagePath.ORGANIZATION_CHART,
          ),
        ],
      ),
    );
  }
}
