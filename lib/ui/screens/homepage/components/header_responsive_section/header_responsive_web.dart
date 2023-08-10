import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_responsive_section/widgets.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/data.dart';
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
// const double sidePadding = Sizes.PADDING_16;

class HeaderResponsiveWeb extends StatefulWidget {
  @override
  _HeaderResponsiveWebState createState() => _HeaderResponsiveWebState();
}

class _HeaderResponsiveWebState extends State<HeaderResponsiveWeb> with SingleTickerProviderStateMixin {
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
    TextTheme textTheme = Theme.of(context).textTheme;
    double headerIntroTextSize = responsiveSize(
      context,
      Sizes.TEXT_SIZE_24,
      Sizes.TEXT_SIZE_48,
      md: Sizes.TEXT_SIZE_36,
    );
    double bodyTextSize = responsiveSize(context, bodyTextSizeSm, bodyTextSizeLg);
    double socialTextSize = responsiveSize(context, socialTextSizeSm, socialTextSizeLg);
    double screenWidth = widthOfScreen(context);
    double contentAreaWidth = screenWidth;
    TextStyle? bodyTextStyle = textTheme.bodySmall?.copyWith(fontSize: bodyTextSize);
    TextStyle? socialTitleStyle = textTheme.bodySmall?.copyWith(fontSize: socialTextSize);

    List<Widget> cardsForTabletView = buildCardRow(
      context: context,
      data: Data.fdsTagLineCardData,
      width: contentAreaWidth * 0.4,
      isWrap: true,
    );
    double buttonWidth = responsiveSize(
      context,
      80,
      150,
    );
    double buttonHeight = responsiveSize(
      context,
      48,
      60,
      md: 54,
    );

    double sizeOfBlobSm = screenWidth * 0.3;
    double sizeOfGoldenGlobe = screenWidth * 0.2;
    double dottedGoldenGlobeOffset = sizeOfBlobSm * 0.4;
    double heightOfBlobAndGlobe = computeHeight(dottedGoldenGlobeOffset, sizeOfGoldenGlobe, sizeOfBlobSm);
    double heightOfStack = heightOfBlobAndGlobe * 2;
    double blobOffset = heightOfStack * 0.3;
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
                      // color: AppColors.accentColor100.withOpacity(0.9),
                      // colorBlendMode: BlendMode.modulate,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: heightOfStack * 0.15, left: (sizeOfBlobSm * 0.35)),
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
                              constraints: BoxConstraints(maxWidth: screenWidth * 0.35),
                              child: SelectableText(
                                StringConst.ABOUT_DEV,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.poppins(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                                // style: bodyTextStyle?.copyWith(height: 1.5),
                              ),
                            ),
                            SizedBoxH70(),
                            // Row(
                            //   children: [
                            //     ContactUsButton(
                            //       width: buttonWidth,
                            //       height: buttonHeight,
                            //       buttonTitle: StringConst.DOWNLOAD_CV,
                            //       opensUrl: true,
                            //       url: StringConst.EMAIL_URL,
                            //       titleStyle: GoogleFonts.poppins(
                            //         color: Colors.white,
                            //         fontWeight: FontWeight.w600,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // SizedBoxH10(),
              // Container(
              //   // margin: EdgeInsets.only(left: (sizeOfBlobSm * 0.35)),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       ...buildCardRow(
              //         context: context,
              //         data: Data.nimbusCardData,
              //         width: contentAreaWidth / 3.8,
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
