// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/functions.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
// import 'package:flutter/material.dart';
//
// import 'NavItemData_global.dart';
// import 'nav_item.dart';
//
// const kSpacing20 = Sizes.SIZE_20;
//
// class AppDrawer extends StatefulWidget {
//   final Color color;
//   final double? width;
//   final List<NavItemData> menuList;
//   final GestureTapCallback? onClose;
//
//   AppDrawer({
//     this.color = AppColors.white,
//     this.width,
//     required this.menuList,
//     this.onClose,
//   });
//
//   @override
//   _AppDrawerState createState() => _AppDrawerState();
// }
//
// class _AppDrawerState extends State<AppDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.7,
//       child: Drawer(
//         child: Container(
//           color: widget.color,
//           padding: const EdgeInsets.symmetric(
//             horizontal: Sizes.PADDING_24,
//             vertical: Sizes.PADDING_24,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               InkWell(
//                 onTap: () {
//                   Scaffold.of(context).openEndDrawer();
//                 },
//                 child: Center(
//                   child: Image.asset(
//                     ImagePath.FDSAP_LOGO_MAROON,
//                     height: Sizes.HEIGHT_150,
//                   ),
//                 ),
//               ),
//               Center(
//                 child: Text(
//                   StringConst.FDSAP_VERSION,
//                   style: TextStyle(fontSize: 10),
//                 ),
//               ),
//               Divider(
//                 color: AppColors.grey350,
//               ),
//               Spacer(flex: 2),
//               ..._buildMenuList(
//                 context: context,
//                 menuList: widget.menuList,
//               ),
//               Spacer(flex: 6),
//               // _buildFooterText(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   List<Widget> _buildMenuList({
//     required BuildContext context,
//     required List<NavItemData> menuList,
//   }) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     List<Widget> menuItems = [];
//     for (var i = 0; i < menuList.length; i++) {
//       menuItems.add(
//         NavItem(
//           onTap: () => _onTapNavItem(
//             context: menuList[i].key!,
//             navItemName: menuList[i].name!,
//           ),
//           title: menuList[i].name!,
//           isMobile: true,
//           isSelected: menuList[i].isSelected,
//           titleStyle: textTheme.bodyLarge?.copyWith(
//             color: menuList[i].isSelected ? AppColors.maroon450 : AppColors.black,
//             fontSize: Sizes.TEXT_SIZE_16,
//             fontWeight: menuList[i].isSelected ? FontWeight.bold : FontWeight.normal,
//           ),
//         ),
//       );
//       menuItems.add(Spacer());
//     }
//     return menuItems;
//   }
//
//   _onTapNavItem({
//     required GlobalKey context,
//     required String navItemName,
//   }) {
//     for (int index = 0; index < widget.menuList.length; index++) {
//       if (navItemName == widget.menuList[index].name) {
//         // scrollToSection(context.currentContext!);
//         setState(() {
//           widget.menuList[index].isSelected = true;
//         });
//         _closeDrawer();
//       } else {
//         widget.menuList[index].isSelected = false;
//       }
//     }
//   }
//
//   _closeDrawer() {
//     Scaffold.of(context).openEndDrawer();
//   }
//
// }

import 'dart:core';

import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/functions.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:flutter/material.dart';

import '../../homepage/homepage_screen.dart';
import 'NavItemData_global.dart';
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
                    ImagePath.FDSAP_LOGO_MAROON,
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
              Divider(color: AppColors.grey350),
              Spacer(flex: 2),
              ..._buildMenuList(context),
              // ..._buildMenuList(context: context, menuList: widget.menuList),
              Spacer(flex: 6),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildMenuList(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    List<Widget> menuItems = [];

    for (var i = 0; i < widget.menuList.length; i++) {
      menuItems.add(
        NavItem(
          onTap: () => _onTapNavItem(
            context: context,
            key: widget.menuList[i].key!,
            navItemName: widget.menuList[i].name!,
          ),
          title: widget.menuList[i].name!,
          isMobile: true,
          isSelected: widget.menuList[i].isSelected,
          titleStyle: textTheme.bodyLarge?.copyWith(
            color:
            widget.menuList[i].isSelected ? AppColors.maroon450 : AppColors.black,
            fontSize: Sizes.TEXT_SIZE_16,
            fontWeight:
            widget.menuList[i].isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      );
      menuItems.add(Spacer());
    }
    return menuItems;
  }

  void _onTapNavItem({
    required BuildContext context,
    required GlobalKey key,
    required String navItemName,
  }) {
    final itemIndex = widget.menuList.indexWhere((e) => e.name == navItemName);
    if (itemIndex == -1) return;

    final item = widget.menuList[itemIndex];

    Navigator.of(context).pop();

    if (item.destinationBuilder != null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: item.destinationBuilder!),
      ).then((_) {
        updateSelectedNavItem(StringConst.HOME);
      });
    } else {
      if (ModalRoute.of(context)?.settings.name == HomepageScreen.route) {
        scrollToSection(item.key!);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          HomepageScreen.route,
              (Route<dynamic> route) => false,
          arguments: item.key,
        );
      }
    }
    setState(() {
      for (int i = 0; i < widget.menuList.length; i++) {
        widget.menuList[i].isSelected = (i == itemIndex);
      }
    });

    updateSelectedNavItem(item.name);
  }
}
