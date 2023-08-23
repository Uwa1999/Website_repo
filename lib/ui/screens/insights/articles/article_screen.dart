import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleDescScreen extends StatefulWidget {
  const ArticleDescScreen({Key? key}) : super(key: key);

  @override
  State<ArticleDescScreen> createState() => _ArticleDescScreenState();
}

class _ArticleDescScreenState extends State<ArticleDescScreen> {
  @override
  Widget build(BuildContext context) {
    return (!isMobile(context)) == (!isTab(context)) ? DesktopArticleDescScreen() : MobileArticleDescScreen();
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
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  left: Sizes.PADDING_100,
                  right: Sizes.PADDING_150,
                ),
                height: MediaQuery.of(context).size.height * 0.7,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(ImagePath.ARTICLE_HEADER),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBoxH150(),
                    SizedBoxH150(),
                    SizedBoxH80(),
                    NimbusInfoSection3(
                      title1: StringConst.ARTICLE_DESC_TITLE,
                      hasTitle2: false,
                      body: StringConst.ARTICLE_DESC_SUBTITLE1,
                      title1Style: GoogleFonts.poppins(
                        fontSize: Sizes.TEXT_SIZE_28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBoxH50(),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Sizes.PADDING_100,
                      right: Sizes.PADDING_100,
                    ),
                    child: NimbusInfoSection4(
                      title1: '',
                      hasTitle2: false,
                      body: StringConst.ARTICLE_DESC1,
                    ),
                  ),
                ),
                SizedBoxH20(),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Sizes.PADDING_100,
                      right: Sizes.PADDING_100,
                    ),
                    child: NimbusInfoSection5(
                      title1: StringConst.ARTICLE_DESC_SUBTITLE2,
                      hasTitle2: false,
                      body: StringConst.ARTICLE_DESC2,
                      title1Style: GoogleFonts.poppins(
                        fontSize: Sizes.TEXT_SIZE_28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
                SizedBoxH20(),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Sizes.PADDING_100,
                      right: Sizes.PADDING_100,
                    ),
                    child: NimbusInfoSection5(
                      title1: StringConst.ARTICLE_DESC_SUBTITLE3,
                      hasTitle2: false,
                      body: StringConst.ARTICLE_DESC3,
                      title1Style: GoogleFonts.poppins(
                        fontSize: Sizes.TEXT_SIZE_28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
                SizedBoxH20(),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Sizes.PADDING_100,
                      right: Sizes.PADDING_100,
                    ),
                    child: NimbusInfoSection5(
                      title1: StringConst.ARTICLE_DESC_SUBTITLE4,
                      hasTitle2: false,
                      body: StringConst.ARTICLE_DESC4,
                      title1Style: GoogleFonts.poppins(
                        fontSize: Sizes.TEXT_SIZE_28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
                SizedBoxH20(),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Sizes.PADDING_100,
                      right: Sizes.PADDING_100,
                    ),
                    child: NimbusInfoSection5(
                      title1: StringConst.ARTICLE_DESC_SUBTITLE5,
                      hasTitle2: false,
                      body: StringConst.ARTICLE_DESC5,
                      title1Style: GoogleFonts.poppins(
                        fontSize: Sizes.TEXT_SIZE_28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
                SizedBoxH50(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

//Mobile Screen
class MobileArticleDescScreen extends StatefulWidget {
  const MobileArticleDescScreen({Key? key}) : super(key: key);

  @override
  State<MobileArticleDescScreen> createState() => _MobileArticleDescScreenState();
}

class _MobileArticleDescScreenState extends State<MobileArticleDescScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Sizes.PADDING_100,
                right: Sizes.PADDING_150,
              ),
              height: MediaQuery.of(context).size.height * 0.6,
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
                  SizedBoxH150(),
                  SingleChildScrollView(
                    child: NimbusInfoSection3(
                      title1: StringConst.ARTICLE_DESC_TITLE,
                      hasTitle2: false,
                      body: StringConst.ARTICLE_DESC_SUBTITLE1,
                      title1Style: GoogleFonts.poppins(
                        fontSize: Sizes.TEXT_SIZE_20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBoxH50(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBoxH50(),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Sizes.PADDING_100,
                      right: Sizes.PADDING_120,
                    ),
                    child: NimbusInfoSection4(
                      title1: '',
                      hasTitle2: false,
                      body: StringConst.ARTICLE_DESC1,
                    ),
                  ),
                ),
                SizedBoxH20(),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Sizes.PADDING_100,
                      right: Sizes.PADDING_120,
                    ),
                    child: NimbusInfoSection5(
                      title1: StringConst.ARTICLE_DESC_SUBTITLE2,
                      hasTitle2: false,
                      body: StringConst.ARTICLE_DESC2,
                      title1Style: GoogleFonts.poppins(
                        fontSize: Sizes.TEXT_SIZE_18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
                SizedBoxH20(),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Sizes.PADDING_100,
                      right: Sizes.PADDING_120,
                    ),
                    child: NimbusInfoSection5(
                      title1: StringConst.ARTICLE_DESC_SUBTITLE3,
                      hasTitle2: false,
                      body: StringConst.ARTICLE_DESC3,
                      title1Style: GoogleFonts.poppins(
                        fontSize: Sizes.TEXT_SIZE_18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
                SizedBoxH20(),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Sizes.PADDING_100,
                      right: Sizes.PADDING_120,
                    ),
                    child: NimbusInfoSection5(
                      title1: StringConst.ARTICLE_DESC_SUBTITLE4,
                      hasTitle2: false,
                      body: StringConst.ARTICLE_DESC4,
                      title1Style: GoogleFonts.poppins(
                        fontSize: Sizes.TEXT_SIZE_18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
                SizedBoxH20(),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Sizes.PADDING_100,
                      right: Sizes.PADDING_120,
                    ),
                    child: NimbusInfoSection5(
                      title1: StringConst.ARTICLE_DESC_SUBTITLE5,
                      hasTitle2: false,
                      body: StringConst.ARTICLE_DESC5,
                      title1Style: GoogleFonts.poppins(
                        fontSize: Sizes.TEXT_SIZE_18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
                SizedBoxH50(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
