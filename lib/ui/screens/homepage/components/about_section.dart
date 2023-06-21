import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/functions.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/styles.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/buttons/social_button_2.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/content_area.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
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

class _AboutSectionState extends State<AboutSection> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late AnimationController _fadeInController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );
    _fadeInController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _fadeInAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeInController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadeInController.forward();
      }
    });
  }

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
    return VisibilityDetector(
      key: Key('about-section'),
      onVisibilityChanged: (visibilityInfo) {
        double visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 25) {
          _scaleController.forward();
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
                    child: _buildImage(
                      width: contentAreaWidthSm,
                      height: contentAreaHeightSm,
                    ),
                  ),
                  SizedBoxH10(),
                  ContentArea(
                    width: contentAreaWidthSm,
                    child: _buildAboutMe(
                      width: contentAreaWidthSm,
                      height: screenHeight,
                    ),
                  ),
                ],
              );
            } else {
              return Row(
                children: [
                  ContentArea(
                    width: contentAreaWidthLg,
                    child: _buildImage(
                      width: contentAreaWidthLg,
                      height: screenHeight,
                    ),
                  ),
                  ContentArea(
                    width: contentAreaWidthLg,
                    child: _buildAboutMe(
                      width: contentAreaWidthLg,
                      height: screenHeight,
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

  List<Widget> _buildSocialButtons(
    List<SocialButton2Data> data, {
    double? width,
  }) {
    List<Widget> items = [];

    for (int index = 0; index < data.length; index++) {
      items.add(
        SocialButton2(
          width: width,
          title: data[index].title.toUpperCase(),
          iconData: data[index].iconData,
          onPressed: () => openUrlLink(data[index].url),
          titleColor: data[index].titleColor,
          buttonColor: data[index].buttonColor,
          iconColor: data[index].iconColor,
        ),
      );
    }
    return items;
  }

  Widget _buildImage({required double width, required double height}) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double fontSize = responsiveSize(context, 60, 72, md: 64);
    TextStyle? titleStyle = textTheme.bodySmall?.merge(
      Styles.customTextStyle3(fontSize: fontSize, height: 1.25),
    );

    return Stack(
      children: [
        ScaleTransition(
          scale: _scaleAnimation,
          child: Image.asset(
            ImagePath.LOGO_FDSAP,
            width: width * 0.95,
          ),
        ),
      ],
    );
  }

  Widget _buildAboutMe({
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
                width: width * 0.85,
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
              NimbusInfoSection1(
                title1: '',
                title2: StringConst.OUR_HISTORY,
                body: StringConst.ABOUT_ME_DESC,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget nimbusInfoSectionSm({required double width}) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return NimbusInfoSection2(
      // sectionTitle: StringConst.ABOUT_ME,
      title1: StringConst.OUR_HISTORY,
      // title2: StringConst.OUR_HISTORY,
      body: StringConst.ABOUT_ME_DESC,
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       StringConst.FOLLOW_ME_1,
      //       style: textTheme.headlineMedium?.copyWith(color: AppColors.black),
      //     ),
      //     SpaceH16(),
      //     Wrap(
      //       spacing: kSpacingSm,
      //       runSpacing: kRunSpacingSm,
      //       children: _buildSocialButtons(Data.socialData2),
      //     ),
      //   ],
      // ),
    );
  }
}
