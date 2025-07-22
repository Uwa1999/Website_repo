import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../values/strings.dart';
import '../widgets/NavItemData_global.dart';
import '../widgets/nav_item.dart';

import 'package:flutter/material.dart';
import '../widgets/NavItemData_global.dart';
import '../widgets/nav_item.dart';

String? _lastSelected;

/// Handles nav item taps: scrolling or navigating
void handleNavItemTap(BuildContext context, NavItemData selectedItem) {
  _lastSelected = selectedItem.name;
  updateSelectedNavItem(selectedItem.name);

  if (selectedItem.key != null && selectedItem.destinationBuilder == null) {
    scrollToSection(selectedItem.key!);
  } else if (selectedItem.destinationBuilder != null) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: selectedItem.destinationBuilder!),
    ).then((_) {
      // Restore the last selected item after navigating back
      if (_lastSelected != null) {
        updateSelectedNavItem(_lastSelected!);
      }
    });
  }
}