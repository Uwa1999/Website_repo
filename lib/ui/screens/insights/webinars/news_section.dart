import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsDescSection extends StatefulWidget {
  const NewsDescSection({Key? key}) : super(key: key);

  @override
  State<NewsDescSection> createState() => _NewsDescSectionState();
}

class _NewsDescSectionState extends State<NewsDescSection> {
  @override
  Widget build(BuildContext context) {
    return (!isMobile(context)) == (!isTab(context)) ? DesktopNewsDescScreen() : MobileArticleNewsDescScreen();
  }
}

//Desktop Screen
class DesktopNewsDescScreen extends StatefulWidget {
  const DesktopNewsDescScreen({Key? key}) : super(key: key);

  @override
  State<DesktopNewsDescScreen> createState() => _DesktopNewsDescScreenState();
}

class _DesktopNewsDescScreenState extends State<DesktopNewsDescScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: Sizes.PADDING_100,
            right: Sizes.PADDING_150,
          ),
          height: MediaQuery.of(context).size.height * 0.7,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(ImagePath.WEBINARS_HEADER),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBoxH150(),
              SizedBoxH150(),
              SizedBoxH30(),
              NimbusInfoInsightTitle(
                title1: StringConst.NEWS_DESC_TITLE,
                hasTitle2: false,
                body: StringConst.NEWS_DESC_SUBTITLE1,
                title1Style: GoogleFonts.poppins(
                  fontSize: Sizes.TEXT_SIZE_35,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//Mobile Screen
class MobileArticleNewsDescScreen extends StatefulWidget {
  const MobileArticleNewsDescScreen({Key? key}) : super(key: key);

  @override
  State<MobileArticleNewsDescScreen> createState() => _MobileArticleNewsDescScreenState();
}

class _MobileArticleNewsDescScreenState extends State<MobileArticleNewsDescScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: Sizes.PADDING_20,
            right: Sizes.PADDING_20,
          ),
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.maroon03.withOpacity(1.0),
                AppColors.maroon05.withOpacity(0.8),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBoxH130(),
              Padding(
                padding: const EdgeInsets.only(
                  left: Sizes.PADDING_20,
                  right: Sizes.PADDING_20,
                ),
                child: NimbusInfoInsightTitle(
                  title1: StringConst.NEWS_DESC_TITLE,
                  hasTitle2: false,
                  body: StringConst.NEWS_DESC_SUBTITLE1,
                  title1Style: GoogleFonts.poppins(
                    fontSize: Sizes.TEXT_SIZE_18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}