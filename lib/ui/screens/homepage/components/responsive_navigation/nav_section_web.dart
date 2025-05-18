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

   List<NavItemData> navItems = [
    NavItemData(name: StringConst.CONTACT_US, key: GlobalKey()),
  ];

  final Function(GlobalKey) onNavItemSelected;

  NavSectionWeb({required this.navItems,required this.onNavItemSelected});

  @override
  _NavSectionWebState createState() => _NavSectionWebState();
}

class _NavSectionWebState extends State<NavSectionWeb> {
  late final GlobalKey contactUsKey;
  final List<NavItemData> navItems = [
    NavItemData(name: StringConst.CONTACT_US, key: GlobalKey()),
  ];


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
      // color: Colors.transparent.withOpacity(0.2),
      decoration: BoxDecoration(
        color: Colors.transparent,

      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            SizedBox(width: logoSpaceLeft),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(HomepageScreen.route);
                print("-----HOMEPAGE SCREEN----");
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
            // Container(
            //   child: NavItem(title: 'Contact Us',), color: Colors.red,),
            // Row(
            //   children: navItems.map((item) {
            //     return NavItem(
            //       title: item.name ?? '',
            //       isSelected: item.isSelected,
            //       onTap: () {
            //         final context = item.key.currentContext;
            //         if (context != null) {
            //           Scrollable.ensureVisible(
            //             context,
            //             duration: Duration(milliseconds: 500),
            //             curve: Curves.easeInOut,
            //           );
            //         }
            //       },
            //     );
            //   }).toList(),
            // ),
            // Row(
            //   children: navItems.map((item) {
            //     return NavItem(
            //       title: item.name ?? '',
            //       isSelected: item.isSelected,
            //       onTap: () {
            //         final ctx = item.key.currentContext;
            //         if (ctx != null) {
            //           Scrollable.ensureVisible(
            //             ctx,
            //             duration: Duration(milliseconds: 500),
            //             curve: Curves.easeInOut,
            //           );
            //         }
            //       },
            //     );
            //   }).toList(),
            // ),
            Container(
width: 120,
              height: 40,
              decoration: BoxDecoration(
                  color: AppColors.maroon05,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: NavItem(
                  titleColor: AppColors.white,
                  title: widget.navItems.last.name!,
                  isSelected: widget.navItems.last.isSelected,
                  onTap: () => _onTapNavItem(
                    context: widget.navItems.last.key,
                    navItemName: widget.navItems.last.name!,
                  ),
                ),
              ),
            ),


            // Container(
            //   child: ContactUsButton(
            //     buttonTitle: StringConst.CONTACT_US,
            //     buttonColor: AppColors.maroon02,
            //     borderRadius: BorderRadius.all(Radius.circular(100)),
            //     width: contactBtnWidth,
            //    onPressed: (){
            //      Navigator.of(context).pushNamed(ContactUsPage.route);
            //    },
            //     // onPressed: ()=>_showDemoPopup(context),
            //   ),
            // ),
            SizedBox(width: contactBtnSpaceRight),
          ],
        ),
      ),
    );
  }
///old
  // _onTapNavItem({
  //   required GlobalKey context,
  //   required String navItemName,
  // }) {
  //   for (int index = 0; index < widget.navItems.length; index++) {
  //     if (navItemName == widget.navItems[index].name) {
  //       scrollToSection(context.currentContext!);
  //       setState(() {
  //         widget.navItems[index].isSelected = true;
  //       });
  //     } else {
  //       widget.navItems[index].isSelected = false;
  //     }
  //   }
  // }
///new added as of may 15, 2025
  _onTapNavItem({
    required GlobalKey context,
    required String navItemName,
  }) {
    for (int index = 0; index < widget.navItems.length; index++) {
      if (navItemName == widget.navItems[index].name) {
        widget.onNavItemSelected(context); // <-- Call scroll from parent
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
    for (int index = 0; index < navItems.length - 1; index++) {
      items.add(
        NavItem(
          title: navItems[index].name!,
          isSelected: navItems[index].isSelected,
          onTap: () => _onTapNavItem(
            context: navItems[index].key,
            navItemName: navItems[index].name!,
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
