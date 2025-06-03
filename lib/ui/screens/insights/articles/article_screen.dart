import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleDescScreenInside extends StatefulWidget {
  const ArticleDescScreenInside({Key? key}) : super(key: key);

  @override
  State<ArticleDescScreenInside> createState() => _ArticleDescScreenInsideState();
}

class _ArticleDescScreenInsideState extends State<ArticleDescScreenInside> {
  @override
  Widget build(BuildContext context) {
    return (!isMobile(context)) == (!isTab(context)) ? DesktopArticleDescScreen() : MobileArticleDescSection();
  }
}

//Desktop Screen
class DesktopArticleDescScreen extends StatefulWidget {
  const DesktopArticleDescScreen({Key? key}) : super(key: key);

  @override
  State<DesktopArticleDescScreen> createState() => _DesktopArticleDescScreenState();
}

class _DesktopArticleDescScreenState extends State<DesktopArticleDescScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 2000,
        width: double.infinity,
        child: Column(
          children: [
            SizedBoxH30(),
            Padding(
              padding: EdgeInsets.only(
                left: Sizes.PADDING_100,
                right: Sizes.PADDING_100,
              ),
              child: NimbusInfoInsightSection(
                // title1: StringConst.ARTICLE_DESC_SUBTITLE5,
                hasTitle2: false,
                body: StringConst.ARTICLE_DESC5,
                title1Style: GoogleFonts.poppins(
                  fontSize: Sizes.TEXT_SIZE_28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
            ),
            SizedBoxH50(),
          ],
        ),
      ),
    );
  }
}

//Mobile Screen
class MobileArticleDescSection extends StatefulWidget {
  const MobileArticleDescSection({Key? key}) : super(key: key);

  @override
  State<MobileArticleDescSection> createState() => _MobileArticleDescSectionState();
}

class _MobileArticleDescSectionState extends State<MobileArticleDescSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children:  [
            SizedBoxH30(),
            Padding(
              padding: EdgeInsets.only(
                left: Sizes.PADDING_40,
                right: Sizes.PADDING_40,
              ),
              child: NimbusInfoInsightSection(
                // title1: StringConst.ARTICLE_DESC_SUBTITLE5,
                hasTitle2: false,
                body: StringConst.ARTICLE_DESC5,
                title1Style: GoogleFonts.poppins(
                  fontSize: Sizes.TEXT_SIZE_28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
            ),
            SizedBoxH50(),
          ],
      ),
    );
  }
}
