import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/about_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/about_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/insights_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/insights_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/product_services_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_web.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/homepage_screen.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/product_and_services_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/buttons/contact_us_button.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nav_item.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_vertical_divider.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double logoSpaceLeft = responsiveSize(context, logoSpaceLeftSm, logoSpaceLeftLg);
    double logoSpaceRight = responsiveSize(context, logoSpaceRightSm, logoSpaceRightLg);
    double contactBtnSpaceLeft = responsiveSize(
      context,
      contactButtonSpaceLeftSm,
      contactButtonSpaceLeftLg,
    );
    double contactBtnSpaceRight = responsiveSize(
      context,
      contactButtonSpaceRightSm,
      contactButtonSpaceRightLg,
    );
    double contactBtnWidth = responsiveSize(
      context,
      contactBtnWidthSm,
      contactBtnWidthLg,
    );
    int menuSpacerRight = responsiveSizeInt(
      context,
      menuSpacerRightSm,
      menuSpacerRightLg,
      md: menuSpacerRightMd,
    );
    return Column(
      children: [
        Container(
          height: 97,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                AppColors.white.withOpacity(0.9),
                AppColors.white.withOpacity(0.9),
              ],
            ),
          ),
          padding: EdgeInsets.only(left: Sizes.PADDING_15),
          child: (!isMobile(context))
              ? Row(
                  children: <Widget>[
                    SizedBox(width: logoSpaceLeft),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomepageScreen()));
                        print("-----HOMEPAGE SCREEN----");
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: Sizes.PADDING_10,
                        ),
                        child: Image.asset(
                          ImagePath.LOGO_FDSAP,
                          height: Sizes.HEIGHT_100,
                        ),
                      ),
                    ),
                    SizedBox(width: logoSpaceRight),
                    NimbusVerticalDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBoxW67(),
                        NavItem(
                          title: 'Home',
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomepageScreen()));
                            print("-----HOMEPAGE SCREEN----");
                          },
                        ),
                        SizedBoxW65(),
                        NavItem(
                          title: 'About Us',
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutMain()));
                            print("-----ABOUT US SCREEN----");
                          },
                        ),
                        SizedBoxW60(),
                        NavItem(
                          title: 'Product & Services',
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductServicesMain()));
                            print("-----PRODUCT & SERVICES SCREEN----");
                          },
                        ),
                        SizedBoxW60(),
                        NavItem(
                          title: 'Insights',
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => InsightsMain()));
                            print("-----INSIGHTS SCREEN----");
                          },
                        ),
                      ],
                    ),
                    Spacer(),
                    if (!isMobile(context))
                      if (!isTab(context))
                        VerticalDivider(
                          color: Colors.white,
                        ),
                    Row(
                      children: [
                        NimbusVerticalDivider(),
                        SizedBox(width: contactBtnSpaceLeft),
                        ContactUsButton(
                          buttonTitle: StringConst.CONTACT_US,
                          width: contactBtnWidth,
                          opensUrl: true,
                          url: StringConst.EMAIL_URL,
                        ),
                        SizedBox(width: contactBtnSpaceRight),
                      ],
                    ),
                    if (isMobile(context))
                      IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Scaffold.of(context).openEndDrawer();
                          })
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomepageScreen()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: Sizes.PADDING_10,
                        ),
                        child: Image.asset(
                          ImagePath.LOGO_FDSAP,
                          height: Sizes.HEIGHT_100,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    // Text(
                    //   "FDS ASYA PHILIPPINES INC.",
                    //   style: TextStyle(
                    //     color: AppColors.black400,
                    //     letterSpacing: 0.5,
                    //     fontWeight: FontWeight.w600,
                    //     fontSize: 20,
                    //   ),
                    // ),
                    // SizedBox(width: 10),
                    if (!isMobile(context))
                      if (!isTab(context))
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBoxW67(),
                            NavItem(
                              title: 'Home',
                              onTap: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomepageScreen()));
                                print("-----HOMEPAGE SCREEN----");
                              },
                            ),
                            SizedBoxW65(),
                            NavItem(
                              title: 'About Us',
                              onTap: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AboutSection()));
                                print("-----ABOUT US SCREEN----");
                              },
                            ),
                            SizedBoxW60(),
                            NavItem(
                              title: 'Product & Services',
                              onTap: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DesktopProductServicesSection()));
                                print("-----PRODUCT & SERVICES SCREEN----");
                              },
                            ),
                            SizedBoxW60(),
                            NavItem(
                              title: 'Insights',
                              onTap: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DesktopInsightSection()));
                                print("-----INSIGHTS SCREEN----");
                              },
                            ),
                          ],
                        ),
                    if (isMobile(context))
                      IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.grey.shade50,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                      ),
                  ],
                ),
        ),
        Divider(
          color: Colors.grey,
        ),
        // SizedBoxH30(),
      ],
    );
  }
}
