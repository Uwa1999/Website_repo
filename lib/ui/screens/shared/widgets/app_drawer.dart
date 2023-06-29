import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/functions.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'nav_item.dart';

const kSpacing20 = Sizes.SIZE_20;

class AppDrawer extends StatefulWidget {
  final Color color;
  final double? width;
  final List<NavItemData> menuList;
  final GestureTapCallback? onClose;

  AppDrawer({
    this.color = AppColors.black200,
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
      width: widget.width ?? defaultWidthOfDrawer,
      child: Drawer(
        child: Container(
          color: widget.color,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.PADDING_24,
            vertical: Sizes.PADDING_24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Image.asset(
                      ImagePath.LOGO_LIGHT,
                      height: Sizes.HEIGHT_52,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: widget.onClose ?? () => _closeDrawer(),
                    child: Icon(
                      Icons.close,
                      size: Sizes.ICON_SIZE_30,
                      color: AppColors.white,
                    ),
                  ),
                ],
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
          titleStyle: textTheme.bodyLarge?.copyWith(
            color: menuList[i].isSelected ? AppColors.maroon450 : AppColors.white,
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
    context.router.pop();
  }

  // Widget _buildFooterText() {
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
