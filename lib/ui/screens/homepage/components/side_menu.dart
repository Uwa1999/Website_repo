import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/about/about_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/aboutv2/aboutv2.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/homepage_screen.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articlesv2/components/articleinside.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/insights_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/product_and_services_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nav_item.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../clients/clients_main.dart';
import '../../shared/widgets/app_drawer.dart';
import 'our_location_section.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> with SingleTickerProviderStateMixin {
  late final List<NavItemData> menuItems;

  @override
  void initState() {
    super.initState();
    menuItems = [
      NavItemData(name: StringConst.HOME, key: GlobalKey(), isSelected: true),
      NavItemData(name: StringConst.SERVICES, key: GlobalKey(),),
      NavItemData(name: StringConst.CLIENT, key: GlobalKey()),
      NavItemData(
        name: StringConst.INSIGHTS,
        key: GlobalKey(),
        destinationBuilder: (context) => ArticleDescInsidev2(),
      ),
      NavItemData(
        name: StringConst.ABOUT_US,
        key: GlobalKey(),
        destinationBuilder: (context) => AboutUsSectionv2(),
      ),

      NavItemData(name: StringConst.CONTACT_US, key: GlobalKey()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: Container(
          color: AppColors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.PADDING_24,
            vertical: Sizes.PADDING_24,
          ),
          child: ListView(
            children: [
              Container(
                height: 500,
                child: AppDrawer(menuList: menuItems),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_launchContactUsURL() async {
  print('-----FDSAP GMAIL-----');
  final Uri url = Uri.parse(StringConst.EMAIL_URL);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch');
  }
}
