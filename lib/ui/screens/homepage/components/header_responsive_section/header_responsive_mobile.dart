import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_responsive_section/widgets.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
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
const double sidePadding = Sizes.PADDING_26;

class HeaderResponsiveMobile extends StatefulWidget {
  const HeaderResponsiveMobile({Key? key}) : super(key: key);

  @override
  _HeaderResponsiveMobileState createState() => _HeaderResponsiveMobileState();
}

class _HeaderResponsiveMobileState extends State<HeaderResponsiveMobile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double headerIntroTextSize = Sizes.TEXT_SIZE_18;
    double screenWidth = widthOfScreen(context) - (sidePadding * 2);
    double buttonWidth = 80;
    double buttonHeight = 48;
    double sizeOfBlobSm = screenWidth * 0.4;
    double sizeOfGoldenGlobe = screenWidth * 0.3;
    double dottedGoldenGlobeOffset = sizeOfBlobSm * 0.4;
    double heightOfBlobAndGlobe = computeHeight(dottedGoldenGlobeOffset, sizeOfGoldenGlobe, sizeOfBlobSm);
    double heightOfStack = heightOfBlobAndGlobe * 2;
    return ContentArea(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.maroon03.withOpacity(1.0),
            AppColors.maroon05.withOpacity(0.8),
          ],
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: sidePadding),
                    margin: EdgeInsets.only(top: heightOfStack * 0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: screenWidth),
                              child: Text(
                                StringConst.INTRO,
                                style: GoogleFonts.poppins(
                                  fontSize: headerIntroTextSize,
                                  fontWeight: FontWeight.w500,
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
                                  fontWeight: FontWeight.w500,
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
                                      fontWeight: FontWeight.w500,
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
                              constraints: BoxConstraints(maxWidth: screenWidth),
                              child: SelectableText(
                                StringConst.ABOUT_DEV,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.white,
                                  fontSize: 14,
                                  height: 1.5,
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
