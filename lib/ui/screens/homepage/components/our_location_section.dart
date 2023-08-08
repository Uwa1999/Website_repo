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
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class OurLocationSection extends StatefulWidget {
  const OurLocationSection({Key? key}) : super(key: key);

  @override
  State<OurLocationSection> createState() => _OurLocationSectionState();
}

class _OurLocationSectionState extends State<OurLocationSection> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = widthOfScreen(context) - getSidePadding(context);
    double screenHeight = heightOfScreen(context);
    double contentAreaWidthSm = screenWidth * 1.0;
    double contentAreaHeightSm = screenHeight * 0.6;
    double contentAreaWidthLg = screenWidth * 1.2;
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
                  ContentArea(
                    width: contentAreaWidthSm,
                    child: _buildLocation(
                      width: contentAreaWidthSm,
                      height: screenHeight,
                    ),
                  ),
                  ContentArea(
                    width: contentAreaWidthSm,
                    child: _buildLocationImage(
                      width: contentAreaWidthSm,
                      height: contentAreaHeightSm,
                    ),
                  ),
                  SizedBoxH30(),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBoxH50(),
                  ContentArea(
                    width: contentAreaWidthLg,
                    child: _buildLocation(
                      width: contentAreaWidthLg,
                      height: screenHeight,
                    ),
                  ),
                  ContentArea(
                    width: contentAreaWidthLg,
                    child: _buildLocationImage(
                      width: contentAreaWidthLg,
                      height: screenHeight,
                    ),
                  ),
                  SizedBoxH50(),
                ],
              );
            }
          },
        ),
      ),
    );
    // return Column(
    //   children: [
    //     ContentArea(
    //       child: NimbusInfoSection2(
    //         title1: StringConst.OUR_LOCATION,
    //         hasTitle2: false,
    //         title1Style: GoogleFonts.poppins(
    //           fontSize: Sizes.TEXT_SIZE_35,
    //           fontWeight: FontWeight.w700,
    //           color: AppColors.black,
    //         ),
    //       ),
    //     ),
    //     SizedBoxH20(),
    //     Stack(
    //       children: [
    //         Padding(
    //           padding: EdgeInsets.only(
    //             left: Sizes.PADDING_80,
    //             right: Sizes.PADDING_80,
    //           ),
    //           child: ContentArea(
    //             width: double.infinity,
    //             height: MediaQuery.of(context).size.height * 0.7,
    //             backgroundColor: AppColors.maroon03,
    //             borderRadius: const BorderRadius.all(
    //               Radius.circular(Sizes.RADIUS_8),
    //             ),
    //             child: ClipRRect(
    //               borderRadius: const BorderRadius.all(
    //                 Radius.circular(Sizes.RADIUS_8),
    //               ),
    //               child: Padding(
    //                 padding: const EdgeInsets.all(5.0),
    //                 child: InkWell(
    //                   onTap: _launchURL,
    //                   child: Image.asset(
    //                     ImagePath.BOX_COVER_MAP,
    //                     fit: BoxFit.cover,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //     SizedBoxH50(),
    //   ],
    // );
  }

  Widget _buildLocationImage({required double width, required double height}) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double fontSize = responsiveSize(context, 60, 72, md: 64);
    TextStyle? titleStyle = textTheme.bodySmall?.merge(
      Styles.customTextStyle3(fontSize: fontSize, height: 1.25),
    );

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            right: Sizes.PADDING_70,
          ),
          child: ContentArea(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.7,
            backgroundColor: AppColors.maroon03,
            borderRadius: const BorderRadius.all(
              Radius.circular(Sizes.RADIUS_8),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(Sizes.RADIUS_8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                  onTap: _launchURL,
                  child: Image.asset(
                    ImagePath.BOX_COVER_MAP,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocation({
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
                child: NimbusInfoSection2(
                  title1: StringConst.OUR_LOCATION,
                  hasTitle2: false,
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
                  title1: StringConst.OUR_LOCATION,
                  hasTitle2: false,
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

_launchURL() async {
  print('-----FDSAP GOOGLE MAP LOCATION-----');
  final Uri url = Uri.parse(StringConst.LOCATION_URL);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch');
  }
}
