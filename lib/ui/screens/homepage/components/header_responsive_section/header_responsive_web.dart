import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_responsive_section/widgets.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/content_area.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double bodyTextSizeLg = 16.0;
const double bodyTextSizeSm = 14.0;
const double socialTextSizeLg = 18.0;
const double socialTextSizeSm = 14.0;

class HeaderResponsiveWeb extends StatefulWidget {
  @override
  _HeaderResponsiveWebState createState() => _HeaderResponsiveWebState();
}

class _HeaderResponsiveWebState extends State<HeaderResponsiveWeb> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double headerIntroTextSize = responsiveSize(
      context,
      Sizes.TEXT_SIZE_24,
      Sizes.TEXT_SIZE_48,
      md: Sizes.TEXT_SIZE_36,
    );
    double screenWidth = widthOfScreen(context);
    double sizeOfBlobSm = screenWidth * 0.3;
    double sizeOfGoldenGlobe = screenWidth * 0.2;
    double dottedGoldenGlobeOffset = sizeOfBlobSm * 0.4;
    double heightOfBlobAndGlobe = computeHeight(dottedGoldenGlobeOffset, sizeOfGoldenGlobe, sizeOfBlobSm);
    double heightOfStack = heightOfBlobAndGlobe * 2;
    return ContentArea(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    child: Image.asset(
                      ImagePath.HOME_BACKGROUND,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: heightOfStack * 0.15,
                      left: (sizeOfBlobSm * 0.35),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: screenWidth),
                              child: Text(
                                StringConst.INTRO,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                  fontSize: headerIntroTextSize,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: screenWidth),
                              child: Text(
                                StringConst.INTRO2,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                  fontSize: headerIntroTextSize,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: screenWidth),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    StringConst.INTRO3,
                                    textAlign: TextAlign.start,
                                    speed: Duration(milliseconds: 100),
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: headerIntroTextSize,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                                onTap: () {},
                                isRepeatingAnimation: true,
                                repeatForever: true,
                              ),
                            ),
                            SizedBoxH16(),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: screenWidth * 0.50),
                              child: SelectableText(
                                StringConst.ABOUT_DEV,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.poppins(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  height: 1.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
