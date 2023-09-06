import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articles/article_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/events/event_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/webinars/news_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/data.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/content_area.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/insights_data.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';

const double kSpacing = 28.0;
const double kRunSpacing = 16.0;

class InsightSection extends StatelessWidget {
  const InsightSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (!isMobile(context)) == (!isTab(context)) ? DesktopInsightSection() : MobileInsightSection();
  }
}

//Desktop Screen
class DesktopInsightSection extends StatefulWidget {
  DesktopInsightSection({Key? key});
  @override
  _DesktopInsightSectionState createState() => _DesktopInsightSectionState();
}

class _DesktopInsightSectionState extends State<DesktopInsightSection> {
  final int insightsLength = Data.insightsData.length;
  double currentPageIndex = 1;
  CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    EdgeInsetsGeometry padding = EdgeInsets.symmetric(horizontal: getSidePadding(context));
    double headerIntroTextSize = responsiveSize(
      context,
      Sizes.TEXT_SIZE_36,
      Sizes.TEXT_SIZE_56,
      md: Sizes.TEXT_SIZE_36,
    );
    double screenWidth = widthOfScreen(context) - (getSidePadding(context) * 2);
    double contentAreaWidth = responsiveSize(context, screenWidth, screenWidth * 0.6);

    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBoxH80(),
            ContentArea(
              padding: padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ContentArea(
                    width: screenWidth * 0.9,
                    child: NimbusInfoSection1(
                      title1: StringConst.INSIGHTS_TITLE_1,
                      //title2: StringConst.INSIGHTS_TITLE_2,
                      body: '',
                      title1Style: GoogleFonts.poppins(
                        fontSize: Sizes.TEXT_SIZE_35,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            // SizedBoxH20(),
            Padding(
              padding: padding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: new ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return new Container(
                            alignment: Alignment.center,
                            width: widthOfScreen(context),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: [
                                      Wrap(
                                        spacing: kSpacing,
                                        runSpacing: kRunSpacing,
                                        children: _buildInsightCards(
                                          context: context,
                                          insightsData: Data.insightsData,
                                          width: screenWidth,
                                        ),
                                      ),
                                      // SizedBoxH30(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // SizedBoxH80(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _buildInsightCards({required List<DesktopInsightsData> insightsData, required double width, required context}) {
    double cardWidth = ((width - (kSpacing * 2)) / 5);
    List<Widget> items = [];
    List<VoidCallback> function = [
      () {
        Navigator.of(context).pushNamed(ArticleDescMain.route);
        print('-----ARTICLE SCREEN-----');
      },
      () {
        Navigator.of(context).pushNamed(EventsDescMain.route);
        print('-----EVENTS SCREEN-----');
      },
      () {
        Navigator.of(context).pushNamed(NewsDescMain.route);
        print('-----NEWS SCREEN-----');
      },
    ];
    for (int index = 0; index < insightsData.length; index++) {
      items.add(
        DesktopInsightsCard(
          width: cardWidth,
          imageWidth: cardWidth,
          imageHeight: cardWidth,
          category: insightsData[index].category,
          title: Data.insightsData[index].title,
          subtitle: insightsData[index].subtitle,
          date: insightsData[index].date,
          //  buttonText: insightsData[index].buttonText,
          imageUrl: insightsData[index].imageUrl,
          onPressed: function[index],
        ),
      );
    }
    return items;
  }
}

//Mobile Screen
class MobileInsightSection extends StatefulWidget {
  const MobileInsightSection({Key? key}) : super(key: key);

  @override
  State<MobileInsightSection> createState() => _MobileInsightSectionState();
}

class _MobileInsightSectionState extends State<MobileInsightSection> {
  final int insightsLength = Data.insightsData.length;
  double currentPageIndex = 1;
  bool _isHoveringOnImage = false;
  bool _isHovered = false;
  Color startValue = Colors.black.withOpacity(0.5);
  Color targetValue = Colors.black.withOpacity(0);

  @override
  Widget build(BuildContext context) {
    double screenWidth = widthOfScreen(context) - (getSidePadding(context) * 2);
    // double screenWidth = widthOfScreen(context);
    double screenHeight = heightOfScreen(context);
    double contentAreaWidthSm = screenWidth * 1.1;
    double contentAreaHeightSm = screenHeight * 0.6;
    double contentAreaWidthLg = screenWidth * 0.5;
    TextTheme textTheme = Theme.of(context).textTheme;
    EdgeInsetsGeometry padding = EdgeInsets.symmetric(horizontal: getSidePadding(context));
    double headerIntroTextSize = responsiveSize(
      context,
      Sizes.TEXT_SIZE_36,
      Sizes.TEXT_SIZE_56,
      md: Sizes.TEXT_SIZE_36,
    );
    double contentAreaWidth = responsiveSize(context, screenWidth, screenWidth * 0.6);
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
                  SizedBoxH50(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ContentArea(
                      width: contentAreaWidthSm,
                      child: _buildMobileInsightInfoSm(
                        width: contentAreaWidthSm,
                        height: contentAreaHeightSm,
                      ),
                    ),
                  ),
                  SizedBoxH10(),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: MobileInsightsCard(),
                  ),
                  SizedBoxH40(),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBoxH40(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ContentArea(
                        //width: contentAreaWidthSm,
                        child: _buildMobileInsightInfoSm(
                          width: contentAreaWidthSm,
                          height: contentAreaHeightSm,
                        ),
                      ),
                    ],
                  ),
                  SizedBoxH10(),
                  Padding(
                    padding: padding,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: new ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return new Container(
                                  alignment: Alignment.center,
                                  width: widthOfScreen(context),
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Wrap(
                                          spacing: kSpacing,
                                          runSpacing: kRunSpacing,
                                          children: _buildTabInsightCards(
                                            context: context,
                                            insightsData: Data.insightsData,
                                            width: screenWidth,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
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

  List<Widget> _buildTabInsightCards({required List<DesktopInsightsData> insightsData, required double width, required context}) {
    double cardWidth = ((width - (kSpacing * 2)) / 5);
    List<Widget> items = [];
    List<VoidCallback> function = [
      () {
        Navigator.of(context).pushNamed(ArticleDescMain.route);
        print('-----ARTICLE SCREEN-----');
      },
      () {
        Navigator.of(context).pushNamed(EventsDescMain.route);
        print('-----EVENTS SCREEN-----');
      },
      () {
        Navigator.of(context).pushNamed(NewsDescMain.route);
        print('-----NEWS SCREEN-----');
      },
    ];
    for (int index = 0; index < insightsData.length; index++) {
      items.add(
        TabInsightsCard(
          width: cardWidth,
          imageWidth: cardWidth,
          imageHeight: cardWidth,
          category: insightsData[index].category,
          title: Data.insightsData[index].title,
          subtitle: insightsData[index].subtitle,
          date: insightsData[index].date,
          //  buttonText: insightsData[index].buttonText,
          imageUrl: insightsData[index].imageUrl,
          onPressed: function[index],
        ),
      );
    }
    return items;
  }

  Widget _buildMobileInsightInfoSm({
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
              return _buildInsightsInfoSm(
                width: width,
              );
            } else {
              return Container(
                width: width * 0.80,
                child: _buildInsightsInfoLg(),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildInsightsInfoSm({required width}) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NimbusInfoSection2(
                title1: StringConst.INSIGHTS_TITLE_1,
                title1Style: GoogleFonts.poppins(
                  fontSize: Sizes.TEXT_SIZE_18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
                hasTitle2: false,
                body: '',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInsightsInfoLg() {
    return NimbusInfoSection1(
      title1: StringConst.INSIGHTS_TITLE_1,
      hasTitle2: false,
      body: '',
      title1Style: GoogleFonts.poppins(
        fontSize: Sizes.TEXT_SIZE_35,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
    );
  }
}
