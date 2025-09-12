
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/aboutv2/aboutv2.dart';
import 'package:flutter/material.dart';

import '../../homepage/components/insightsv2/insightscreen.dart';
import '../../insights/articles/article_main.dart';
import '../../insights/articlesv2/articlev2main.dart';
import '../../insights/insights_main.dart';
import '../../insights/insights_section.dart';
import '../values/keys.dart';
import '../values/strings.dart';
import '../widgets/nav_item.dart';


List<NavItemData> navItems = [
  NavItemData(
    name: StringConst.HOME,
    key: homeKey,
    isSelected: true,
  ),
  NavItemData(
    name: StringConst.SERVICES,
    key: servicesKey,
  ),
  NavItemData(
    name: StringConst.CLIENT,
    key: clientKey,
  ),
  NavItemData(
    name: StringConst.INSIGHTS,
    destinationBuilder: (context) => ArticleDescMain(),

  ),
  NavItemData(
    name: StringConst.ABOUT_US,
    destinationBuilder: (context) => AboutUsSectionv2(navItems: navItems),
  ),
  NavItemData(
    name: StringConst.CONTACT_US,
    key: contactKey,
  ),
];

/// Utility method to scroll to a section using its GlobalKey
/// GLOBALLY ACCESSED BY THE HEADER SECTION
void scrollToSection(GlobalKey key, {int attempts = 10}) {
  final context = key.currentContext;
  if (context != null) {
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
    ScrollTarget.targetKey = null;
  } else if (attempts > 0) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      scrollToSection(key, attempts: attempts - 2);
    });
  }
}

///FINDS THE TARGET SCROLLING LOCATION OF THE NAV ITEM
class ScrollTarget {
  static GlobalKey? targetKey;
}

/// Update nav selection state globally
void updateSelectedNavItem(String selectedName) {
  for (var item in navItems) {
    item.isSelected = item.name == selectedName;
  }
}