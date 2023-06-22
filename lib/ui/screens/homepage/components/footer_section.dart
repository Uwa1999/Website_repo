import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/functions.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/data.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/buttons/social_button.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/content_area.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
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
        ContentArea(
          child: NimbusInfoSection2(
            title1: StringConst.OUR_LOCATION,
            hasTitle2: false,
          ),
        ),
        SizedBoxH5(),
        Padding(
          padding: EdgeInsets.only(
            left: Sizes.PADDING_80,
            right: Sizes.PADDING_80,
          ),
          child: ContentArea(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            backgroundColor: AppColors.maroon03,
            borderRadius: const BorderRadius.all(
              Radius.circular(Sizes.RADIUS_8),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(Sizes.RADIUS_8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  ImagePath.BOX_COVER_MAP,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SizedBoxH20(),
        Container(
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
                    RichText(text: TextSpan(text: StringConst.ABOUT_FDS_ASYA_FOOTER1, style: GoogleFonts.poppins(fontSize: 15, color: Colors.white, fontWeight: FontWeight.normal))),
                    SizedBoxH10(),
                    RichText(text: TextSpan(text: StringConst.ABOUT_FDS_ASYA_FOOTER2, style: GoogleFonts.poppins(fontSize: 15, color: Colors.white, fontWeight: FontWeight.normal))),
                    SizedBoxH10(),
                    RichText(text: TextSpan(text: StringConst.ABOUT_FDS_ASYA_FOOTER2, style: GoogleFonts.poppins(fontSize: 15, color: Colors.white, fontWeight: FontWeight.normal))),
                    SizedBoxH20(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "© FDSAP 2023",
                      style: TextStyle(color: Colors.white, fontSize: 15, letterSpacing: 0.5),
                    ),
                    ..._buildSocialIcons(Data.socialfooterData),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "FDS ASYA PHILIPPINES INC.",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "FDS is a trustworthy and reliable",
                      style: TextStyle(color: Colors.white, fontSize: 8, letterSpacing: 0.5),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "shared services provider of world-",
                      style: TextStyle(color: Colors.white, fontSize: 8, letterSpacing: 0.5),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "class banking applications for banks",
                      style: TextStyle(color: Colors.white, fontSize: 8, letterSpacing: 0.5),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "and financial services",
                      style: TextStyle(color: Colors.white, fontSize: 8, letterSpacing: 0.5),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Core Banking Solutions",
                      style: TextStyle(color: Colors.white, fontSize: 8, letterSpacing: 0.5),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Cyber Security & Fraud",
                      style: TextStyle(color: Colors.white, fontSize: 8, letterSpacing: 0.5),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Digipay",
                      style: TextStyle(color: Colors.white, fontSize: 8, letterSpacing: 0.5),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Business Analytics & AI",
                      style: TextStyle(color: Colors.white, fontSize: 8, letterSpacing: 0.5),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Account",
                      style: TextStyle(color: Colors.white, fontSize: 8, letterSpacing: 0.5),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Ways to Watch",
                      style: TextStyle(color: Colors.white, fontSize: 8, letterSpacing: 0.5),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Corporate Information",
                      style: TextStyle(color: Colors.white, fontSize: 8, letterSpacing: 0.5),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "SolMusic Originals",
                      style: TextStyle(color: Colors.white, fontSize: 8, letterSpacing: 0.5),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Media Centre",
                      style: TextStyle(color: Colors.white, fontSize: 8, letterSpacing: 0.5),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Terms of Use",
                      style: TextStyle(color: Colors.white, fontSize: 8, letterSpacing: 0.5),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Contact Us",
                      style: TextStyle(color: Colors.white, fontSize: 8, letterSpacing: 0.5),
                    ),
                  ],
                )
              ],
            ),
          ),
          // Center(
          //   child: Text(
          //     StringConst.RIGHTS_RESERVED + " ",
          //     style: TextStyle(color: Colors.white, fontSize: 8, letterSpacing: 0.5),
          //   ),
          // )
        ],
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
            color: AppColors.kPrimaryColor,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
