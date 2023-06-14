import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:FDS_ASYA_PHILIPPINES/presentation/layout/adaptive.dart';
import 'package:FDS_ASYA_PHILIPPINES/presentation/widgets/blog_card.dart';
import 'package:FDS_ASYA_PHILIPPINES/presentation/widgets/content_area.dart';
import 'package:FDS_ASYA_PHILIPPINES/presentation/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/presentation/widgets/spaces.dart';
import 'package:FDS_ASYA_PHILIPPINES/values/values.dart';
import 'package:responsive_builder/responsive_builder.dart';

const double kSpacing = 28.0;
const double kRunSpacing = 16.0;

class InsightSection extends StatefulWidget {
  InsightSection({Key? key});
  @override
  _InsightSectionState createState() => _InsightSectionState();
}

class _InsightSectionState extends State<InsightSection> {
  final int blogLength = Data.blogData.length;
  double currentPageIndex = 1;
  CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    EdgeInsetsGeometry padding =
        EdgeInsets.symmetric(horizontal: getSidePadding(context));
    double headerIntroTextSize = responsiveSize(
      context,
      Sizes.TEXT_SIZE_36,
      Sizes.TEXT_SIZE_56,
      md: Sizes.TEXT_SIZE_36,
    );
    double screenWidth = widthOfScreen(context) - (getSidePadding(context) * 2);
    double contentAreaWidth =
        responsiveSize(context, screenWidth, screenWidth * 0.6);

    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ResponsiveBuilder(builder: (context, sizingInformation) {
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
                          title1: StringConst.BLOG_SECTION_TITLE_1,
                          title2: StringConst.BLOG_SECTION_TITLE_2,
                          body: StringConst.BLOG_DESC,
                        ),
                      ),
                      SpaceH50(),
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
                          title1: StringConst.BLOG_SECTION_TITLE_1,
                          title2: StringConst.BLOG_SECTION_TITLE_2,
                          body: StringConst.BLOG_DESC,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                );
              }
            }),
            SpaceH40(),
            Padding(
              padding: padding,
              child: ResponsiveBuilder(
                builder: (context, sizingInformation) {
                  double widthOfScreen = sizingInformation.screenSize.width;
                  if (widthOfScreen < (RefinedBreakpoints().tabletLarge)) {
                    return Container(
                      width: widthOfScreen,
                      height: screenWidth + 250,
                      child: CarouselSlider.builder(
                        itemCount: blogLength,
                        itemBuilder: (BuildContext context, int index,
                            int pageViewIndex) {
                          return BlogCard(
                            width: screenWidth,
                            imageWidth: screenWidth,
                            imageHeight: screenWidth,
                            category: Data.blogData[index].category,
                            title: Data.blogData[index].title,
                            subtitle: Data.blogData[index].subtitle,
                            date: Data.blogData[index].date,
                            buttonText: Data.blogData[index].buttonText,
                            imageUrl: Data.blogData[index].imageUrl,
                            onPressed: () {},
                          );
                        },
                        options: carouselOptions(),
                      ),
                    );
                  } else if (widthOfScreen >=
                          RefinedBreakpoints().tabletLarge &&
                      widthOfScreen <= 1024) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: screenWidth,
                          child: CarouselSlider.builder(
                            itemCount: blogLength,
                            carouselController: _carouselController,
                            itemBuilder: (BuildContext context, int index,
                                int pageViewIndex) {
                              return BlogCard(
                                width: screenWidth * 0.45,
                                imageWidth: screenWidth * 0.45,
                                imageHeight: screenWidth * 0.45,
                                category: Data.blogData[index].category,
                                title: Data.blogData[index].title,
                                subtitle: Data.blogData[index].subtitle,
                                date: Data.blogData[index].date,
                                buttonText: Data.blogData[index].buttonText,
                                imageUrl: Data.blogData[index].imageUrl,
                                onPressed: () {},
                              );
                            },
                            options: carouselOptions(
                              viewportFraction: 0.50,
                              autoPlay: false,
                              initialPage: currentPageIndex.toInt(),
                              aspectRatio: 2 / 1.4,
                              enableInfiniteScroll: true,
                              enlargeCenterPage: false,
                            ),
                          ),
                        ),
                        _buildDotsIndicator(
                          pageLength: blogLength,
                          currentIndex: currentPageIndex,
                        ),
                        SpaceH100(),
                      ],
                    );
                  } else {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Wrap(
                            spacing: kSpacing,
                            runSpacing: kRunSpacing,
                            children: _buildBlogCards(
                              blogData: Data.blogData,
                              width: screenWidth,
                            ),
                          ),
                          SpaceH100(),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  CarouselOptions carouselOptions({
    bool autoPlay = true,
    bool enlargeCenterPage = false,
    bool enableInfiniteScroll = true,
    double viewportFraction = 1.0,
    double aspectRatio = 0.1,
    int initialPage = 1,
    ScrollPhysics? scrollPhysics = const NeverScrollableScrollPhysics(),
  }) {
    return CarouselOptions(
        autoPlay: autoPlay,
        enableInfiniteScroll: enableInfiniteScroll,
        enlargeCenterPage: enlargeCenterPage,
        viewportFraction: viewportFraction,
        aspectRatio: aspectRatio,
        initialPage: initialPage,
        scrollPhysics: scrollPhysics,
        onPageChanged: (int index, CarouselPageChangedReason reason) {
          setState(() {
            currentPageIndex = index.toDouble();
          });
        });
  }

  List<Widget> _buildBlogCards({
    required List<BlogCardData> blogData,
    required double width,
  }) {
    double cardWidth = ((width - (kSpacing * 2)) / 3);
    List<Widget> items = [];

    for (int index = 0; index < blogData.length; index++) {
      items.add(
        BlogCard(
          width: cardWidth,
          imageWidth: cardWidth,
          imageHeight: cardWidth,
          category: blogData[index].category,
          title: Data.blogData[index].title,
          subtitle: blogData[index].subtitle,
          date: blogData[index].date,
          buttonText: blogData[index].buttonText,
          imageUrl: blogData[index].imageUrl,
          onPressed: () {},
        ),
      );
    }
    return items;
  }

  Widget _buildDotsIndicator({
    required int pageLength,
    required double currentIndex,
  }) {
    return Container(
      child: DotsIndicator(
        dotsCount: pageLength,
        position: currentIndex,
        onTap: (index) {
          _moveToNextCarousel(index.toInt());
        },
        decorator: DotsDecorator(
          color: AppColors.maroon450,
          activeColor: AppColors.maroon450,
          size: Size(Sizes.SIZE_6, Sizes.SIZE_6),
          activeSize: Size(Sizes.SIZE_24, Sizes.SIZE_6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              const Radius.circular(Sizes.RADIUS_8),
            ),
          ),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              const Radius.circular(Sizes.RADIUS_8),
            ),
          ),
          spacing: EdgeInsets.symmetric(horizontal: Sizes.SIZE_4),
        ),
      ),
    );
  }

  _moveToNextCarousel(int index) {
    setState(() {
      currentPageIndex = index.toDouble();
      _carouselController.animateToPage(index);
    });
  }
}
