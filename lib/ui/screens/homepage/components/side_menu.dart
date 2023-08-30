import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/about/about_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/homepage_screen.dart';
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

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> with SingleTickerProviderStateMixin {
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
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomepageScreen()));
                  print("-----HOMEPAGE SCREEN----");
                },
                child: Center(
                  child: Image.asset(
                    ImagePath.LOGO_LIGHT,
                    height: Sizes.HEIGHT_150,
                  ),
                ),
              ),
              Divider(
                color: AppColors.grey350,
              ),
              SizedBoxH80(),
              NavItem(
                title: 'Home',
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomepageScreen()));
                  print("-----HOMEPAGE SCREEN----");
                },
              ),
              SizedBoxH30(),
              NavItem(
                title: 'About Us',
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AboutMain()));
                  print("-----ABOUT US SCREEN----");
                },
              ),
              SizedBoxH30(),
              NavItem(
                title: 'Product & Services',
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductServicesMain()));
                  print("-----PRODUCT & SERVICES SCREEN----");
                },
              ),
              SizedBoxH30(),
              NavItem(
                title: 'Insights',
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InsightsMain()));
                  print("-----INSIGHTS SCREEN----");
                },
              ),
              SizedBoxH30(),
              NavItem(
                title: 'Contact Us',
                onTap: _launchURL,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_launchURL() async {
  print('-----FDSAP GMAIL-----');
  final Uri url = Uri.parse(StringConst.EMAIL_URL);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch');
  }
}
