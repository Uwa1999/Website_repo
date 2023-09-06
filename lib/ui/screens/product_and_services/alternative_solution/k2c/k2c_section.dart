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

class K2cSection extends StatefulWidget {
  const K2cSection({Key? key}) : super(key: key);

  @override
  State<K2cSection> createState() => _K2cSectionState();
}

class _K2cSectionState extends State<K2cSection> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = widthOfScreen(context) - getSidePadding(context) * 2;
    double screenHeight = heightOfScreen(context);
    double contentAreaWidthSm = screenWidth * 1.1;
    double contentAreaHeightSm = screenHeight * 0.6;
    double contentAreaWidthLg = screenWidth * 0.6;
    double contentAreaWidth = screenWidth;
    return VisibilityDetector(
      key: Key('k2c-section'),
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Center(
                      child: _buildK2cDesc(
                        width: contentAreaWidthSm,
                        height: screenHeight,
                      ),
                    ),
                  ),
                  SizedBoxH50(),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Center(
                      child: _buildK2cGIF(
                        width: contentAreaWidthSm,
                        height: contentAreaHeightSm,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ContentArea(
                        child: _buildK2cDesc(
                          width: contentAreaWidth * 0.7,
                          height: screenHeight,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: ContentArea(
                          child: _buildK2cGIF(
                            width: contentAreaWidthLg,
                            height: screenHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBoxH10(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildK2cGIF({required double width, required double height}) {
    return Stack(
      children: [
        Image.asset(
          ImagePath.K2C_GIF,
          width: width * 0.70,
        ),
      ],
    );
  }

  Widget _buildK2cDesc({
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
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: !isMobile(context) ? 15 : 0),
                child: NimbusInfoSection1(
                  title1: StringConst.KONEK2CARD_TITLE,
                  hasTitle2: false,
                  body: StringConst.KONEK2CARD_DESC,
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
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: !isMobile(context) ? 15 : 0),
                child: NimbusInfoSection2(
                  title1: StringConst.KONEK2CARD_TITLE,
                  hasTitle2: false,
                  body: StringConst.KONEK2CARD_DESC,
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
