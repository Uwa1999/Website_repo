import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/components/product_services_navitem.dart';
import 'package:flutter/material.dart';

class ProductAndServicesSideMenu extends StatefulWidget {
  const ProductAndServicesSideMenu({Key? key}) : super(key: key);

  @override
  State<ProductAndServicesSideMenu> createState() => _ProductAndServicesSideMenuState();
}

class _ProductAndServicesSideMenuState extends State<ProductAndServicesSideMenu> {
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
                tapEvent: () {},
              ),
              const SizedBox(height: 10),
              NavItem(
                title: 'About Us',
                tapEvent: () {},
              ),
              const SizedBox(height: 10),
              NavItem(
                title: 'Contact Us',
                tapEvent: () {},
              ),
              const SizedBox(height: 10),
              NavItem(
                title: 'Help',
                tapEvent: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
