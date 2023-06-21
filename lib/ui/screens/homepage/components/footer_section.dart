import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/functions.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/buttons/nimbus_button.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/content_area.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

List<FooterItem> footerItems = [
  FooterItem(
    title: StringConst.PHONE_ME + ":",
    subtitle: StringConst.PHONE_NUMBER,
    iconData: FeatherIcons.phone,
  ),
  FooterItem(
    title: StringConst.MAIL_ME + ":",
    subtitle: StringConst.DEV_EMAIL_2,
    iconData: FontAwesomeIcons.paperPlane,
  ),
  FooterItem(
    title: StringConst.FOLLOW_ME_2 + ":",
    subtitle: StringConst.BEHANCE_ID,
    iconData: FontAwesomeIcons.behance,
  ),
];

class FooterSection extends StatefulWidget {
  FooterSection({Key? key});
  @override
  _FooterSectionState createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? footerTextStyle = textTheme.caption?.copyWith(
      color: AppColors.primaryText2,
      fontWeight: FontWeight.bold,
    );
    double screenWidth = widthOfScreen(context) - (getSidePadding(context) * 2);
    double screenHeight = heightOfScreen(context);
    double contentAreaWidth = screenWidth;
    double contentAreaHeight = responsiveSize(
      context,
      screenHeight,
      screenHeight * 0.7,
      md: screenHeight * 0.85,
      sm: screenHeight * 0.85,
    );

