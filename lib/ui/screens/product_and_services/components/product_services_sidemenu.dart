import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nav_item.dart';
import 'package:flutter/material.dart';

class HomepageSideMenu extends StatelessWidget {
  const HomepageSideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              NavItem(
                title: 'Home',
                onTap: () {},
              ),
              const SizedBox(height: 10),
              NavItem(
                title: 'About Us',
                onTap: () {},
              ),
              const SizedBox(height: 10),
              NavItem(
                title: 'Contact Us',
                onTap: () {},
              ),
              const SizedBox(height: 10),
              NavItem(
                title: 'Help',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
