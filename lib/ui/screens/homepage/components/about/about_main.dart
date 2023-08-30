import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/about/about_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/header_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/our_team_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/side_menu.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/our_mission/mission_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AboutMain extends StatefulWidget {
  const AboutMain({Key? key}) : super(key: key);

  @override
  State<AboutMain> createState() => _AboutMainState();
}

class _AboutMainState extends State<AboutMain> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      key: _scaffoldKey,
      drawer: ResponsiveBuilder(
        refinedBreakpoints: RefinedBreakpoints(),
        builder: (context, sizingInformation) {
          double screenWidth = sizingInformation.screenSize.width;
          if (screenWidth < RefinedBreakpoints().desktopSmall) {
            return SideMenu();
          } else {
            return Container();
          }
        },
      ),
      body: Column(
        children: [
          ResponsiveBuilder(
            refinedBreakpoints: RefinedBreakpoints(),
            builder: (context, sizingInformation) {
              double screenWidth = sizingInformation.screenSize.width;
              if (screenWidth < RefinedBreakpoints().desktopSmall) {
                return NavSectionMobile(
                  scaffoldKey: _scaffoldKey,
                );
              } else {
                return HeaderSection();
              }
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AboutSection(),
                  SizedBoxH80(),
                  MissionSection(),
                  SizedBoxH80(),
                  OurTeamSection(),
                  SizedBoxH100(),
                  FooterSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
