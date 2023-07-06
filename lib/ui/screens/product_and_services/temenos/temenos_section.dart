import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/styles.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/content_area.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';

class TemenosSection extends StatefulWidget {
  const TemenosSection({Key? key}) : super(key: key);

  @override
  State<TemenosSection> createState() => _TemenosSectionState();
}

class _TemenosSectionState extends State<TemenosSection> with SingleTickerProviderStateMixin {
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
    double contentAreaWidth = responsiveSize(
      context,
      screenWidth,
      screenWidth * 0.5,
      md: screenWidth * 0.5,
    );
    double contentAreaHeight = screenHeight * 0.9;
    return VisibilityDetector(
      key: Key('Temenos-section'),
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
                      ResponsiveBuilder(
                        builder: (context, sizingInformation) {
                          double screenWidth = sizingInformation.screenSize.width;
                          if (screenWidth < (RefinedBreakpoints().tabletSmall)) {
                            return _buildNimbusInfoSectionSm();
                          } else {
                            return _buildNimbusInfoSectionLg();
                          }
                        },
                      ),
                      SizedBoxH50(),
                      ResponsiveBuilder(
                        builder: (context, sizingInformation) {
                          double screenWidth = sizingInformation.screenSize.width;
                          if (screenWidth < (RefinedBreakpoints().tabletSmall)) {
                            return _buildImage(
                              width: screenWidth,
                              height: screenHeight * 0.5,
                            );
                          } else {
                            return Center(
                              child: _buildImage(
                                width: screenWidth * 0.75,
                                height: screenHeight * 0.75,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  );
                } else {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ContentArea(
                        width: contentAreaWidth,
                        height: contentAreaHeight,
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Spacer(),
                                    _buildNimbusInfoSectionLg(),
                                    Spacer(flex: 2),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      _buildImage(
                        width: contentAreaWidth,
                        height: contentAreaHeight,
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
    return NimbusInfoSection2(
      title1: StringConst.TEMENOS_TITLE,
      hasTitle2: false,
      body: StringConst.TEMENOS_DESC,
      child: Column(
        children: [],
      ),
    );
  }

  Widget _buildNimbusInfoSectionLg() {
    return NimbusInfoSection1(
      title1: StringConst.TEMENOS_TITLE,
      hasTitle2: false,
      body: StringConst.TEMENOS_DESC,
      child: Container(
        child: Row(
          children: [],
        ),
      ),
    );
  }

  Widget _buildImage({
    required double width,
    required double height,
  }) {
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
      width: width,
      height: height,
      child: Stack(
        children: [
          SizedBoxH50(),
          Stack(
            children: [
              Image.asset(
                'assets/gif/temenos_maroon.gif',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
