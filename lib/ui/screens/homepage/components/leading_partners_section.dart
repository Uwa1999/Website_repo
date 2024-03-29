import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/data.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/empty.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/leading_partner_data.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';

class LeadingBankingPartnerSection extends StatefulWidget {
  LeadingBankingPartnerSection({Key? key});
  @override
  _LeadingBankingPartnerSectionState createState() => _LeadingBankingPartnerSectionState();
}

class _LeadingBankingPartnerSectionState extends State<LeadingBankingPartnerSection> {
  @override
  Widget build(BuildContext context) {
    return (!isMobile(context)) == (!isTab(context)) ? DesktopLeadingPartners() : MobileLeadingPartners();
  }
}

class DesktopLeadingPartners extends StatefulWidget {
  const DesktopLeadingPartners({Key? key}) : super(key: key);

  @override
  State<DesktopLeadingPartners> createState() => _DesktopLeadingPartnersState();
}

class _DesktopLeadingPartnersState extends State<DesktopLeadingPartners> with SingleTickerProviderStateMixin {
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
    double contentAreaWidth = widthOfScreen(context) - (getSidePadding(context) * 2);
    return VisibilityDetector(
      key: Key('statistics-section'),
      onVisibilityChanged: (visibilityInfo) {
        double visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 30) {
          _controller.forward();
        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: getSidePadding(context)),
            child: Card(
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
                    return EmptyContainer();
                  } else {
                    return ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Sizes.RADIUS_10),
                        bottomRight: Radius.circular(Sizes.RADIUS_10),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: Sizes.PADDING_40,
                            ),
                            child: Column(
                              children: [
                                // Text(
                                //   StringConst.TITLE_STATS,
                                //   style: GoogleFonts.poppins(
                                //     color: AppColors.white,
                                //     fontSize: 40,
                                //   ),
                                // ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Spacer(),
                                    ..._buildItems(
                                      Data.LeadingBankingPartnerItemsData,
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
          SizedBoxH150(),
        ],
      ),
    );
  }

  List<Widget> _buildItems(
    List<LeadingBankingPartnerData> data, {
    bool isHorizontal = false,
  }) {
    List<Widget> items = [];
    for (int index = 0; index < data.length; index++) {
      items.add(
        LeadingBankingPartnerItem(
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

class MobileLeadingPartners extends StatefulWidget {
  const MobileLeadingPartners({Key? key}) : super(key: key);

  @override
  State<MobileLeadingPartners> createState() => _MobileLeadingPartnersState();
}

class _MobileLeadingPartnersState extends State<MobileLeadingPartners> with SingleTickerProviderStateMixin {
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
    double contentAreaWidth = widthOfScreen(context) - (getSidePadding(context) * 2);
    return VisibilityDetector(
      key: Key('statistics-section'),
      onVisibilityChanged: (visibilityInfo) {
        double visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 30) {
          _controller.forward();
        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: getSidePadding(context)),
            child: Card(
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
                      decoration: BoxDecoration(
                        color: AppColors.maroon03,
                        borderRadius: BorderRadius.all(
                          Radius.circular(Sizes.RADIUS_10),
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: contentAreaWidth,
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.PADDING_30,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ..._buildMobileItems(
                            Data.LeadingBankingPartnerItemsData,
                          ),
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: Sizes.PADDING_40,
                            ),
                            child: Column(
                              children: [
                                // Text(
                                //   StringConst.TITLE_STATS,
                                //   style: GoogleFonts.poppins(
                                //     color: AppColors.white,
                                //     fontSize: 40,
                                //   ),
                                // ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Spacer(),
                                    ..._buildItems(
                                      Data.LeadingBankingPartnerItemsData,
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
          SizedBoxH50(),
        ],
      ),
    );
  }

  List<Widget> _buildItems(
    List<LeadingBankingPartnerData> data, {
    bool isHorizontal = false,
  }) {
    List<Widget> items = [];
    for (int index = 0; index < data.length; index++) {
      items.add(
        LeadingBankingPartnerItem(
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

  List<Widget> _buildMobileItems(
    List<LeadingBankingPartnerData> data, {
    bool isHorizontal = false,
  }) {
    List<Widget> items = [];
    for (int index = 0; index < data.length; index++) {
      items.add(
        MobileLeadingBankingPartnerItem(
          title: data[index].value!,
          subnum: data[index].values!,
          subtitle: data[index].subtitle,
          controller: _controller,
        ),
      );
      if (index < data.length - 1) {
        if (isHorizontal) {
          items.add(SizedBoxH0());
        } else {
          items.add(SizedBoxH0());
        }
      }
    }
    return items;
  }
}