    return ContentArea(
      padding: EdgeInsets.symmetric(horizontal: getSidePadding(context)),
      child: Column(
        children: [
          ResponsiveBuilder(
            builder: (context, sizingInformation) {
              double screenWidth = sizingInformation.screenSize.width;

              if (screenWidth <= (RefinedBreakpoints().tabletNormal)) {
                return _buildFooterSectionSm(
                  width: contentAreaWidth,
                  height: contentAreaHeight,
                );
              } else {
                return _buildFooterSectionLg(
                  width: contentAreaWidth,
                  height: contentAreaHeight,
                );
              }
            },
          ),
          SizedBoxH20(),
          InkWell(
            onTap: () => openUrlLink(StringConst.WEB_GENIUS_LAB_URL),
            child: RichText(
              text: TextSpan(
                text: StringConst.RIGHTS_RESERVED + " ",
                style: footerTextStyle,
                children: [
                  TextSpan(text: StringConst.DESIGNED_BY + " "),
                  TextSpan(
                    text: StringConst.WEB_GENIUS_LAB,
                    style: footerTextStyle?.copyWith(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w900,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBoxH4(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: InkWell(
                    onTap: () => openUrlLink(StringConst.DAVID_LEGEND_URL),
                    child: RichText(
                      text: TextSpan(
                        text: StringConst.BUILT_BY + " ",
                        style: footerTextStyle,
                        children: [],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBoxH4(),
          SizedBoxH20(),
        ],
      ),
    );
  }

  List<Widget> _buildFooterItems(List<FooterItem> data, {bool isHorizontal = false}) {
    List<Widget> items = [];

    for (int index = 0; index < data.length; index++) {
      items.add(
        FooterItem(
          title: data[index].title,
          subtitle: data[index].subtitle,
          iconData: data[index].iconData,
        ),
      );
      if (index < data.length - 1) {
        if (isHorizontal) {
          items.add(Spacer(flex: 2));
        } else {
          items.add(SizedBoxH40());
        }
      }
    }
    return items;
  }

  Widget _buildFooterSectionSm({
    required double width,
    required double height,
  }) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return ContentArea(
      width: width,
      backgroundColor: AppColors.black400,
      borderRadius: const BorderRadius.all(
        Radius.circular(Sizes.RADIUS_8),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(Sizes.RADIUS_8),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -(height * 0.1),
              left: -(height * 0.15),
              child: Image.asset(
                ImagePath.BOX_COVER_GOLD,
                // width: width * 0.6 ,
                height: height * 0.5,
                // fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: -(height * 0.1),
              right: -(height * 0.1),
              child: Image.asset(
                ImagePath.BOX_COVER_BLACK,
                height: height * 0.6,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBoxH80(),
                  Text(
                    StringConst.LETS_TALK,
                    textAlign: TextAlign.center,
                    style: textTheme.headline4?.copyWith(color: AppColors.white),
                  ),
                  SizedBoxH60(),
                  ..._buildFooterItems(footerItems),
                  SizedBoxH60(),
                  NimbusButton(
                    buttonTitle: StringConst.HIRE_ME,
                    buttonColor: AppColors.maroon450,
                    onPressed: () {},
                  ),
                  SizedBoxH80(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterSectionLg({
    required double width,
    required double height,
  }) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        // ContentArea(
        //   child: NimbusInfoSection1(
        //     title1: StringConst.BLOG_SECTION_TITLE_1,
        //     title2: StringConst.BLOG_SECTION_TITLE_2,
        //     body: StringConst.BLOG_DESC,
        //   ),
        // ),
        ContentArea(
          child: NimbusInfoSection2(
            title1: StringConst.OUR_LOCATION,
            hasTitle2: false,
          ),
        ),
        ContentArea(
          width: width,
          height: height,
          backgroundColor: AppColors.black400,
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
        SizedBox(height: 100),
        ContentArea(
          width: width,
          height: height,
          backgroundColor: AppColors.black400,
          borderRadius: const BorderRadius.all(
            Radius.circular(Sizes.RADIUS_8),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(Sizes.RADIUS_8),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RichText(text: TextSpan(text: StringConst.FDS_ASYA_PH, style: GoogleFonts.poppins(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: AppColors.maroon450,
                          width: 500,
                          child: TextField(
                            cursorColor: Colors.white,
                            style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                // border: OutlineInputBorder(
                                //     borderRadius:
                                //         BorderRadius.all(Radius.circular(50))),
                                hintText: '   Enter a valid email address',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                                suffixIcon: InkWell(
                                  child: Icon(
                                    CupertinoIcons.paperplane_fill,
                                    size: 20,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RichText(text: TextSpan(text: StringConst.ABOUT_FDS_ASYA_PH1, style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal))),
                            SizedBox(height: 10),
                            RichText(text: TextSpan(text: StringConst.ABOUT_FDS_ASYA_PH2, style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal))),
                            SizedBox(height: 10),
                            RichText(text: TextSpan(text: StringConst.ABOUT_FDS_ASYA_PH3, style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal))),
                            SizedBox(height: 10),
                            RichText(text: TextSpan(text: StringConst.ABOUT_FDS_ASYA_PH4, style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal))),
                          ],
                        ),
                        SizedBoxW90(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RichText(text: TextSpan(text: StringConst.ABOUT_FDS_ASYA_PH5, style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal))),
                            SizedBox(height: 10),
                            RichText(text: TextSpan(text: StringConst.ABOUT_FDS_ASYA_PH6, style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal))),
                            SizedBox(height: 10),
                            RichText(text: TextSpan(text: StringConst.ABOUT_FDS_ASYA_PH8, style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal))),
                            SizedBox(height: 10),
                            RichText(text: TextSpan(text: StringConst.ABOUT_FDS_ASYA_PH7, style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal))),
                          ],
                        ),
                        SizedBoxW90(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RichText(text: TextSpan(text: StringConst.ABOUT_FDS_ASYA_PH9, style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal))),
                            SizedBox(height: 10),
                            RichText(text: TextSpan(text: StringConst.ABOUT_FDS_ASYA_PH10, style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal))),
                            SizedBox(height: 10),
                            RichText(text: TextSpan(text: StringConst.ABOUT_FDS_ASYA_PH11, style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal))),
                            SizedBox(height: 10),
                            RichText(text: TextSpan(text: StringConst.ABOUT_FDS_ASYA_PH12, style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal))),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                // Positioned(
                //   top: -(height * 0.15),
                //   left: -(height * 0.15),
                //   child: Image.asset(
                //     ImagePath.BOX_COVER_GOLD,
                //     // width: width ,
                //     height: height * 0.5,
                //     // fit: BoxFit.fill,
                //   ),
                // ),
                // Positioned(
                //   top: -(height * 0.15),
                //   right: -(height * 0.1),
                //   // bottom: -25,
                //   child: Image.asset(
                //     ImagePath.BOX_COVER_BLACK,
                //     height: height * 1.25,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                // Column(
                //   children: [
                //     Spacer(flex: 2),
                //     Text(
                //       StringConst.LETS_TALK,
                //       style: textTheme.headlineMedium
                //           ?.copyWith(color: AppColors.white),
                //     ),
                //     Spacer(),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Spacer(flex: 3),
                //         ..._buildFooterItems(footerItems, isHorizontal: true),
                //         Spacer(flex: 3),
                //       ],
                //     ),
                //     Spacer(),
                //     NimBusButtonLink(
                //       url: StringConst.EMAIL_URL,
                //       buttonTitle: StringConst.HIRE_ME,
                //       buttonColor: AppColors.maroon450,
                //     ),
                //     Spacer(flex: 2),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class FooterItem extends StatelessWidget {
  FooterItem({
    required this.iconData,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Icon(
          iconData,
          color: AppColors.maroon450,
          size: Sizes.ICON_SIZE_36,
        ),
        SizedBoxH8(),
        Text(
          title,
          style: textTheme.bodyMedium?.copyWith(
            color: AppColors.white,
          ),
        ),
        SizedBoxH8(),
        Text(
          subtitle,
          style: textTheme.bodyText1?.copyWith(
            color: AppColors.grey250,
          ),
        ),
      ],
    );
  }
}
