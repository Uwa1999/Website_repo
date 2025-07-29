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

import '../../shared/widgets/animation.dart';


// class LeadingBankingPartnerSection extends StatefulWidget {
//   LeadingBankingPartnerSection({Key? key});
//   @override
//   _LeadingBankingPartnerSectionState createState() => _LeadingBankingPartnerSectionState();
// }
//
// class _LeadingBankingPartnerSectionState extends State<LeadingBankingPartnerSection> {
//   @override
//   Widget build(BuildContext context) {
//     return (!isMobile(context)) == (!isTab(context)) ? DesktopLeadingPartners() : MobileLeadingPartners();
//   }
// }

class LeadingBankingPartnerSection extends StatefulWidget {
  @override
  _LeadingBankingPartnerSectionState createState() =>
      _LeadingBankingPartnerSectionState();
}

class _LeadingBankingPartnerSectionState
    extends State<LeadingBankingPartnerSection> with SingleTickerProviderStateMixin {
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
    return VisibilityDetector(
      key: const Key('statistics-section'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.3) {
          _controller.forward();
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isMobile
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Because figures don’t lie',
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 30 : 46,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Because figures don’t lie',
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 30 : 46,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                isMobile
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _buildItems(
                    Data.LeadingBankingPartnerItemsData,
                    isHorizontal: false,
                  ),
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _buildItems(
                    Data.LeadingBankingPartnerItemsData,

                    isHorizontal: true,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildItems(List<LeadingBankingPartnerData> data,
      {bool isHorizontal = false}) {
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
        items.add(
          isHorizontal ? const SizedBox(width: 60) : const SizedBox(height: 40),
        );
      }
    }
    return items;
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
              color: AppColors.pink300,
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

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
      key: const Key('statistics-section'),
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
                borderRadius: BorderRadius.all(Radius.circular(Sizes.RADIUS_10)),
              ),
              color: Colors.white,
              child: ResponsiveBuilder(
                refinedBreakpoints: RefinedBreakpoints(),
                builder: (context, sizingInformation) {
                  double screenWidth = sizingInformation.screenSize.width;
                  if (screenWidth < (RefinedBreakpoints().tabletSmall)) {
                    // Mobile vertical layout
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(Sizes.RADIUS_10)),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: Sizes.PADDING_30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildMobileItems(Data.LeadingBankingPartnerItemsData),
                      ),
                    );
                  } else {
                    // Desktop / tablet horizontal layout
                    return ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Sizes.RADIUS_10),
                        bottomRight: Radius.circular(Sizes.RADIUS_10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: Sizes.PADDING_40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ..._buildItems(Data.LeadingBankingPartnerItemsData, isHorizontal: true),
                          ],
                        ),
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

  List<Widget> _buildItems(List<LeadingBankingPartnerData> data, {bool isHorizontal = false}) {
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

      if (index < data.length - 1 && isHorizontal) {
        items.add(SizedBox(width: 40)); // spacing between items
      }
    }
    return items;
  }

  List<Widget> _buildMobileItems(List<LeadingBankingPartnerData> data) {
    List<Widget> items = [];
    for (int index = 0; index < data.length; index++) {
      items.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: MobileLeadingBankingPartnerItem(
            title: data[index].value!.toString(),
            subnum: data[index].values!,
            subtitle: data[index].subtitle,
            controller: _controller,
          ),
        ),
      );
    }
    return items;
  }
}
class MobileLeadingBankingPartnerItem extends StatelessWidget {
  final String title;
  final String subnum;
  final String subtitle;
  final AnimationController controller;

  const MobileLeadingBankingPartnerItem({
    Key? key,
    required this.title,
    required this.subnum,
    required this.subtitle,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation =
    CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    // Responsive sizing (larger overall)
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    // double bigFontSize = screenWidth < 400 ? 100 : 92; // Previously 48 / 64
    // double subtitleFontSize = screenWidth < 400 ? 18 : 22; // Previously 16 / 20

    double bigFontSize = screenWidth < 400 ? 100 : 72; // Edited font size
    double subtitleFontSize = screenWidth < 400 ? 14 : 18; // Edited font size

    return FadeTransition(
      opacity: animation,
      child: Column(
        children: [
          Text(
            '$title$subnum',
            style: TextStyle(
              fontSize: bigFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
              shadows: [
                Shadow(
                  blurRadius: 30,
                  color: Colors.redAccent.withOpacity(0.8),
                  offset: Offset(0, 0),
                ),
                Shadow(
                  blurRadius: 50,
                  color: Colors.red.withOpacity(0.5),
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8), // Slightly more spacing
          Text(
            subtitle,
            style: TextStyle(
              fontSize: subtitleFontSize,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}