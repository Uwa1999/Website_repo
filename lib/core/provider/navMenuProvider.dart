// File: lib/providers/nav_menu_provider.dart
import 'package:flutter/material.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nav_item.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/aboutv2/aboutv2.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articlesv2/components/articleinside.dart';

class NavMenuProvider extends ChangeNotifier {
  final List<NavItemData> menuItems = [
    NavItemData(name: 'HOME', key: GlobalKey(), isSelected: true),
    NavItemData(name: 'CLIENT', key: GlobalKey()),
    NavItemData(name: 'INSIGHTS', key: GlobalKey()),
    NavItemData(name: 'ABOUT_US', key: GlobalKey()),
    NavItemData(name: 'CONTACT_US', key: GlobalKey()),
  ];
}