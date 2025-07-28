import 'dart:core';

import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/homepage_screen.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/functions.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/shadows.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/buttons/contact_us_button.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/buttons/social_button.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/empty.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nav_item.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_vertical_divider.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../clients/clients_main.dart';
import '../../../shared/widgets/NavItemData_global.dart';
import '../../../shared/widgets/pop_container.dart';
import '../our_location_section.dart';

const double logoSpaceLeftLg = 40.0;
const double logoSpaceLeftSm = 20.0;
const double logoSpaceRightLg = 70.0;
const double logoSpaceRightSm = 35.0;
const double contactButtonSpaceLeftLg = 60.0;
const double contactButtonSpaceLeftSm = 30.0;
const double contactButtonSpaceRightLg = 40.0;
const double contactButtonSpaceRightSm = 20.0;
const double contactBtnWidthLg = 150.0;
const double contactBtnWidthSm = 120.0;
const int menuSpacerRightLg = 5;
const int menuSpacerRightMd = 4;
const int menuSpacerRightSm = 3;

class NavSectionWeb extends StatefulWidget {
  final List<NavItemData> navItems;
  final Function(GlobalKey) onNavItemSelected;

  NavSectionWeb({required this.navItems, required this.onNavItemSelected});

  @override
  _NavSectionWebState createState() => _NavSectionWebState();
}

class _NavSectionWebState extends State<NavSectionWeb> {
  @override
  Widget build(BuildContext context) {
    double logoSpaceLeft =
        responsiveSize(context, logoSpaceLeftSm, logoSpaceLeftLg);
    double logoSpaceRight =
        responsiveSize(context, logoSpaceRightSm, logoSpaceRightLg);
    double contactBtnSpaceLeft = responsiveSize(
        context, contactButtonSpaceLeftSm, contactButtonSpaceLeftLg);
    double contactBtnSpaceRight = responsiveSize(
        context, contactButtonSpaceRightSm, contactButtonSpaceRightLg);
    double contactBtnWidth =
        responsiveSize(context, contactBtnWidthSm, contactBtnWidthLg);
    int menuSpacerRight = responsiveSizeInt(
        context, menuSpacerRightSm, menuSpacerRightLg,
        md: menuSpacerRightMd);

    return Container(
      height: Sizes.HEIGHT_100,
      decoration: BoxDecoration(color: Colors.transparent),
      child: IntrinsicHeight(
        child: Row(
          children: [
            SizedBox(width: logoSpaceLeft),
            InkWell(
              onTap: () {
                updateSelectedNavItem(StringConst.HOME);
                setState(() {}); // <--- Force UI update when navigating home
                Navigator.of(context).pushNamed(HomepageScreen.route);
              },
              child: Image.asset(
                ImagePath.FDSAP_LOGO_MAROON,
                height: Sizes.HEIGHT_40,
              ),
            ),
            SizedBox(width: logoSpaceRight),
            NimbusVerticalDivider(),
            Spacer(flex: 1),
            ..._buildNavItems(widget.navItems),
            Spacer(flex: menuSpacerRight),
            ResponsiveBuilder(
              refinedBreakpoints: RefinedBreakpoints(),
              builder: (context, sizingInformation) {
                double screenWidth = sizingInformation.screenSize.width;
                if (screenWidth < (RefinedBreakpoints().desktopSmall + 450)) {
                  return EmptyContainer();
                } else {
                  return Row(children: [SizedBoxW20()]);
                }
              },
            ),
            NimbusVerticalDivider(),
            SizedBox(width: contactBtnSpaceLeft),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.maroon05,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: NavItem(
                  titleColor: AppColors.white,
                  title: widget.navItems.last.name,
                  isSelected: widget.navItems.last.isSelected,
                  onTap: () => _onTapNavItem(widget.navItems.last),
                ),
              ),
            ),
            SizedBox(width: contactBtnSpaceRight),
          ],
        ),
      ),
    );
  }

  void _onTapNavItem(NavItemData item) {
    setState(() {
      for (var navItem in widget.navItems) {
        navItem.isSelected = navItem.name == item.name;
      }
    });

    if (item.destinationBuilder != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: item.destinationBuilder!),
      ).then((_) {
        // Reset to HOME when returning
        updateSelectedNavItem(StringConst.HOME);
        setState(() {});
      });
    } else if (item.key != null) {
      widget.onNavItemSelected(item.key!);
    }
  }

  List<Widget> _buildNavItems(List<NavItemData> navItems) {
    List<Widget> items = [];
    for (int i = 0; i < navItems.length - 1; i++) {
      items.add(
        NavItem(
          title: navItems[i].name,
          isSelected: navItems[i].isSelected,
          onTap: () => _onTapNavItem(navItems[i]),
        ),
      );
      items.add(Spacer());
    }
    return items;
  }
}
