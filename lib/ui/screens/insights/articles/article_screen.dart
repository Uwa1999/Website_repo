import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';

class ArticleDescScreen extends StatefulWidget {
  const ArticleDescScreen({Key? key}) : super(key: key);

  @override
  State<ArticleDescScreen> createState() => _ArticleDescScreenState();
}

class _ArticleDescScreenState extends State<ArticleDescScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: Sizes.PADDING_100,
            right: Sizes.PADDING_150,
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
              SizedBoxH100(),
              NimbusInfoSection3(
                title1: StringConst.ARTICLE_DESC_TITLE,
                hasTitle2: false,
                body: StringConst.ARTICLE_DESC_SUBTITLE1,
                // child: Wrap(
                //   spacing: kSpacing,
                //   runSpacing: kRunSpacing,
                //   children: _buildProductServicesCategories(productServicesCategories),
                // ),
              ),
            ],
          ),
        ),
        SizedBoxH50(),
        Container(
          padding: EdgeInsets.only(
            left: Sizes.PADDING_100,
            right: Sizes.PADDING_100,
          ),
          height: MediaQuery.of(context).size.height * 0.4,
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
            body: StringConst.ARTICLE_DESC1,
            // child: Wrap(
            //   spacing: kSpacing,
            //   runSpacing: kRunSpacing,
            //   children: _buildProductServicesCategories(productServicesCategories),
            // ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: Sizes.PADDING_100,
            right: Sizes.PADDING_120,
          ),
          height: MediaQuery.of(context).size.height * 0.3,
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
          child: NimbusInfoSection5(
            title1: StringConst.ARTICLE_DESC_SUBTITLE2,
            hasTitle2: false,
            body: StringConst.ARTICLE_DESC2,
            // child: Wrap(
            //   spacing: kSpacing,
            //   runSpacing: kRunSpacing,
            //   children: _buildProductServicesCategories(productServicesCategories),
            // ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: Sizes.PADDING_100,
            right: Sizes.PADDING_100,
          ),
          height: MediaQuery.of(context).size.height * 0.3,
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
          child: NimbusInfoSection5(
            title1: StringConst.ARTICLE_DESC_SUBTITLE3,
            hasTitle2: false,
            body: StringConst.ARTICLE_DESC3,
            // child: Wrap(
            //   spacing: kSpacing,
            //   runSpacing: kRunSpacing,
            //   children: _buildProductServicesCategories(productServicesCategories),
            // ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: Sizes.PADDING_100,
            right: Sizes.PADDING_100,
          ),
          height: MediaQuery.of(context).size.height * 0.3,
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
          child: NimbusInfoSection5(
            title1: StringConst.ARTICLE_DESC_SUBTITLE4,
            hasTitle2: false,
            body: StringConst.ARTICLE_DESC4,
            // child: Wrap(
            //   spacing: kSpacing,
            //   runSpacing: kRunSpacing,
            //   children: _buildProductServicesCategories(productServicesCategories),
            // ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: Sizes.PADDING_100,
            right: Sizes.PADDING_100,
          ),
          height: MediaQuery.of(context).size.height * 0.3,
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
          child: NimbusInfoSection5(
            title1: StringConst.ARTICLE_DESC_SUBTITLE5,
            hasTitle2: false,
            body: StringConst.ARTICLE_DESC5,
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
