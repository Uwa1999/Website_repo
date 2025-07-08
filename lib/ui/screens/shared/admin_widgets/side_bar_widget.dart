import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;

import 'package:shared_preferences/shared_preferences.dart';


class SideNavigation extends StatefulWidget {
  final Function(String) onItemSelected;
  final String selectedItem;
  final VoidCallback onToggleSidebar;
  // final VoidCallback onLogout;

  const SideNavigation({
    super.key,
    required this.onItemSelected,
    required this.selectedItem,
    required this.onToggleSidebar,
    // required this.onLogout,
  });

  @override
  State<SideNavigation> createState() => _SideNavigationState();
}

class _SideNavigationState extends State<SideNavigation> {
  Future<void> _clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('role');
    await prefs.remove('staffID');
    await prefs.remove('selectedIndex');
  }

  // Future<void> _performLogout() async {
  //   // Show confirmation dialog
  //   bool? shouldLogout = await showDialog<bool>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Confirm Logout'),
  //         content: const Text('Are you sure you want to logout?'),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context, false),
  //             child: const Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () => Navigator.pop(context, true),
  //             child: const Text('Logout'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  //
  //   if (shouldLogout != true) return;
  //
  //   // Show loading dialog
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return const AlertDialog(
  //         content: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             CircularProgressIndicator(),
  //             SizedBox(width: 20),
  //             Text('Logging out...'),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  //
  //   try {
  //     // Clear user data
  //     await _clearUserData();
  //
  //     await Future.delayed(const Duration(milliseconds: 1000));
  //
  //     // For web - clear session storage
  //     if (kIsWeb) {
  //       html.window.sessionStorage.clear();
  //     }
  //
  //     // Close loading dialog
  //     if (mounted) Navigator.of(context).pop();
  //
  //     // Navigate to login screen
  //     if (mounted) {
  //       Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(builder: (context) => const LoginScreen()),
  //             (Route<dynamic> route) => false,
  //       );
  //     }
  //   } catch (e) {
  //     // Close loading dialog if there's an error
  //     if (mounted) Navigator.of(context).pop();
  //
  //     // Show error message
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Logout failed. Please try again.')),
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEFEFEF),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menu Icon (top-left)
            Container(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: widget.onToggleSidebar,
              ),
            ),

            // Logo
            Center(
              child: SizedBox(
                height: 100,
                child: Image.asset(
                  'assets/images/fdsap.png',
                  width: 100,
                  height: 100,
                ),
              ),
            ),

            // Dashboard item
            GestureDetector(
              onTap: () => widget.onItemSelected('dashboard'),
              child: Container(
                color: widget.selectedItem == 'dashboard'
                    ? const Color(0xFF630606)
                    : Colors.transparent,
                child: ListTile(
                  leading: Icon(Icons.dashboard,
                      color: widget.selectedItem == 'dashboard'
                          ? Colors.white
                          : Colors.black),
                  title: Text('Dashboard',
                      style: TextStyle(
                          color: widget.selectedItem == 'dashboard'
                              ? Colors.white
                              : Colors.black)),
                ),
              ),
            ),

            // Add Insights item
            GestureDetector(
              onTap: () => widget.onItemSelected('insights'),

              child: Container(
                color: widget.selectedItem == 'insights'
                    ? const Color(0xFF630606)
                    : Colors.transparent,
                child: ListTile(
                  leading: Icon(Icons.article_outlined,
                      color: widget.selectedItem == 'insights'
                          ? Colors.white
                          : Colors.black),
                  title: Text('Add Insights',
                      style: TextStyle(
                          color: widget.selectedItem == 'insights'
                              ? Colors.white
                              : Colors.black)),
                ),
              ),
            ),

            // GestureDetector(
            //   onTap: () => widget.onItemSelected('products & services'),
            //   child: Container(
            //     color: widget.selectedItem == 'products & services'
            //         ? const Color(0xFF630606)
            //         : Colors.transparent,
            //     child: ListTile(
            //       leading: Icon(Icons.computer,
            //           color: widget.selectedItem == 'products & services'
            //               ? Colors.white
            //               : Colors.black),
            //       title: Text('Add Products & Services',
            //           style: TextStyle(
            //               color: widget.selectedItem == 'products & services'
            //                   ? Colors.white
            //                   : Colors.black)),
            //     ),
            //   ),
            // ),

            // Spacer to push logout button to bottom
            // const Spacer(),
            //
            // // Logout button
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 20.0),
            //   child: ListTile(
            //     leading: const Icon(Icons.logout, color: Colors.black),
            //     title: const Text('Logout', style: TextStyle(color: Colors.black)),
            //     onTap: _performLogout,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}