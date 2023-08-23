import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/homepage_screen.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/functions.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
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

  NavSectionWeb({required this.navItems});

  @override
  _NavSectionWebState createState() => _NavSectionWebState();
}

class _NavSectionWebState extends State<NavSectionWeb> {
  @override
  Widget build(BuildContext context) {
    double logoSpaceLeft = responsiveSize(context, logoSpaceLeftSm, logoSpaceLeftLg);
    double logoSpaceRight = responsiveSize(context, logoSpaceRightSm, logoSpaceRightLg);
    double contactBtnSpaceLeft = responsiveSize(
      context,
      contactButtonSpaceLeftSm,
      contactButtonSpaceLeftLg,
    );
    double contactBtnSpaceRight = responsiveSize(
      context,
      contactButtonSpaceRightSm,
      contactButtonSpaceRightLg,
    );
    double contactBtnWidth = responsiveSize(
      context,
      contactBtnWidthSm,
      contactBtnWidthLg,
    );
    int menuSpacerRight = responsiveSizeInt(
      context,
      menuSpacerRightSm,
      menuSpacerRightLg,
      md: menuSpacerRightMd,
    );

    return Container(
      height: Sizes.HEIGHT_100,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          Shadows.elevationShadow,
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            SizedBox(width: logoSpaceLeft),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomepageScreen()));
                print("-----HOMEPAGE SCREEN----");
              },
              child: Image.asset(
                ImagePath.LOGO_FDSAP,
                height: Sizes.HEIGHT_100,
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
                  return Row(
                    children: [
                      //   ..._buildSocialIcons(Data.socialData),
                      SizedBoxW20(),
                    ],
                  );
                }
              },
            ),
            NimbusVerticalDivider(),
            SizedBox(width: contactBtnSpaceLeft),
            ContactUsButton(
              buttonTitle: StringConst.CONTACT_US,
              width: contactBtnWidth,
              opensUrl: true,
              url: StringConst.EMAIL_URL,
            ),
            SizedBox(width: contactBtnSpaceRight),
          ],
        ),
      ),
    );
  }

  _onTapNavItem({
    required GlobalKey context,
    required String navItemName,
  }) {
    for (int index = 0; index < widget.navItems.length; index++) {
      if (navItemName == widget.navItems[index].name) {
        scrollToSection(context.currentContext!);
        setState(() {
          widget.navItems[index].isSelected = true;
        });
      } else {
        widget.navItems[index].isSelected = false;
      }
    }
  }

  List<Widget> _buildNavItems(List<NavItemData> navItems) {
    List<Widget> items = [];
    for (int index = 0; index < navItems.length; index++) {
      items.add(
        NavItem(
          title: navItems[index].name,
          isSelected: navItems[index].isSelected,
          onTap: () => _onTapNavItem(
            context: navItems[index].key,
            navItemName: navItems[index].name,
          ),
        ),
      );
      items.add(Spacer());
    }
    return items;
  }

  List<Widget> _buildSocialIcons(List<SocialButtonData> socialItems) {
    List<Widget> items = [];
    for (int index = 0; index < socialItems.length; index++) {
      items.add(
        SocialButton(
          tag: socialItems[index].tag,
          iconData: socialItems[index].iconData,
          onPressed: () => openUrlLink(socialItems[index].url),
        ),
      );
      items.add(SizedBoxW16());
    }
    return items;
  }
}
