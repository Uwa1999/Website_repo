import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/functions.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/buttons/social_button.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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
          decoration: BoxDecoration(
            // image: DecorationImage(
            //   fit: BoxFit.cover,
            //   image: AssetImage(ImagePath.EVENTS_HEADER),
            // ),
            color: AppColors.maroon03,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  //    crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImagePath.FDSAP_LOGO_WHITE,
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
                        // RichText(
                        //   textAlign: TextAlign.center,
                        //   text: TextSpan(
                        //     text: StringConst.FDS_BRANCH_ADDRESS,
                        //     style: GoogleFonts.poppins(
                        //       fontSize: 12,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: StringConst.ABOUT_FDS_ASYA_FOOTER1,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBoxH10(),
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: StringConst.ABOUT_FDS_ASYA_FOOTER2,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBoxH10(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              FontAwesomeIcons.mobileAlt,
                              size: 17,
                              color: AppColors.white,
                            ),
                            SizedBoxW12(),
                            Text(
                              StringConst.OUR_NUMBER,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: InkWell(
                            onTap: _launchLinkInURL,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  FontAwesomeIcons.linkedin,
                                  size: 17,
                                  color: AppColors.white,
                                ),
                                SizedBoxW12(),
                                Text(
                                  StringConst.LINKED_IN,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: InkWell(
                            onTap: _launchFacebookURL,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  FontAwesomeIcons.facebook,
                                  size: 17,
                                  color: AppColors.white,
                                ),
                                SizedBoxW12(),
                                Text(
                                  StringConst.FACEBOOK,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
                    //    ..._buildSocialIcons(Data.socialfooterData),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _launchFacebookURL() async {
    print('-----FDSAP FACEBOOK PAGE-----');
    final Uri url = Uri.parse(StringConst.FACEBOOK_URL);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch');
    }
  }

  _launchLinkInURL() async {
    print('-----FDSAP LINK IN PAGE-----');
    final Uri url = Uri.parse(StringConst.LINKED_IN_URL);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch');
    }
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
      decoration: BoxDecoration(color: AppColors.maroon03),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              //    crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImagePath.FDSAP_LOGO_WHITE,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: StringConst.ABOUT_FDS_ASYA_FOOTER0,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // RichText(
                    //   textAlign: TextAlign.center,
                    //   text: TextSpan(
                    //     text: StringConst.FDS_BRANCH_ADDRESS,
                    //     style: GoogleFonts.poppins(
                    //       fontSize: 12,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    text: StringConst.ABOUT_FDS_ASYA_FOOTER1,
                    style: GoogleFonts.poppins(
                      fontSize: 8,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBoxH10(),
                RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    text: StringConst.ABOUT_FDS_ASYA_FOOTER2,
                    style: GoogleFonts.poppins(
                      fontSize: 8,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBoxH10(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FontAwesomeIcons.mobileAlt,
                          size: 8,
                          color: AppColors.white,
                        ),
                        SizedBoxW12(),
                        Text(
                          StringConst.OUR_NUMBER,
                          style: GoogleFonts.poppins(
                            fontSize: 8,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: InkWell(
                        onTap: _launchLinkInURL,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              FontAwesomeIcons.linkedin,
                              size: 8,
                              color: AppColors.white,
                            ),
                            SizedBoxW12(),
                            Text(
                              StringConst.LINKED_IN,
                              style: GoogleFonts.poppins(
                                fontSize: 8,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: InkWell(
                        onTap: _launchFacebookURL,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              FontAwesomeIcons.facebook,
                              size: 8,
                              color: AppColors.white,
                            ),
                            SizedBoxW12(),
                            Text(
                              StringConst.FACEBOOK,
                              style: GoogleFonts.poppins(
                                fontSize: 8,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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

  _launchFacebookURL() async {
    print('-----FDSAP FACEBOOK PAGE-----');
    final Uri url = Uri.parse(StringConst.FACEBOOK_URL);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch');
    }
  }

  _launchLinkInURL() async {
    print('-----FDSAP LINK IN PAGE-----');
    final Uri url = Uri.parse(StringConst.LINKED_IN_URL);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch');
    }
  }

  List<Widget> _buildSocialIcons(List<FooterSocialButtonData> socialItems) {
    List<Widget> items = [];
    for (int index = 0; index < socialItems.length; index++) {
      items.add(
        FooterSocialButton(
          iconSize: 10,
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

class FooterNavItem extends StatelessWidget {
  const FooterNavItem({Key? key, required this.title, required this.tapEvent}) : super(key: key);

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
