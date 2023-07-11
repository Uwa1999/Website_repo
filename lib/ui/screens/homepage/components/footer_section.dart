import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/functions.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/buttons/social_button.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (!isMobile(context)) == (!isTab(context)) ? DesktopFooter() : MobileFooter();
  }
}

class DesktopFooter extends StatelessWidget {
  const DesktopFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(color: AppColors.maroon03),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImagePath.FDSAP_WHITE_LOGO,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: StringConst.ABOUT_FDS_ASYA_FOOTER0,
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(text: TextSpan(text: StringConst.ABOUT_FDS_ASYA_FOOTER1, style: GoogleFonts.poppins(fontSize: 16, color: Colors.white, fontWeight: FontWeight.normal))),
                    SizedBoxH10(),
                    RichText(text: TextSpan(text: StringConst.ABOUT_FDS_ASYA_FOOTER2, style: GoogleFonts.poppins(fontSize: 16, color: Colors.white, fontWeight: FontWeight.normal))),
                    SizedBoxH10(),
                    RichText(text: TextSpan(text: StringConst.ABOUT_FDS_ASYA_FOOTER2, style: GoogleFonts.poppins(fontSize: 16, color: Colors.white, fontWeight: FontWeight.normal))),
                    SizedBoxH20(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "© FDSAP 2023",
                      style: TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 0.5),
                    ),
                    //   ..._buildSocialIcons(Data.socialfooterData),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildSocialIcons(List<FooterSocialButtonData> socialItems) {
    List<Widget> items = [];
    for (int index = 0; index < socialItems.length; index++) {
      items.add(
        FooterSocialButton(
          iconSize: 18,
          tag: socialItems[index].tag,
          iconData: socialItems[index].iconData,
          //  iconColor: socialItems[index].iconColor,
          onPressed: () => openUrlLink(socialItems[index].url),
        ),
      );
      items.add(SizedBoxW16());
    }
    return items;
  }
}

class MobileFooter extends StatelessWidget {
  const MobileFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(color: AppColors.maroon02),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: Sizes.PADDING_10,
                  ),
                  child: Image.asset(
                    ImagePath.FDSAP_WHITE_LOGO,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: StringConst.ABOUT_FDS_ASYA_FOOTER0,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RichText(text: TextSpan(text: StringConst.ABOUT_FDS_ASYA_FOOTER1, style: GoogleFonts.poppins(fontSize: 8, color: Colors.white, fontWeight: FontWeight.normal))),
                SizedBoxH10(),
                RichText(text: TextSpan(text: StringConst.ABOUT_FDS_ASYA_FOOTER2, style: GoogleFonts.poppins(fontSize: 8, color: Colors.white, fontWeight: FontWeight.normal))),
                SizedBoxH10(),
                RichText(text: TextSpan(text: StringConst.ABOUT_FDS_ASYA_FOOTER2, style: GoogleFonts.poppins(fontSize: 8, color: Colors.white, fontWeight: FontWeight.normal))),
                SizedBoxH20(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "© FDSAP 2023",
                  style: TextStyle(color: Colors.white, fontSize: 8, letterSpacing: 0.5),
                ),
                // ..._buildSocialIcons(Data.socialfooterData),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({Key? key, required this.title, required this.tapEvent}) : super(key: key);

  final String title;
  final GestureTapCallback tapEvent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapEvent,
      hoverColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          title,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
