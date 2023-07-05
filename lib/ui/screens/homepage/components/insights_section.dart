import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/data.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/content_area.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/insights_card.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

const double kSpacing = 28.0;
const double kRunSpacing = 16.0;

class InsightSection extends StatefulWidget {
  InsightSection({Key? key});
  @override
  _InsightSectionState createState() => _InsightSectionState();
}

class _InsightSectionState extends State<InsightSection> {
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
            SizedBoxH20(),
            ResponsiveBuilder(
              builder: (context, sizingInformation) {
                double screenWidth = sizingInformation.screenSize.width;
                double screenHeight = sizingInformation.screenSize.height;
                if (screenWidth <= (RefinedBreakpoints().tabletSmall)) {
                  return ContentArea(
                    padding: padding,
                    child: Column(
                      children: [
                        ContentArea(
                          width: contentAreaWidth,
                          child: NimbusInfoSection2(
                            title1: StringConst.INSIGHTS_TITLE_1,
                            //title2: StringConst.INSIGHTS_TITLE_2,
                            body: StringConst.INSIGHTS_DESC,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return ContentArea(
                    padding: padding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ContentArea(
                          width: screenWidth * 0.7,
                          child: NimbusInfoSection1(
                            title1: StringConst.INSIGHTS_TITLE_1,
                            //title2: StringConst.INSIGHTS_TITLE_2,
                            body: StringConst.INSIGHTS_DESC,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  );
                }
              },
            ),
            SizedBoxH20(),
            Padding(
              padding: padding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.9,
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
                                      SizedBoxH40(),
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

  // CarouselOptions carouselOptions({
  //   bool autoPlay = true,
  //   bool enlargeCenterPage = false,
  //   bool enableInfiniteScroll = true,
  //   double viewportFraction = 1.0,
  //   double aspectRatio = 0.1,
  //   int initialPage = 1,
  //   ScrollPhysics? scrollPhysics = const NeverScrollableScrollPhysics(),
  // }) {
  //   return CarouselOptions(
  //       autoPlay: autoPlay,
  //       enableInfiniteScroll: enableInfiniteScroll,
  //       enlargeCenterPage: enlargeCenterPage,
  //       viewportFraction: viewportFraction,
  //       aspectRatio: aspectRatio,
  //       initialPage: initialPage,
  //       scrollPhysics: scrollPhysics,
  //       onPageChanged: (int index, CarouselPageChangedReason reason) {
  //         setState(() {
  //           currentPageIndex = index.toDouble();
  //         });
  //       });
  // }

  List<Widget> _buildInsightCards({required List<InsightsData> insightsData, required double width, required context}) {
    double cardWidth = ((width - (kSpacing * 2)) / 4);
    List<Widget> items = [];
    List<VoidCallback> function = [
      () {
        print('-----SCREEN1-----');
      },
      () {
        print('-----SCREEN2-----');
      },
      () {
        print('-----SCREEN3-----');
      },
      () {
        print('-----SCREEN4-----');
      },
      () {
        print('-----SCREEN5-----');
      },
      () {
        print('-----SCREEN6-----');
      },
    ];
    for (int index = 0; index < insightsData.length; index++) {
      items.add(
        InsightsCard(
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
