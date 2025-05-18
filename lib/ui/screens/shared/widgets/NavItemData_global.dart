import 'package:flutter/material.dart';

import '../values/strings.dart';
import '../widgets/nav_item.dart';

///GLOBAL DECLARATION OF NAVIGATION ITEMS
List<NavItemData> navItems = [
  NavItemData(name: StringConst.HOME, key: GlobalKey(), isSelected: true),
  NavItemData(name: StringConst.SERVICES, key: GlobalKey()),
  NavItemData(name: StringConst.ABOUT_US, key: GlobalKey()),
  NavItemData(name: StringConst.CLIENT, key: GlobalKey()),
  NavItemData(name: StringConst.INSIGHTS, key: GlobalKey()),


  ///LAST ITEM NOT INCLUDED IN NAV ITEMS
  NavItemData(name: StringConst.CONTACT_US, key: GlobalKey()),
];

/// Utility method to scroll to a section using its GlobalKey
/// GLOBALLY ACCESSED BY THE HEADER SECTION
void scrollToSection(GlobalKey key, {int attempts = 10}) {
  final context = key.currentContext;
  if (context != null) {
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    ScrollTarget.targetKey = null;
  } else if (attempts > 0) {
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollToSection(key, attempts: attempts - 1);
    });
  }
}

///FINDS THE TARGET SCROLLING LOCATION OF THE NAV ITEM
class ScrollTarget {
  static GlobalKey? targetKey;
}