import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/content_area.dart';
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
    return VisibilityDetector(
      key: Key('our-team-section'),
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
          Container(
            padding: EdgeInsets.only(left: getSidePadding(context)),
            child: ResponsiveBuilder(
              refinedBreakpoints: RefinedBreakpoints(),
              builder: (context, sizingInformation) {
                double screenWidth = sizingInformation.screenSize.width;
                if (screenWidth <= 1024) {
                  return Column(
                    children: [
                      ResponsiveBuilder(
                        builder: (context, sizingInformation) {
                          double screenWidth = sizingInformation.screenSize.width;
                          if (screenWidth < (RefinedBreakpoints().tabletSmall)) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: _buildNimbusInfoSectionSm(),
                                ),
                                SizedBoxH20(),
                              ],
                            );
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: _buildNimbusInfoSectionSm(),
                                ),
                                SizedBoxH20(),
                              ],
                            );
                          }
                        },
                      ),
                      ResponsiveBuilder(
                        builder: (context, sizingInformation) {
                          double screenWidth = sizingInformation.screenSize.width;
                          if (screenWidth < (RefinedBreakpoints().tabletSmall)) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                children: [
                                  Center(
                                    child: _buildOrgChartImage(),
                                  ),
                                  SizedBoxH50(),
                                ],
                              ),
                            );
                          } else {
                            return Column(
                              children: [
                                Center(
                                  child: _buildOrgChartImage(),
                                ),
                                SizedBoxH40(),
                              ],
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
                      SizedBoxH80(),
                      Center(
                        child: Container(
                          child: _buildNimbusInfoSectionLg(),
                        ),
                      ),
                      SizedBoxH20(),
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
