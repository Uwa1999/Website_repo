import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsDescScreen extends StatefulWidget {
  const NewsDescScreen({Key? key}) : super(key: key);

  @override
  State<NewsDescScreen> createState() => _NewsDescScreenState();
}

class _NewsDescScreenState extends State<NewsDescScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
              // image: DecorationImage(
              //   fit: BoxFit.cover,
              //   image: AssetImage(ImagePath.SIGNS_MOA),
              // ),
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
                SizedBoxH150(),
                SizedBoxH40(),
                NimbusInfoSection3(
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
        ),
        SizedBoxH30(),
        Container(
          padding: EdgeInsets.only(
            left: Sizes.PADDING_100,
            right: Sizes.PADDING_100,
          ),
          height: MediaQuery.of(context).size.height * 1.2,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                AppColors.white.withOpacity(0.9),
                AppColors.white.withOpacity(0.5),
              ],
            ),
          ),
          child: NimbusInfoSection4(
            title1: '',
            hasTitle2: false,
            body: StringConst.NEWS_DESC1,
            // child: Wrap(
            //   spacing: kSpacing,
            //   runSpacing: kRunSpacing,
            //   children: _buildProductServicesCategories(productServicesCategories),
            // ),
          ),
        ),
      ],
    );
  }
}
