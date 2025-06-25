
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/aboutv2/aboutv2.dart';
import 'package:flutter/material.dart';

import '../../homepage/components/insightsv2/insightscreen.dart';
import '../../insights/articles/article_main.dart';
import '../../insights/articlesv2/articlev2main.dart';
import '../../insights/insights_main.dart';
import '../../insights/insights_section.dart';
import '../values/strings.dart';
import '../widgets/nav_item.dart';

///GLOBAL DECLARATION OF NAVIGATION ITEMS
///old changed date june 09, 2025
// List<NavItemData> navItems = [
//   ///0
//   NavItemData(name: StringConst.HOME,
//       key: GlobalKey(),
//       isSelected: true),
// ///1
//   NavItemData(name: StringConst.SERVICES,
//       key: GlobalKey()
//   ),
//   ///2
//   NavItemData(name: StringConst.CLIENT,
//       key: GlobalKey()
//   ),
// ///3
//   NavItemData(name: StringConst.INSIGHTS,
//       key: GlobalKey(),
//       destinationBuilder: (context) => ArticleDescMain()
//   ),
// ///4
//   NavItemData(name: StringConst.ABOUT_US,
//       // key: GlobalKey(),
//       destinationBuilder: (context) => AboutUsSectionv2()
//   ),
// ///5
//   NavItemData(name: StringConst.CONTACT_US,
//       key: GlobalKey()),
// ];
List<NavItemData> navItems = [
  NavItemData(name: StringConst.HOME, key: GlobalObjectKey('home'), isSelected: true),
  NavItemData(name: StringConst.SERVICES, key: GlobalObjectKey('services')),
  NavItemData(name: StringConst.CLIENT, key: GlobalObjectKey('client')),
  NavItemData(name: StringConst.INSIGHTS, key: GlobalObjectKey('insights'), destinationBuilder: (context) => ArticleDescMain()),
  NavItemData(name: StringConst.ABOUT_US, destinationBuilder: (context) => AboutUsSectionv2()),
  NavItemData(name: StringConst.CONTACT_US, key: GlobalObjectKey('contact')),
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
