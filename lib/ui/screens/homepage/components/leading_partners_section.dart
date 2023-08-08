import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/data.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';

class StatItemData {
  final int? value;
  final String subtitle;
  final String? values;

  StatItemData({
    this.value,
    required this.subtitle,
    this.values,
  });
}

class LeadingBankingPartnerSection extends StatefulWidget {
  LeadingBankingPartnerSection({Key? key});
  @override
  _LeadingBankingPartnerSectionState createState() => _LeadingBankingPartnerSectionState();
}

class _LeadingBankingPartnerSectionState extends State<LeadingBankingPartnerSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double contentAreaWidth = widthOfScreen(context) - (getSidePadding(context) * 2);
    return VisibilityDetector(
      key: Key('statistics-section'),
      onVisibilityChanged: (visibilityInfo) {
        double visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 30) {
          _controller.forward();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: getSidePadding(context)),
        child: Card(
          elevation: Sizes.ELEVATION_4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Sizes.RADIUS_10),
            ),
          ),
          color: AppColors.maroon03,
          child: ResponsiveBuilder(
            refinedBreakpoints: RefinedBreakpoints(),
            builder: (context, sizingInformation) {
              double screenWidth = sizingInformation.screenSize.width;
              if (screenWidth < (RefinedBreakpoints().tabletSmall)) {
                return Container(
                  width: contentAreaWidth,
                  padding: const EdgeInsets.symmetric(vertical: Sizes.PADDING_40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // SizedBoxH30(),
                      ..._buildItems(Data.statItemsData),
                      // SizedBoxH50(),
                    ],
                  ),
                );
              } else {
                return ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Sizes.RADIUS_10),
                    bottomRight: Radius.circular(Sizes.RADIUS_10),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -75,
                        left: -50,
                        child: Image.asset(
                          ImagePath.BLOB_FEMUR_ASH,
                          height: 200,
                        ),
                      ),
                      // Positioned(
                      //   right: -25,
                      //   bottom: -25,
                      //   child: Image.asset(
                      //     ImagePath.BLOB_BLACK,
                      //     height: 200,
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: Sizes.PADDING_40),
                        child: Column(
                          children: [
                            // Text(
                            //   StringConst.TITLE_STATS,
                            //   style: GoogleFonts.poppins(
                            //     color: AppColors.white,
                            //     fontSize: 40,
                            //   ),
                            // ),
                            SizedBoxH50(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Spacer(),
                                ..._buildItems(
                                  Data.statItemsData,
                                  isHorizontal: true,
                                ),
                                Spacer(),
                              ],
                            ),
                            SizedBoxH10(),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _buildItems(
    List<StatItemData> data, {
    bool isHorizontal = false,
  }) {
    List<Widget> items = [];
    for (int index = 0; index < data.length; index++) {
      items.add(
        StatItem(
          title: data[index].value!,
          subnum: data[index].values!,
          subtitle: data[index].subtitle,
          controller: _controller,
        ),
      );

      if (index < data.length - 1) {
        if (isHorizontal) {
          items.add(Spacer(flex: 2));
        } else {
          items.add(SizedBoxH40());
        }
      }
    }
    return items;
  }
}

class StatItem extends StatelessWidget {
  StatItem({
    required this.title,
    required this.subtitle,
    required this.controller,
    this.titleColor = AppColors.white,
    this.subtitleColor = AppColors.grey150,
    this.titleStyle,
    this.subtitleStyle,
    this.subnum,
    this.curve = Curves.easeIn,
  });

  final int title;
  final String subtitle;
  final String? subnum;
  final Color titleColor;
  final Color subtitleColor;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final AnimationController controller;
  final Curve curve;

  late Animation<int> animation = IntTween(begin: 0, end: title).animate(
    CurvedAnimation(
      parent: controller,
      curve: curve,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return _buildChild(context: context, value: animation.value, values: subnum);
      },
    );
  }

  Widget _buildChild({required BuildContext context, required int value, String? values}) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$value",
              style: GoogleFonts.poppins(color: titleColor, fontSize: 100),
            ),
            Text(
              "$values",
              style: GoogleFonts.poppins(color: titleColor, fontSize: 100),
            ),
          ],
        ),
        SizedBoxH12(),
        Text(
          subtitle,
          style: GoogleFonts.poppins(
            color: subtitleColor,
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}
