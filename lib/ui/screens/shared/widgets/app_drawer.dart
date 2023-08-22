import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/functions.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:flutter/material.dart';

import 'nav_item.dart';

const kSpacing20 = Sizes.SIZE_20;

class AppDrawer extends StatefulWidget {
  final Color color;
  final double? width;
  final List<NavItemData> menuList;
  final GestureTapCallback? onClose;

  AppDrawer({
    this.color = AppColors.white,
    this.width,
    required this.menuList,
    this.onClose,
  });

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    double defaultWidthOfDrawer = responsiveSize(
      context,
      assignWidth(context, 0.85),
      assignWidth(context, 0.60),
      md: assignWidth(context, 0.60),
    );
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: Container(
          color: widget.color,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.PADDING_24,
            vertical: Sizes.PADDING_24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
                child: Center(
                  child: Image.asset(
                    ImagePath.LOGO_LIGHT,
                    height: Sizes.HEIGHT_150,
                  ),
                ),
              ),
              Center(
                child: Text(
                  StringConst.FDSAP_VERSION,
                  style: TextStyle(fontSize: 10),
                ),
              ),
              Divider(
                color: AppColors.grey350,
              ),
              Spacer(flex: 2),
              ..._buildMenuList(
                context: context,
                menuList: widget.menuList,
              ),
              Spacer(flex: 6),
              // _buildFooterText(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildMenuList({
    required BuildContext context,
    required List<NavItemData> menuList,
  }) {
    TextTheme textTheme = Theme.of(context).textTheme;
    List<Widget> menuItems = [];
    for (var i = 0; i < menuList.length; i++) {
      menuItems.add(
        NavItem(
          onTap: () => _onTapNavItem(
            context: menuList[i].key,
            navItemName: menuList[i].name,
          ),
          title: menuList[i].name,
          isMobile: true,
          isSelected: menuList[i].isSelected,
          titleStyle: textTheme.bodyText1?.copyWith(
            color: menuList[i].isSelected ? AppColors.maroon450 : AppColors.black,
            fontSize: Sizes.TEXT_SIZE_16,
            fontWeight: menuList[i].isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      );
      menuItems.add(Spacer());
    }
    return menuItems;
  }

  _onTapNavItem({
    required GlobalKey context,
    required String navItemName,
  }) {
    for (int index = 0; index < widget.menuList.length; index++) {
      if (navItemName == widget.menuList[index].name) {
        scrollToSection(context.currentContext!);
        setState(() {
          widget.menuList[index].isSelected = true;
        });
        _closeDrawer();
      } else {
        widget.menuList[index].isSelected = false;
      }
    }
  }

  _closeDrawer() {
    Scaffold.of(context).openEndDrawer();
  }

  // Widget _buildFooterText() {
  //   TextTheme textTheme = Theme.of(context).textTheme;
  //   TextStyle? footerTextStyle = textTheme.caption?.copyWith(
  //     color: AppColors.primaryText2,
  //     fontWeight: FontWeight.bold,
  //   );
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       // Center(
  //       //   child: SelectableText.rich(
  //       //     TextSpan(
  //       //       text: StringConst.RIGHTS_RESERVED + " ",
  //       //       style: footerTextStyle,
  //       //       children: [
  //       //         TextSpan(text: StringConst.DESIGNED_BY + " "),
  //       //         TextSpan(
  //       //           text: StringConst.WEB_GENIUS_LAB,
  //       //           style: footerTextStyle?.copyWith(
  //       //             decoration: TextDecoration.underline,
  //       //             fontWeight: FontWeight.w900,
  //       //             color: AppColors.white,
  //       //           ),
  //       //         ),
  //       //       ],
  //       //     ),
  //       //     textAlign: TextAlign.center,
  //       //   ),
  //       // ),
  //       // Row(
  //       //   mainAxisAlignment: MainAxisAlignment.center,
  //       //   children: [
  //       //     RichText(
  //       //       text: TextSpan(
  //       //         text: StringConst.BUILT_BY + " ",
  //       //         style: footerTextStyle,
  //       //         children: [],
  //       //       ),
  //       //     ),
  //       //   ],
  //       // ),
  //     ],
  //   );
  // }
}
