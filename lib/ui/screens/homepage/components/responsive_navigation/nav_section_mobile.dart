import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/homepage_screen.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class NavSectionMobile extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const NavSectionMobile({required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Sizes.HEIGHT_100,
      decoration: BoxDecoration(
        color: AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                FeatherIcons.menu,
                color: AppColors.black,
                size: Sizes.ICON_SIZE_26,
              ),
              onPressed: () {
                if (scaffoldKey.currentState!.isEndDrawerOpen) {
                  scaffoldKey.currentState?.openEndDrawer();
                } else {
                  scaffoldKey.currentState?.openDrawer();
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(HomepageScreen.route);
                print("-----HOMEPAGE SCREEN----");
              },
              child: Image.asset(
                ImagePath.FDSAP_LOGO_MAROON,
                height: Sizes.HEIGHT_100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
